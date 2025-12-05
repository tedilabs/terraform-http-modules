terraform {
  required_version = ">= 1.12"

  required_providers {
    http = {
      source  = "hashicorp/http"
      version = ">= 3.5.0"
    }
  }
}
