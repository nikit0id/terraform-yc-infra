region                      = "ru-central1"
bucket                      = "replace-with-your-state-bucket"
key                         = "portfolio/production/terraform.tfstate"
dynamodb_table              = "terraform-locks"
skip_credentials_validation = true
skip_region_validation      = true
skip_requesting_account_id  = true
skip_metadata_api_check     = true
skip_s3_checksum            = true
use_path_style              = true
endpoints = {
  s3       = "https://storage.yandexcloud.net"
  dynamodb = "https://docapi.serverless.yandexcloud.net/ru-central1/your-cloud-id/your-database-id"
}
