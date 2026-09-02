resource "openstack_compute_instance_v2" "this" {
  name = var.name
  image_name = var.image_name
  image_id = var.image_id
  flavor_name = var.flavor_name
  flavor_id = var.flavor_id
  key_pair = var.key_pair
  security_groups = var.security_groups
  availability_zone = var.availability_zone
  availability_zone_hints = var.availability_zone_hints
  user_data = var.user_data
  metadata = var.metadata
  config_drive = var.config_drive
  admin_pass = var.admin_pass
  power_state = var.power_state
  stop_before_destroy = var.stop_before_destroy
  force_delete = var.force_delete
  tags = var.tags

  dynamic "network" {
    for_each = var.networks != null ? var.networks : []
    content {
      name = network.value.name
      uuid = network.value.uuid
      port = network.value.port
      fixed_ip_v4 = network.value.fixed_ip_v4
      access_network = network.value.access_network
    }
  }

  dynamic "block_device" {
    for_each = var.block_devices != null ? var.block_devices : []
    content {
      uuid = block_device.value.uuid
      source_type = block_device.value.source_type
      volume_size = block_device.value.volume_size
      boot_index = block_device.value.boot_index
      destination_type = block_device.value.destination_type
      delete_on_termination = block_device.value.delete_on_termination
      device_type = block_device.value.device_type
      disk_bus = block_device.value.disk_bus
      volume_type = block_device.value.volume_type
      multiattach = block_device.value.multiattach
      guest_format = block_device.value.guest_format
      tag = block_device.value.tag
    }
  }
}
