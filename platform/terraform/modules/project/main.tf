terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


data "digitalocean_project" "main" {
  name = var.project_name
}

resource "digitalocean_project_resources" "attach" {
  project = data.digitalocean_project.main.id

  resources = var.resource_urns
}