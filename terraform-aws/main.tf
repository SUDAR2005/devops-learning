module "network" {
  source             = "./modules/network"
  availability_zone  = "us-east-1a"
  environment        = "test"
  project_name       = "terraform-aws"
  vpc_cidr           = "10.20.0.0/16"
  public_subnet_cidr = "10.20.1.0/24"
}

module "security" {
  source            = "./modules/security"
  project_name      = "terraform-aws"
  environment       = "test"
  vpc_id            = module.network.vpc_id
  allowed_ssh_cidr  = "0.0.0.0/0"
  allowed_http_cidr = "0.0.0.0/0"
}

module "compute" {
  source            = "./modules/compute"
  project_name      = "terraform-aws"
  environment       = "test"
  instance_type     = "t3.micro"
  key_name          = "application-key"
  subnet_id         = module.network.public_subnet_id
  security_group_id = module.security.security_group_id
  root_volume_size  = 20
  root_volume_type  = "gp3"
}