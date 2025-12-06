variable "service" {
  description = "(Required) The service which owns the IP ranges."
  type        = string
  nullable    = false

  validation {
    condition = contains([
      "ATLASSIAN",
      "CHECKLY",
      "GITHUB",
      "OKTA",
      "SCALR",
      "TERRAFORM_CLOUD",
    ], var.service)
    error_message = "Valid values for `service` are `ATLASSIAN`, `CHECKLY`, `GITHUB`, `OKTA`, `SCALR`, `TERRAFORM_CLOUD`."
  }
}
