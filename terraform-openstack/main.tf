module "networking" {
	source = "./module/network"
	public_subnet_cidr = "192.168.199.0/24"
	network_name = "network1"
	security_group_id = module.security.security_group_id
}

module "security" {
	source = "./module/security"
	security_group_name = "web-secgroup"
	
	ingress_rules = {
		ssh = {
			port = 22
			protocol = "tcp"
			cidr = "0.0.0.0/0"
		}
		http = {
			port = 80
			protocol = "tcp"
			cidr = "0.0.0.0/0"
		}
	}
}


module "compute" {
	source = "./module/compute"
	instance_name = "sudar-cirros-vm"
	port_id = module.networking.port_id
}
