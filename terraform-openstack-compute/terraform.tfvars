instance = {
  name        = "web-01"
  image_name  = "cirros-0.6.3-x86_64-disk"
  flavor_name = "cirros256"
  networks = [
    {
      name = "network1"
      access_network = true
    }
  ]
}
