variable "service" {
  description = "(Required) The service which owns the IP ranges."
  type        = string
  nullable    = false

  validation {
    condition = contains([
      "ATLASSIAN",
      "GITHUB",
      "OKTA",
      "SCALR",
      "TERRAFORM_CLOUD",
    ], var.service)
    error_message = "Valid values for `service` are `ATLASSIAN`, `GITHUB`, `OKTA`, `SCALR`, `TERRAFORM_CLOUD`."
  }
}

variable "category" {
  description = "(Optional) The category to use for filtering the IP ranges of the service. By default, it returns all IP ranges. Defaults to `all`. Valid values are depends on which service is selected."
  type        = string
  default     = "all"
  nullable    = false
}
