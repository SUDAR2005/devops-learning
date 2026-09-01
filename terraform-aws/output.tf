output "vpc_id" {
  description = "ID of the VPC."
  value       = module.network.vpc_id
}

output "public_subnet_id" {
  description = "ID of the public subnet."
  value       = module.network.public_subnet_id
}


output "internet_gateway_id" {
  description = "ID of the internet gateway."
  value       = module.network.internet_gateway_id
}

output "security_group_id" {
  description = "ID of Security Group"
  value       = module.security.security_group_id
}


output "elastic_ip" {
  description = "Elastic IP of Instance"
  value = module.compute.elastic_ip
}

output "instance_id" {
  description = "ID of the EC2 instance."
  value = module.compute.instance_id
}

output "private_ip" {
  description = "Private IP"
  value = module.compute.private_ip
}