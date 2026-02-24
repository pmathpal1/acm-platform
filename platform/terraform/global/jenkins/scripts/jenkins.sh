#!/bin/bash
set -eux

export DEBIAN_FRONTEND=noninteractive

# --------------------------------------------------
# Update package index
# --------------------------------------------------
apt-get update -y

# --------------------------------------------------
# Install base dependencies
# --------------------------------------------------
apt-get install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  apt-transport-https \
  software-properties-common

# --------------------------------------------------
# Install Docker
# --------------------------------------------------

mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" \
> /etc/apt/sources.list.d/docker.list

apt-get update -y

apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

systemctl daemon-reload
systemctl enable docker
systemctl start docker

# Allow root to use docker
usermod -aG docker root || true

# --------------------------------------------------
# Install Java (Required for Jenkins)
# --------------------------------------------------
apt-get install -y openjdk-17-jdk

# --------------------------------------------------
# Install Jenkins (Correct 2026 Method)
# --------------------------------------------------

mkdir -p /usr/share/keyrings

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key \
  | gpg --dearmor -o /usr/share/keyrings/jenkins.gpg

echo "deb [signed-by=/usr/share/keyrings/jenkins.gpg] \
https://pkg.jenkins.io/debian-stable binary/" \
> /etc/apt/sources.list.d/jenkins.list

apt-get update -y
apt-get install -y jenkins

systemctl daemon-reload
systemctl enable jenkins
systemctl start jenkins