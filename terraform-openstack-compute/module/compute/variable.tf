
# CORE
variable "name" {
  description = "Name of the compute instance (required)."
  type = string
}

variable "image_name" {
  description = "Name of the image to boot from. Leave null if using image_id or a boot volume (block_devices)."
  type = string
  default = null
}

variable "image_id" {
  description = "ID of the image to boot from. Leave null if using image_name or a boot volume."
  type = string
  default = null
}

variable "flavor_name" {
  description = "Name of the flavor (instance size). Leave null if using flavor_id."
  type = string
  default = null
}

variable "flavor_id" {
  description = "ID of the flavor. Leave null if using flavor_name."
  type = string
  default = null
}

variable "key_pair" {
  description = "Name of an existing SSH keypair to inject into the instance."
  type = string
  default = null
}

variable "security_groups" {
  description = "List of security group names to associate. Leave null to let OpenStack apply the default group."
  type = list(string)
  default = null
}

variable "availability_zone" {
  description = "Availability zone to boot the instance in."
  type = string
  default = null
}

variable "availability_zone_hints" {
  description = "Availability zone hints, used with certain scheduler configurations."
  type = string
  default = null
}

variable "user_data" {
  description = "Raw user data (cloud-init script etc.) to pass to the instance."
  type = string
  default = null
}

variable "metadata" {
  description = "Key/value metadata to attach to the instance."
  type = map(string)
  default = null
}

variable "config_drive" {
  description = "Whether to force config drive usage for metadata delivery."
  type = bool
  default = null
}

variable "admin_pass" {
  description = "Administrative password to assign to the instance."
  type = string
  default = null
  sensitive = true
}

variable "power_state" {
  description = "Desired power state of the instance: active, shutoff, etc."
  type = string
  default = null
}

variable "stop_before_destroy" {
  description = "Whether to try to gracefully stop the instance before deleting it."
  type = bool
  default = null
}

variable "force_delete" {
  description = "Whether to force the OpenStack instance to be forcefully deleted."
  type = bool
  default = null
}

variable "tags" {
  description = "A list of simple string tags for the instance."
  type = list(string)
  default = null
}


# NETWORKS
variable "networks" {
  description = <<-EOT
    List of networks to attach. Leave null / empty to attach none.
    Provide any combination of name/uuid/port/fixed_ip_v4/access_network per entry.
  EOT
  type = list(object({
    name = optional(string)
    uuid = optional(string)
    port = optional(string)
    fixed_ip_v4 = optional(string)
    access_network = optional(bool)
  }))
  default = null
}


# BLOCK DEVICES
variable "block_devices" {
  description = <<-EOT
    List of block devices (e.g. boot-from-volume, extra volumes).
    Leave null / empty to boot purely from image_name/image_id with no extra devices.
  EOT
  type = list(object({
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
    tag = optional(string)
  }))
  default = null
}
