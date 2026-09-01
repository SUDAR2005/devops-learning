variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "allowed_ssh_cidr" {
  type = string

  validation {
    condition = can(cidrhost(var.allowed_ssh_cidr, 0))
    error_message = "Allowed SSH CIDR must be a valid CIDR block"
  }
}

variable "allowed_http_cidr" {
  type = string

  validation {
    condition = can(cidrhost(var.allowed_http_cidr, 0))
    error_message = "Allowed HTTP CIDR must be a valid CIDR block"
  }
}