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

  lb_name = "${local.base_name}-dashboard-lb"
}

resource "digitalocean_loadbalancer" "this" {

  name   = local.lb_name
  region = var.region

  vpc_uuid = var.vpc_id

  forwarding_rule {
    entry_protocol  = var.lb_protocol
    entry_port      = var.lb_port
    target_protocol = var.lb_protocol
    target_port     = var.lb_target_port
  }

  healthcheck {
    protocol                 = "http"
    port                     = var.lb_target_port
    path                     = var.healthcheck_path
    check_interval_seconds   = 10
    response_timeout_seconds = 5
    healthy_threshold        = 3
    unhealthy_threshold      = 3
  }

  
  droplet_tag = var.frontend_tag
}
