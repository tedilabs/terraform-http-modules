output "cidrs" {
  description = "The list of IP CIDRs for each services."
  value       = module.service_ip_ranges
}
