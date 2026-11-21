mock_provider "yandex" {}
variables {
  folder_id       = "offline-check"
  management_cidr = "192.0.2.10/32"
  ssh_public_key  = "offline-test-value"
}
run "plan_host" {
  command = plan
  assert {
    condition     = length(module.dns) == 0
    error_message = "DNS is opt-in."
  }
}
run "plan_dns" {
  command = plan
  variables { dns = { zone_id = "offline-zone", fqdn = "host.example.org." } }
  assert {
    condition     = length(module.dns) == 1
    error_message = "A supplied zone must create one DNS module."
  }
}
