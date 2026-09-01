output "network_id" {
  description = "The ID of the created OpenStack network"
  value       = openstack_networking_network_v2.network1.id
}

output "subnet_id" {
  description = "The ID of the created OpenStack subnet"
  value       = openstack_networking_subnet_v2.subnet1.id
}

output "port_id" {
  description = "The ID of the network port for the instance"
  value       = openstack_networking_port_v2.port1.id
}


output "floating_ip_address" {
  description = "The assigned public floating IP"
  value       = openstack_networking_floatingip_v2.fip1.address
}
