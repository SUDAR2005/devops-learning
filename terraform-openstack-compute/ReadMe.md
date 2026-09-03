### Overview

This workspace contains collection  of terraform configuration files that can be used to create a compute instance using NOVA in openstack. The terraform configuration files are designed to be modular and reusable, allowing team to easily customize their compute infrastructure deployments.

### Prerequisites

- Terraform
- An OpenStack account/project with appropriate permissions to create compute instances, networks, and (optionally) key pairs and security groups
- OpenStack credentials available to the provider, either via clouds.yaml, environment variables (OS_AUTH_URL, OS_USERNAME, OS_PASSWORD, OS_PROJECT_NAME, etc.), or variables passed into provider.tf

### Directory Structure

```
├── module
|   ├── compute
|   |   ├── main.tf
|   |   ├── variables.tf
|   |   ├── outputs.tf
|   |   └── version.tf
├── main.tf
├── variables.tf
├── README.md
├── outputs.tf
├── terraform.tfvars
├── version.tf
├── provider.tf
└── .gitignore
```


### What each attribute in the terraform.tfvars does


| Attribute | Type | Required | Description |
|---|---|---|---|
| `name` | `string` | Yes | Name of the instance. |
| `image_name` | `string` | One of `image_name`/`image_id` | Name of the image to boot the instance from. |
| `image_id` | `string` | One of `image_name`/`image_id` | ID of the image to boot the instance from. Must correspond to the same image as `image_name` if both are set. |
| `flavor_name` | `string` | One of `flavor_name`/`flavor_id` | Name of the flavor (vCPU/RAM/disk size) to use. |
| `flavor_id` | `string` | One of `flavor_name`/`flavor_id` | ID of the flavor to use. Must correspond to the same flavor as `flavor_name` if both are set. |
| `key_pair` | `string` | No | Name of an existing SSH key pair, or one created via `openstack_compute_keypair_v2`, to associate with the instance. |
| `security_groups` | `list(string)` | No | Existing security group names, or ones created via `openstack_networking_secgroup_v2`, to attach to the instance. |
| `availability_zone` | `string` | No | Availability zone to launch the instance in. Defaults to the project/region default if omitted. |
| `availability_zone_hints` | `string` | No | Use when you need to target a specific physical host node rather than a general logical zone. |
| `user_data` | `string` | No | Cloud-init / user data script to run on first boot. |
| `metadata` | `map(string)` | No | Arbitrary key/value metadata to attach to the instance. |
| `config_drive` | `bool` | No | Whether to force config drive for metadata delivery instead of (or alongside) the metadata service. |
| `admin_pass` | `string` | No | Sets the initial administrative password on the instance. |
| `power_state` | `string` | No | Desired power state of the instance (e.g. `active`, `shutoff`). |
| `stop_before_destroy` | `bool` | No | Stop the instance gracefully before Terraform destroys it. |
| `force_delete` | `bool` | No | Force deletion of the instance instead of soft delete. |
| `tags` | `list(string)` | No | Tags to apply to the instance. |
| `networks` | `list(object)` | No | Networks to attach; see **networks** below. |
| `block_devices` | `list(object)` | No | Boot/attached volumes; see **block_devices** below. |

### `networks` object

| Attribute | Type | Description |
|---|---|---|
| `name` | `string` | Name of an existing network to attach to. |
| `uuid` | `string` | UUID of an existing network (use instead of `name` when names aren't unique). |
| `port` | `string` | ID of an existing Neutron port to attach instead of a network/uuid. |
| `fixed_ip_v4` | `string` | Request a specific IPv4 address on the network. |
| `access_network` | `bool` | Marks this network as the one used for SSH/ICMP access when multiple networks are attached. |

### `block_devices` object

| Attribute | Type | Description |
|---|---|---|
| `uuid` | `string` | UUID of the image/volume/snapshot to use as the source, depending on `source_type`. |
| `source_type` | `string` | Source of the block device: `image`, `volume`, `snapshot`, or `blank`. |
| `volume_size` | `number` | Size of the volume in GB. |
| `boot_index` | `number` | Boot order index; `0` marks the boot volume. |
| `destination_type` | `string` | `local` or `volume`. |
| `delete_on_termination` | `bool` | Whether the volume is deleted when the instance is terminated. |
| `device_type` | `string` | Device type, e.g. `disk`. |
| `disk_bus` | `string` | Disk bus type, e.g. `virtio`, `scsi`. |
| `volume_type` | `string` | Cinder volume type to use, if applicable. |
| `multiattach` | `bool` | Whether the volume supports being attached to multiple instances. |
| `guest_format` | `string` | Filesystem format to apply to the volume. |

### Notes
- Set exactly one of image_name / image_id, and exactly one of flavor_name / flavor_id - the pair you choose must refer to the same underlying resource.
- If you need multiple network interfaces, add multiple entries to the networks list and mark only one as access_network = true.
- block_devices lets you boot from a Cinder volume instead of ephemeral disk by setting destination_type = "volume" with an appropriate volume_size.