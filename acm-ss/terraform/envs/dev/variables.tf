variable "do_token" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_ip_range" {
  type = string
}

variable "vpc_description" {
  type = string
}



variable "frontend_firewall_name" {
  type = string
}

variable "db_firewall_name" {
  type = string
}

variable "allowed_sources" {
  type = list(string)
}

variable "frontend_tags" {
  type = list(string)
}

variable "db_tags" {
  type = list(string)
}




variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "droplet_size" {
  type = string
}

variable "linux_base_image" {
  type = string
}

variable "mongo_image" {
  type = string
}

variable "manager_count" {
  type = number
}

variable "frontend_worker_names" {
  type = list(string)
}

variable "mysql_count" {
  type = number
}

variable "redis_count" {
  type = number
}

variable "mongo_count" {
  type = number
}

variable "postgres_count" {
  type = number
}

variable "project_do_name" {
  type = string

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

