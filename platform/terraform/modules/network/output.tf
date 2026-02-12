output "vpc_id" {
  description = "ID of the created VPC"
  value       = digitalocean_vpc.main.id
}


output "frontend_firewall_id" {
  description = "ID of frontend firewall"
  value       = digitalocean_firewall.frontend.id
}

output "db_firewall_id" {
  description = "ID of database firewall"
  value       = digitalocean_firewall.db.id
}


output "network_urns" {
  value = [
    "do:firewall:${digitalocean_firewall.frontend.id}",
    "do:firewall:${digitalocean_firewall.db.id}"
  ]
}

output "vpc_cidr" {
  value = digitalocean_vpc.main.ip_range
}


