data "openstack_images_image_v2" "cirros" {
	name = "cirros-0.6.3-x86_64-disk"
	most_recent = true
}

resource "openstack_compute_instance_v2" "vm_instance" {
	name = var.instance_name
	image_id = data.openstack_images_image_v2.cirros.id
	flavor_id = "c1"
	network {
		port = var.port_id
	}
}
