variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "root_volume_type" {
  type = string
}

variable "root_volume_size" {
  type = number
}

variable "key_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

# variable "backend_manifest" {
#   description = "Raw contents of backend.yml, embedded into the instance bootstrap script."
#   type        = string
# }

# variable "frontend_manifest" {
#   description = "Raw contents of frontend.yml, embedded into the instance bootstrap script."
#   type        = string
# }

# variable "redis_manifest" {
#   description = "Raw contents of redis.yml, embedded into the instance bootstrap script."
#   type        = string
# }

# variable "ingress_manifest" {
#   description = "Raw contents of ingress.yaml, embedded into the instance bootstrap script."
#   type        = string
# }
