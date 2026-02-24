resource "digitalocean_droplet" "jenkins" {
  name   = "${var.environment}-jenkins"
  region = var.region
  size   = var.jenkins_size
  image  = var.linux_base_image

  vpc_uuid = digitalocean_vpc.global.id

  tags = [
    digitalocean_tag.jenkins.name,
    var.environment,
    "ci-cd"
  ]

  ssh_keys = data.digitalocean_ssh_keys.all.ssh_keys[*].id

  #user_data = file("${path.module}/scripts/jenkins.sh")

/*
  lifecycle {
    prevent_destroy = true
  }
}
*/
}