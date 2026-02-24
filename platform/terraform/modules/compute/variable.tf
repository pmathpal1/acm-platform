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

variable "ssh_key_ids" {
  type = list(string)
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


/*
variable "frontend_worker_names" {
  type = list(string)
}
*/

variable "mysql_count" {
  type = number
}

variable "mongo_count" {
  type = number
}

variable "postgres_count" {
  type = number
}

variable "redis_count" {
  type = number
}          


variable "frontend_workers" {
  description = "Frontend worker groups with count and size"
  type = map(object({
    count = number
    size  = string
  }))
}
