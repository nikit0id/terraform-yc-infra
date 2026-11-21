resource "yandex_vpc_network" "this" {
  name = var.name
}
resource "yandex_vpc_subnet" "this" {
  name           = var.name
  zone           = var.zone
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = [var.subnet_cidr]
}
resource "yandex_vpc_security_group" "this" {
  name       = var.name
  network_id = yandex_vpc_network.this.id
  ingress {
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = [var.management_cidr]
    description    = "Operator SSH"
  }
  dynamic "ingress" {
    for_each = toset(["80", "443"])
    content {
      protocol       = "TCP"
      port           = tonumber(ingress.value)
      v4_cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
output "subnet_id" { value = yandex_vpc_subnet.this.id }
output "security_group_id" { value = yandex_vpc_security_group.this.id }
