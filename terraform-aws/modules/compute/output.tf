output "instance_id" {
  value = aws_instance.main_vm.id
}

output "private_ip" {
  value = aws_instance.main_vm.private_ip
}

output "elastic_ip" {
  value = aws_eip.main_vm.public_ip
}
