resource "digitalocean_vpc" "global" {
  name   = "global-services-vpc"
  region = var.region

  ip_range = var.vpc_cidr
}
