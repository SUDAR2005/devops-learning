variable "project_name" {
    type = string
}

variable "environment" {
    type = string
}

variable "availability_zone" {
    type = string
}

variable "vpc_cidr" {
    type = string

    validation {
      condition = can(cidrhost(var.vpc_cidr, 0))
      error_message = "vpc_cidr must be a valid IPv4 address"
    }
}

variable "public_subnet_cidr" {
  type = string
    validation {
      condition = can(cidrhost(var.public_subnet_cidr, 0))
      error_message = "public_subnet_cidr must be a valid IPv4 address"
    }
}

