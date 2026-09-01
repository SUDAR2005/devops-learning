variable "security_group_name" {
  type = string
  description = "The name given to the security group container"
  default = "secgroup_1"
}

variable "ingress_rules" {
  type = map(object({port = number
    protocol = string
    cidr = string
  }))
  description = "A flexible map tracking all allowed inbound port entries"
  default = {
    ssh = {
      port = 22
      protocol = "tcp"
      cidr = "0.0.0.0/0"
    }
  }
}
