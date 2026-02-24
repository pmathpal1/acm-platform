output "jenkins_public_ip" {
  description = "Public IP address of the Jenkins controller droplet"
  value       = digitalocean_droplet.jenkins.ipv4_address
}




