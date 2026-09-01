output "vpc_id" {
  value = aws_vpc.main.id
  description = "The ID of the VPC"
}

output "public_subnet_id" {
  value = aws_subnet.public.id
  description = "The id of the Subnet"
}

output "internet_gateway_id" {
  value = aws_internet_gateway.main.id
  description = "The id of the Internet Gateway"
}
