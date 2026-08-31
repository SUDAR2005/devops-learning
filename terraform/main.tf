terraform {
	required_providers {
		openstack = {
      			source  = "terraform-provider-openstack/openstack"
      			version = "~> 1.53.0"
    		}
  	}
}

provider "openstack" {}

resource "openstack_compute_instance_v2" "sudar_vm" {
  	name            = "devstack-cirros-image"
  	image_name      = "cirros-0.6.3-x86_64-disk"
  	flavor_name     = "m1.tiny"
  	security_groups = ["default"]

  	network {
    	name = "shared"
	}
}
