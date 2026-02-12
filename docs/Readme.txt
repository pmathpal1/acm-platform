1. Overview

---

This project provisions and configures a **Docker Swarm cluster on DigitalOcean**
using a full Infrastructure-as-Code workflow:

• Terraform → creates cloud infrastructure
• Ansible → installs Docker and configures Swarm
• Docker Swarm → runs distributed containerized services

The setup supports **multiple environments**:

• dev
• stg
• prod

Each environment has isolated:

• Terraform state
• variables
• dynamic Ansible inventory
• but shares reusable Ansible roles

---

2. High-Level Architecture Flow

---

Terraform → Creates Infrastructure
↓
Dynamic Inventory → Provides hosts to Ansible
↓
Ansible Roles →
• Install Docker
• swarm_manager_init
• swarm_manager_join
• swarm_validatevalidate
↓
Docker Swarm Cluster Ready for Deployments

---

3. Terraform Infrastructure

---

Terraform provisions all required DigitalOcean resources:

### VPC

Creates a private network (example: 10.x.x.x/16) used for:

• Swarm internal communication
• database connectivity
• secure service networking

---

### Droplets

**Swarm Managers**
• Configurable count (recommended: 3)
• Provide HA quorum control plane

**Frontend Workers**
• Run application services
• Named per workload (trk, ai, dashboard, etc.)

**Database Nodes**
Dedicated droplets for:

• MySQL
• MongoDB
• PostgreSQL
• Redis

---

### Firewalls

Restrict access using:

• allowed public IPs for SSH
• private VPC access for internal services
• required Swarm ports:

2377/tcp   → cluster management
7946/tcp/udp → node communication
4789/udp   → overlay networking

---

### Load Balancer

Public entry point:

HTTP :80 → forwards to worker nodes

Used later by reverse proxy or Swarm services.

---

### Tags & Project Grouping

DigitalOcean tags are used for:

• firewall targeting
• dynamic inventory grouping
• logical resource organization

---

4. Ansible Configuration

---

Directory structure:

ansible/
     
├── group_vars/
├── inventories/ (dev/stg/prod dynamic inventory)
├── playbooks/
│   ├── install-docker.yml
│   ├── swarm-init-join.yml
│   └── swarm-validate.yml
└── roles/
├── docker/
├── swarm_manager_init/
├── swarm_manager_join/
├── swarm_worker_join/
└── swarm_validate/

Key design rule:

**Roles = reusable logic**
**Playbooks = orchestration entrypoints**

---
###############################################################

docker service create \
  --name web-nginx \
  --replicas 2 \
  --publish 80:80 \
  nginx:latest
===============================================================================================

---
- name: Ensure mongod.conf enables authorization and secure bind IP
  block:

    - name: Update mongod.conf security and network settings
      replace:
        path: /etc/mongod.conf
        regexp: "{{ item.regexp }}"
        replace: "{{ item.replace }}"
      loop:
        - regexp: '^(\s*)bindIp:.*'
          replace: '\1bindIp: 0.0.0.0'
        - regexp: '^(\s*)#?authorization:.*'
          replace: '\1authorization: enabled'

    - name: Restart MongoDB after enabling authentication
      systemd:
        name: mongod
        state: restarted

    - name: Wait for MongoDB to come back online
      command: mongosh --quiet --eval "db.adminCommand('ping')"
      register: mongo_wait
      retries: 10
      delay: 3
      until: mongo_wait.rc == 0
      changed_when: false
