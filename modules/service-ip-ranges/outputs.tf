output "service" {
  description = "The service which owns the IP ranges."
  value       = var.service
}

output "cidrs" {
  description = "The list of IP CIDRs for the service."
  value       = local.cidrs
}
