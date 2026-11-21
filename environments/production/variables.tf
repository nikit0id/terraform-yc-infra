variable "folder_id" { type = string }
variable "ssh_public_key" { type = string }
variable "management_cidr" {
  type = string
  validation {
    condition     = can(cidrnetmask(var.management_cidr)) && try(tonumber(split("/", var.management_cidr)[1]) > 0, false)
    error_message = "Restrict SSH to an operator network or a /32 address."
  }
}
variable "zone" {
  type    = string
  default = "ru-central1-a"
}
variable "dns" {
  type    = object({ zone_id = string, fqdn = string })
  default = null
}
