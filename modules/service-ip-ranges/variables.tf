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

variable "github_token" {
  description = "(Optional) GitHub token used to authenticate IP range requests when `service` is `GITHUB`. Defaults to unauthenticated requests. The token is stored in Terraform state as part of the HTTP request headers."
  type        = string
  default     = null
  sensitive   = true
}
