locals {
  services = {
    "SCALR" = local.scalr_cidrs
  }
  cidrs = local.services[var.service]
}


###################################################
# IP Ranges for Scalr
###################################################

data "http" "scalr" {
  count = var.service == "SCALR" ? 1 : 0

  url = "https://scalr.io/.well-known/allowlist.txt"
}

locals {
  scalr_ip_addresses = try(split("\n", trimspace(data.http.scalr[0].response_body)), [])
  scalr_cidrs = [
    for ip in local.scalr_ip_addresses :
    "${ip}/32"
  ]
}
