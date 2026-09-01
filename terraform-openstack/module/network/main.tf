resource "openstack_networking_network_v2" "network1" {
	name = var.network_name
	admin_state_up = "true"
}


resource "openstack_networking_subnet_v2" "subnet1" {
	name = "subnet_1"
	network_id = openstack_networking_network_v2.network1.id
	cidr = var.public_subnet_cidr
	ip_version = 4
}
# floating IP configuration
data "openstack_networking_network_v2" "public_net" {
	name = "public"
}

resource "openstack_networking_router_v2" "router1" {
	name = "router_1"
	admin_state_up = true
  external_network_id = data.openstack_networking_network_v2.public_net.id
}

resource "openstack_networking_router_interface_v2" "router_interface_1" {
	router_id = openstack_networking_router_v2.router1.id
	subnet_id = openstack_networking_subnet_v2.subnet1.id
}

resource "openstack_networking_port_v2" "port1" {
	name = "${var.network_name}-port"
	network_id = openstack_networking_network_v2.network1.id
	admin_state_up = "true"
	security_group_ids = [var.security_group_id] # Passed in from security module
  # fix: lookup subent1 for yout IP pool (instad of manual hardcoding)
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet1.id
  }
}

# Grab a public IP address from the public pool
resource "openstack_networking_floatingip_v2" "fip1" {
  pool = data.openstack_networking_network_v2.public_net.name
}

# Bind the public IP address directly to the port
resource "openstack_networking_floatingip_associate_v2" "fip_assoc1" {
  floating_ip = openstack_networking_floatingip_v2.fip1.address
  port_id     = openstack_networking_port_v2.port1.id
}
