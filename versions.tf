terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aap = {
      source  = "ansible/aap"
      version = ">= 1.0.0"
    }
  }
}