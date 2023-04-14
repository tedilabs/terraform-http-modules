output "cidrs" {
  description = "The list of IP CIDRs for each services."
  value = {
    for k, v in module.service_ip_ranges :
    k => v.cidrs
  }
}
