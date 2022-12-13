variable "service" {
  description = "(Required) The service which owns the IP ranges."
  type        = string

  validation {
    condition = contains([
      "SCALR",
      "TERRAFORM_CLOUD_API",
      "TERRAFORM_CLOUD_NOTIFICATIONS",
      "TERRAFORM_CLOUD_SENTINEL",
    "TERRAFORM_CLOUD_VCS"], var.service)
    error_message = "Valid values for `service` are `SCALR`, `TERRAFORM_CLOUD_API`, `TERRAFORM_CLOUD_NOTIFICATIONS`, `TERRAFORM_CLOUD_SENTINEL`, `TERRAFORM_CLOUD_VCS`."
  }
}
