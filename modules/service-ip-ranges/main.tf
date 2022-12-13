locals {
  services = {
    ## Scalr
    "SCALR" = local.scalr_cidrs
    ## Terraform Cloud
    "TERRAFORM_CLOUD_API"           = try(local.terraform_cloud_cidrs["api"], [])
    "TERRAFORM_CLOUD_NOTIFICATIONS" = try(local.terraform_cloud_cidrs["notifications"], [])
    "TERRAFORM_CLOUD_SENTINEL"      = try(local.terraform_cloud_cidrs["sentinel"], [])
    "TERRAFORM_CLOUD_VCS"           = try(local.terraform_cloud_cidrs["vcs"], [])
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

data "http" "terraform_cloud" {
  count = contains([
    "TERRAFORM_CLOUD_API",
    "TERRAFORM_CLOUD_NOTIFICATIONS",
    "TERRAFORM_CLOUD_SENTINEL",
  "TERRAFORM_CLOUD_VCS"], var.service) ? 1 : 0

  url = "https://app.terraform.io/api/meta/ip-ranges"
}

locals {
  scalr_ip_addresses = try(split("\n", trimspace(data.http.scalr[0].response_body)), [])
  scalr_cidrs = [
    for ip in local.scalr_ip_addresses :
    "${ip}/32"
  ]

  terraform_cloud_cidrs = try(jsondecode(trimspace(data.http.terraform_cloud[0].response_body)), {})
}
