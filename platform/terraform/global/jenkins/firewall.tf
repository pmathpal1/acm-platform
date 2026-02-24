
resource "digitalocean_firewall" "jenkins" {
  name = "${var.environment}-jenkins-fw"

  tags = [digitalocean_tag.jenkins.name]





  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = [var.admin_ip]
  }


  inbound_rule {
    protocol         = "tcp"
    port_range       = "8080"
    source_addresses = [var.admin_ip]
  }


  inbound_rule {
    protocol    = "tcp"
    port_range  = "50000"
    source_tags = ["jenkins"]
  }


  outbound_rule {
    protocol              = "tcp"
    port_range            = "all"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "all"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
