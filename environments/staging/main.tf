provider "yandex" {
  folder_id = var.folder_id
  zone      = var.zone
}
module "network" {
  source          = "../../modules/network"
  name            = local.name
  zone            = var.zone
  subnet_cidr     = local.cidr
  management_cidr = var.management_cidr
}
module "vm" {
  source            = "../../modules/vm"
  name              = local.name
  zone              = var.zone
  subnet_id         = module.network.subnet_id
  security_group_id = module.network.security_group_id
  ssh_public_key    = var.ssh_public_key
}
module "dns" {
  count   = var.dns == null ? 0 : 1
  source  = "../../modules/dns"
  zone_id = var.dns.zone_id
  fqdn    = var.dns.fqdn
  ip      = module.vm.public_ip
}
output "ansible_host" { value = module.vm.public_ip }
