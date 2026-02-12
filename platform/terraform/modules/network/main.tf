terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


resource "digitalocean_vpc" "main" {
  name        = var.vpc_name
  region      = var.region
  ip_range    = var.vpc_ip_range
  description = var.vpc_description
}

resource "digitalocean_tag" "frontend" {
  for_each = toset(var.frontend_tags)
  name     = each.value
}

#################################################

resource "digitalocean_tag" "db" {
  for_each = toset(var.db_tags)
  name     = each.value
}
