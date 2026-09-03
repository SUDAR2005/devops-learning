variable "instance" {
  description = "All settings for the compute instance. Any field left null/omitted is simply not attached to the resource."
  type = object({
    name = string
    image_name = optional(string)
    image_id = optional(string)
    flavor_name = optional(string)
    flavor_id = optional(string)
    key_pair = optional(string)
    security_groups = optional(list(string))
    availability_zone = optional(string)
    availability_zone_hints = optional(list(string))
    user_data = optional(string)
    metadata = optional(map(string))
    config_drive = optional(bool)
    admin_pass = optional(string)
    power_state = optional(string)
    stop_before_destroy = optional(bool)
    force_delete = optional(bool)
    tags = optional(list(string))

    networks = optional(list(object({
      name = optional(string)
      uuid = optional(string)
      port = optional(string)
      fixed_ip_v4 = optional(string)
      access_network = optional(bool)
    })))

    block_devices = optional(list(object({
      uuid = optional(string)
      source_type = string
      volume_size = optional(number)
      boot_index = optional(number)
      destination_type = optional(string)
      delete_on_termination = optional(bool)
      device_type = optional(string)
      disk_bus = optional(string)
      volume_type = optional(string)
      multiattach = optional(bool)
      guest_format = optional(string)
    })))
  })
}
