# Configure the AAP provider
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aap = {
      source  = "ansible/aap"
      version = ">= 1.0.0"
    }
  }
}

provider "aap" {
  host     = var.aap_host
  username = var.aap_username
  password = var.aap_password
  insecure = true  # Set to false in production environments
}