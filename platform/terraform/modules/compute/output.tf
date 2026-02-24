output "swarm_manager_public_ips" {
  description = "Public IPs of Swarm manager nodes"
  value = [
    for d in digitalocean_droplet.swarm_managers :
    d.ipv4_address
  ]
}


/*
output "frontend_worker_public_ips" {
  description = "Public IPs of frontend worker nodes"
  value = [
    for d in values(digitalocean_droplet.frontend_workers) :
    d.ipv4_address
  ]
}
*/

output "frontend_worker_public_ips" {
  description = "Public IPs of frontend worker droplets"
  value = {
    for name, droplet in digitalocean_droplet.frontend_workers :
    name => droplet.ipv4_address
  }
}



output "mysql_db_public_ips" {
  description = "Public IPs of MySQL DB nodes"
  value = [
    for d in digitalocean_droplet.mysql_db :
    d.ipv4_address
  ]
}

output "mongo_db_public_ips" {
  description = "Public IPs of MongoDB nodes"
  value = [
    for d in digitalocean_droplet.mongo_db :
    d.ipv4_address
  ]
}

output "postgres_db_public_ips" {
  description = "Public IPs of PostgreSQL DB nodes"
  value = [
    for d in digitalocean_droplet.postgres_db :
    d.ipv4_address
  ]
}
############################################################
output "redis_db_public_ips" {
  description = "Public IPs of Redis DB nodes"
  value = [
    for d in digitalocean_droplet.redis_db :
    d.ipv4_address
  ]
}

output "droplet_urns" {
  value = concat(
    [for d in digitalocean_droplet.swarm_managers : d.urn],
    [for d in digitalocean_droplet.frontend_workers : d.urn],
    [for d in digitalocean_droplet.mysql_db : d.urn],
    [for d in digitalocean_droplet.mongo_db : d.urn],
    [for d in digitalocean_droplet.postgres_db : d.urn],
    [for d in digitalocean_droplet.redis_db : d.urn]


  )
}

output "tag_swarm_workers_front" {
  value = local.tag_swarm_workers_front
}
