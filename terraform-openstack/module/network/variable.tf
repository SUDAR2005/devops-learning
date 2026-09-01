variable "public_subnet_cidr" {
	type = string
	description = "Public Subnet CIDR"
	validation {
		condition = can(cidrnetmask(var.public_subnet_cidr))
		error_message = "The public subnet CIDR mask must be valid"
	}
}

variable "network_name" {
	type = string
	description = "Name of the the network"
	validation {
		condition = can(regex("^[a-z][a-z0-9-]+[a-z0-9]$", var.network_name))
		error_message = "Network Name must start with a alphabet, end with alpha numeric and may contain - in the middle"
	}
}

variable "security_group_id" {
  type        = string
  description = "The ID of the security group to attach to the port"
}
