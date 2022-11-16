variable "service" {
  description = "(Required) The service which owns the IP ranges."
  type        = string

  validation {
    condition     = contains(["SCALR"], var.service)
    error_message = "Valid values for `service` are `SCALR`."
  }
}
