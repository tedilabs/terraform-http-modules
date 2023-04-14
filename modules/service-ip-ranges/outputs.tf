output "service" {
  description = "The service which owns the IP ranges."
  value       = var.service
}

output "category" {
  description = "The category to use for filtering the IP ranges of the service."
  value       = var.category
}

output "cidrs" {
  description = "The list of all IP CIDRs for the service."
  value       = local.cidrs
}

output "ipv4_cidrs" {
  description = "The list of IPv4 CIDRs for the service."
  value = toset([
    for cidr in local.cidrs :
    cidr
    if cidr == replace(cidr, ":", "")
  ])
}

output "ipv6_cidrs" {
  description = "The list of IPv6 CIDRs for the service."
  value = toset([
    for cidr in local.cidrs :
    cidr
    if cidr != replace(cidr, ":", "")
  ])
}
