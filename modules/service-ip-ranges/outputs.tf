output "service" {
  description = "The service which owns the IP ranges."
  value       = var.service
}

output "categories" {
  description = "A set of all available categories for the service."
  value       = keys(local.service_cidrs)
}

output "all_ipv4_cidrs" {
  description = "A set of all IPv4 CIDRs for the service."
  value = toset([
    for cidr in local.service_all_cidrs :
    cidr
    if cidr == replace(cidr, ":", "")
  ])
}

output "all_ipv6_cidrs" {
  description = "A set of all IPv6 CIDRs for the service."
  value = toset([
    for cidr in local.service_all_cidrs :
    cidr
    if cidr != replace(cidr, ":", "")
  ])
}

output "ipv4_cidrs" {
  description = "A set of IPv4 CIDRs for the service per category."
  value = {
    for category, cidrs in local.service_cidrs :
    category => toset([
      for cidr in cidrs :
      cidr
      if cidr == replace(cidr, ":", "")
    ])
  }
}

output "ipv6_cidrs" {
  description = "A set of IPv6 CIDRs for the service per category."
  value = {
    for category, cidrs in local.service_cidrs :
    category => toset([
      for cidr in cidrs :
      cidr
      if cidr != replace(cidr, ":", "")
    ])
  }
}
