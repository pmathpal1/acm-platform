variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "DigitalOcean region for Jenkins droplet"
  type        = string
  default     = "blr1"
}



variable "linux_base_image" {
  type = string

}

variable "jenkins_size" {
  type = string

}

variable "vpc_cidr" {
  description = "CIDR range for global shared VPC"
  type        = string
}

variable "admin_ip" {
  description = "Public IP allowed to access Jenkins"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}