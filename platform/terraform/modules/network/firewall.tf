resource "digitalocean_firewall" "frontend" {
  name = var.frontend_firewall_name

  tags = var.frontend_tags


  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = var.allowed_sources
  }

  
  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }


  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }



  inbound_rule {
    protocol    = "tcp"
    port_range  = "2377"
    source_tags = concat(var.frontend_tags, var.db_tags)
  }

  inbound_rule {
    protocol    = "tcp"
    port_range  = "7946"
    source_tags = concat(var.frontend_tags, var.db_tags)
  }

  inbound_rule {
    protocol    = "udp"
    port_range  = "7946"
    source_tags = concat(var.frontend_tags, var.db_tags)
  }

  inbound_rule {
    protocol    = "udp"
    port_range  = "4789"
    source_tags = concat(var.frontend_tags, var.db_tags)
  }



  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
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


depends_on = [
  digitalocean_tag.frontend,
  digitalocean_tag.db
]
}
#####################################################################

resource "digitalocean_firewall" "db" {
  name = var.db_firewall_name

  tags = var.db_tags

  
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = var.allowed_sources
  }


  inbound_rule {
    protocol    = "tcp"
    port_range  = "3306"
    source_tags = var.frontend_tags
  }


  inbound_rule {
    protocol    = "tcp"
    port_range  = "27017"
    source_tags = var.frontend_tags
  }

  
  inbound_rule {
    protocol    = "tcp"
    port_range  = "5432"
    source_tags = var.frontend_tags
  }



  inbound_rule {
    protocol    = "tcp"
    port_range  = "2377"
    source_tags = concat(var.frontend_tags, var.db_tags)
  }

  inbound_rule {
    protocol    = "tcp"
    port_range  = "7946"
    source_tags = concat(var.frontend_tags, var.db_tags)
  }

  inbound_rule {
    protocol    = "udp"
    port_range  = "7946"
    source_tags = concat(var.frontend_tags, var.db_tags)
  }

  inbound_rule {
    protocol    = "udp"
    port_range  = "4789"
    source_tags = concat(var.frontend_tags, var.db_tags)
  }

 

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
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


depends_on = [
  digitalocean_tag.frontend,
  digitalocean_tag.db
]
}              