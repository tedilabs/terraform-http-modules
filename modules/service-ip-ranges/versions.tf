terraform {
  required_version = ">= 1.5"

  required_providers {
    http = {
      source  = "hashicorp/http"
      version = ">= 3.0.0"
    }
  }
}
