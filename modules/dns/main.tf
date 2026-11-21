resource "yandex_dns_recordset" "this" {
  zone_id = var.zone_id
  name    = var.fqdn
  type    = "A"
  ttl     = 300
  data    = [var.ip]
}
