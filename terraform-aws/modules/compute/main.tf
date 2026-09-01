data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_instance" "main_vm" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    
    # network rel config
    subnet_id              = var.subnet_id
    vpc_security_group_ids = [var.security_group_id]
    key_name               = var.key_name
    
    # storage rel config
    root_block_device {
      volume_type = var.root_volume_type
      volume_size = var.root_volume_size
      delete_on_termination = true
      encrypted = true
    }

    tags = {
      Name = "${var.project_name}-${var.environment}-vm"
    }
}

resource "aws_eip" "main_vm" {
  instance = aws_instance.main_vm.id
  domain   = "vpc"

  tags = {
    Name = "${var.project_name}-${var.environment}-eip"
  }
}
