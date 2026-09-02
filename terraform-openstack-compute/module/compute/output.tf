output "id" {
  description = "ID of the created instance."
  value       = openstack_compute_instance_v2.this.id
}

output "name" {
  description = "Name of the created instance."
  value       = openstack_compute_instance_v2.this.name
}

output "access_ip_v4" {
  description = "The first detected IPv4 address of the instance."
  value       = openstack_compute_instance_v2.this.access_ip_v4
}

output "access_ip_v6" {
  description = "The first detected IPv6 address of the instance."
  value       = openstack_compute_instance_v2.this.access_ip_v6
}

output "network" {
  description = "Full network attribute block(s) as reported by OpenStack (includes assigned fixed IPs, MAC, port IDs)."
  value       = openstack_compute_instance_v2.this.network
}

output "power_state" {
  description = "Current power state reported for the instance."
  value       = openstack_compute_instance_v2.this.power_state
}

output "availability_zone" {
  description = "Availability zone the instance was created in."
  value       = openstack_compute_instance_v2.this.availability_zone
}
