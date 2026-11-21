data "yandex_compute_image" "ubuntu" { family = "ubuntu-2404-lts" }
resource "yandex_compute_instance" "this" {
  name        = var.name
  hostname    = var.name
  zone        = var.zone
  platform_id = "standard-v3"
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 15
      type     = "network-hdd"
    }
  }
  network_interface {
    subnet_id          = var.subnet_id
    nat                = true
    security_group_ids = [var.security_group_id]
  }
  metadata = {
    user-data = join("\n", ["#cloud-config", yamlencode({
      users      = [{ name = "ubuntu", shell = "/bin/bash", sudo = "ALL=(ALL) NOPASSWD:ALL", ssh_authorized_keys = [var.ssh_public_key] }]
      ssh_pwauth = false
    })])
  }
}
output "public_ip" { value = yandex_compute_instance.this.network_interface[0].nat_ip_address }
