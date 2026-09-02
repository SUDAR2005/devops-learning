module "compute" {
  source = "./module/compute"
  name = var.instance.name
  image_name = var.instance.image_name
  flavor_name = var.instance.flavor_name
  networks = var.instance.networks
}

