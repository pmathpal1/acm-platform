region          = "blr1"
vpc_name        = "tst-acm-ss-dev-vpc"
vpc_ip_range    = "10.20.0.0/16"
vpc_description = "VPC for ACMSS Dev"
#############################################
frontend_firewall_name = "tst-acm-ss-dev-front-fw"
db_firewall_name       = "tst-acm-ss-dev-db-fw"
#################################################
allowed_sources = [
  "203.122.50.50/32",
  "14.195.41.246/32",
  "64.226.109.192/32",
  "159.223.76.35/32",
  "3.109.191.183/32",

]
#################################################################
frontend_tags = [
  "tst-acm-ss-dev-swarm-managers",
  "tst-acm-ss-dev-swarm-workers-front"
]
#################################################################

db_tags = [
  "tst-acm-ss-dev-mysql-db",
  "tst-acm-ss-dev-mongo-db",
  "tst-acm-ss-dev-postgres-db",
  "tst-acm-ss-dev-redis-db"

]
#################################################################
project_name = "acm-ss"
environment  = "dev"
##################################################################
droplet_size     = "s-1vcpu-1gb"
linux_base_image = "ubuntu-24-04-x64"
mongo_image      = "ubuntu-22-04-x64"
####################################################################
manager_count = 3
#################################################################
mysql_count    = 0
mongo_count    = 1
postgres_count = 1
redis_count    = 0
#####################################################
/*
frontend_worker_names = [
  "trk",
  "ai",
  "dashboard"
]
*/
######################################################
project_do_name = "ACM-SS"
####################################################
lb_protocol    = "http"
lb_port        = 80
lb_target_port = 80


frontend_workers = {
  trk = {
    count = 1
    size  = "s-1vcpu-1gb"
  }

  ai = {
    count = 1
    size  = "s-1vcpu-1gb"
  }

  dashboard = {
    count = 1
    size  = "s-1vcpu-1gb"
  }
}
