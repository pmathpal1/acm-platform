terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


locals {

  base_name = "tst-${var.project_name}-${var.environment}"
  tag_swarm_managers      = "${local.base_name}-swarm-managers"
  tag_swarm_workers_front = "${local.base_name}-swarm-workers-front"
  tag_mysql_db    = "${local.base_name}-mysql-db"
  tag_mongo_db    = "${local.base_name}-mongo-db"
  tag_postgres_db = "${local.base_name}-postgres-db"
  tag_redis_db = "${local.base_name}-redis-db"

  frontend_workers_instances = merge([
  for worker_name, worker_cfg in var.frontend_workers : {
    for i in range(worker_cfg.count) :
    "${worker_name}-${i + 1}" => {
      name = worker_name
      size = worker_cfg.size
    }
  }
]...)

}
########################################################################
resource "digitalocean_droplet" "swarm_managers" {
  count = var.manager_count

  name   = "${local.base_name}-swarm-manager-${count.index + 1}"
  region = var.region
  size   = var.droplet_size
  image  = var.linux_base_image

  vpc_uuid = var.vpc_id

  tags = [
    local.tag_swarm_managers,
    var.project_name,
    var.environment
  ]

  ssh_keys = var.ssh_key_ids
}
#######################################################################
/*
resource "digitalocean_droplet" "frontend_workers" {
  for_each = toset(var.frontend_worker_names)

  name   = "${local.base_name}-${each.value}"
  region = var.region
  size   = var.droplet_size
  image  = var.linux_base_image

  vpc_uuid = var.vpc_id

  tags = [
    local.tag_swarm_workers_front,
    var.project_name,
    var.environment
  ]

  ssh_keys = var.ssh_key_ids
}
*/
###########################################################################
resource "digitalocean_droplet" "mysql_db" {
  count = var.mysql_count

  name   = "${local.base_name}-mysql-db-${count.index + 1}"
  region = var.region
  size   = var.droplet_size
  image  = var.linux_base_image

  vpc_uuid = var.vpc_id

  tags = [
    local.tag_mysql_db,
    var.project_name,
    var.environment
  ]

  ssh_keys = var.ssh_key_ids
}
################################################################
resource "digitalocean_droplet" "mongo_db" {
  count = var.mongo_count

  name   = "${local.base_name}-mongo-db-${count.index + 1}"
  region = var.region
  size   = var.droplet_size
  image  = var.linux_base_image

  vpc_uuid = var.vpc_id

  tags = [
    local.tag_mongo_db,
    var.project_name,
    var.environment
  ]

  ssh_keys = var.ssh_key_ids
}
#################################################################
resource "digitalocean_droplet" "redis_db" {
  count = var.redis_count

  name   = "${local.base_name}-redis-db-${count.index + 1}"
  region = var.region
  size   = var.droplet_size
  image  = var.linux_base_image

  vpc_uuid = var.vpc_id

  tags = [
    local.tag_redis_db,
    var.project_name,
    var.environment
  ]

  ssh_keys = var.ssh_key_ids
}



######################################################################
resource "digitalocean_droplet" "postgres_db" {
  count = var.postgres_count

  name   = "${local.base_name}-postgres-db-${count.index + 1}"
  region = var.region
  size   = var.droplet_size
  image  = var.linux_base_image

  vpc_uuid = var.vpc_id

  tags = [
    local.tag_postgres_db,
    var.project_name,
    var.environment
  ]

  ssh_keys = var.ssh_key_ids
}




resource "digitalocean_droplet" "frontend_workers" {
  for_each = local.frontend_workers_instances

  name   = "${local.base_name}-${each.key}"
  region = var.region
  size   = each.value.size
  image  = var.linux_base_image

  vpc_uuid = var.vpc_id

  tags = [
    local.tag_swarm_workers_front,
    var.project_name,
    var.environment
  ]

  ssh_keys = var.ssh_key_ids
}
