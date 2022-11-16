output "cidrs" {
  value = {
    for k, v in module.service_ip_ranges :
    k => v.cidrs
  }
}
