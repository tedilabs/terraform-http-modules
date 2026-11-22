output "cidrs" {
  description = "The list of IP CIDRs for each service."
  value       = module.service_ip_ranges
}
