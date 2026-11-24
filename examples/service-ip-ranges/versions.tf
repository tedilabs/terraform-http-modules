terraform {
  required_version = "~> 1.16"

  required_providers {
    # tflint-ignore: terraform_unused_required_providers
    http = {
      source  = "hashicorp/http"
      version = "~> 3.0"
    }
  }
}
