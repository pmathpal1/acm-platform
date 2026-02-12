output "swarm_manager_public_ips" {
  value = module.compute.swarm_manager_public_ips
}
/*
output "manager_public_ips" {
  value = module.compute.swarm_manager_public_ips
}
*/

output "frontend_worker_public_ips" {
  value = module.compute.frontend_worker_public_ips
}


output "mysql_db_public_ips" {
  value = module.compute.mysql_db_public_ips
}

output "mongo_db_public_ips" {
  value = module.compute.mongo_db_public_ips
}

output "postgres_db_public_ips" {
  value = module.compute.postgres_db_public_ips
}


output "loadbalancer_ip" {
  value       = module.loadbalancer.lb_ip
}


output "redis_db_public_ips" {
  value = module.compute.redis_db_public_ips
}

output "vpc_cidr" {
  value = module.network.vpc_cidr
}
