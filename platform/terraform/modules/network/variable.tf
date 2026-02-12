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

variable "frontend_tags" {
  type = list(string)
}

variable "allowed_sources" {
  type = list(string)
}

##########################################################



variable "db_firewall_name" {
  type = string
}

variable "db_tags" {
  type = list(string)
}
