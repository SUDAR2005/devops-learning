variable "instance_name" {
  type = string
  description = "The display name for the compute server"
  default = "cirros-test-vm"
}

variable "port_id" {
  type  = string
  description = "The pre-configured OpenStack network port ID passed from the network module"
}
