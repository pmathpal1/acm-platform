variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "frontend_tag" {
  description = "Tag used by frontend swarm workers"
  type        = string
}

variable "lb_protocol" {
  type = string
}

variable "lb_port" {
  type = number
}

variable "lb_target_port" {
  type = number
}

variable "healthcheck_path" {
  type    = string
  default = "/"
}
