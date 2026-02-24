data "digitalocean_ssh_keys" "all" {}

data "digitalocean_project" "acm_ss" {
  name = "ACM-SS"
}
