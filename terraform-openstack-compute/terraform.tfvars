instance = {
  name        = "web-01"
  image_name  = "cirros-0.6.2-x86_64-disk"
  flavor_name = "m1.small"
  networks = [
    {
      name = "network1"
      access_network = true
    }
  ]
}