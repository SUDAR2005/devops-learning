output "instance_id" {
  value = module.compute.id
}

output "instance_access_ip_v4" {
  value = module.compute.access_ip_v4
}

output "instance_network" {
  value = module.compute.network
}
