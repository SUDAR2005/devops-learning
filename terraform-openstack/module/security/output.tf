output "security_group_id" {
  description = "The generated ID of this group to feed into your network port module"
  value       = openstack_networking_secgroup_v2.secgroup1.id
}
