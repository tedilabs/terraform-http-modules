output "service" {
  description = "The service which owns the IP ranges."
  value       = var.service
}

output "category" {
  description = "The category to use for filtering the IP ranges of the service."
  value       = var.category
}

output "cidrs" {
  description = "The list of IP CIDRs for the service."
  value       = local.cidrs
}
