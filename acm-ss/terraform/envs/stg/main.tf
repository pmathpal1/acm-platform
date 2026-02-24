data "digitalocean_ssh_keys" "all" {}

module "network" {
  source = "../../../../platform/terraform/modules/network"


  vpc_name        = var.vpc_name
  region          = var.region
  vpc_ip_range    = var.vpc_ip_range
  vpc_description = var.vpc_description

  
  frontend_firewall_name = var.frontend_firewall_name
  db_firewall_name       = var.db_firewall_name
  allowed_sources        = var.allowed_sources
  frontend_tags          = var.frontend_tags
  db_tags                = var.db_tags
}
#############################################################

module "compute" {
  source = "../../../../platform/terraform/modules/compute"


  project_name = var.project_name
  environment  = var.environment
  region       = var.region

  vpc_id = module.network.vpc_id

  ssh_key_ids = data.digitalocean_ssh_keys.all.ssh_keys[*].id

  
  droplet_size     = var.droplet_size
  linux_base_image = var.linux_base_image
  mongo_image      = var.mongo_image

  manager_count = var.manager_count

  
  #frontend_worker_names = var.frontend_worker_names
frontend_workers = var.frontend_workers
  mysql_count    = var.mysql_count
  mongo_count    = var.mongo_count
  postgres_count = var.postgres_count
  redis_count =   var.redis_count

}
###################################################

module "project" {
  source = "../../../../platform/terraform/modules/project"

  project_name = var.project_do_name

  resource_urns = concat(
    module.compute.droplet_urns,
    module.network.network_urns,
    [module.loadbalancer.lb_urn]
  )
}
####################################################################

module "loadbalancer" {
  source = "../../../../platform/terraform/modules/loadbalancer"

  project_name = var.project_name
  environment  = var.environment

  region = var.region
  vpc_id = module.network.vpc_id

  frontend_tag = module.compute.tag_swarm_workers_front

  
  lb_protocol    = var.lb_protocol
  lb_port        = var.lb_port
  lb_target_port = var.lb_target_port



}               