output "lb_urn" {
  description = "Load balancer URN for project attachment"
  value       = digitalocean_loadbalancer.this.urn
}

output "lb_ip" {
  description = "Public IP address of load balancer"
  value       = digitalocean_loadbalancer.this.ip
}

output "lb_name" {
  description = "Load balancer name"
  value       = digitalocean_loadbalancer.this.name
}
