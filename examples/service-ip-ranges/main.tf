locals {
  services = [
    "SCALR",
    "TERRAFORM_CLOUD_API",
    "TERRAFORM_CLOUD_NOTIFICATIONS",
    "TERRAFORM_CLOUD_SENTINEL",
    "TERRAFORM_CLOUD_VCS"
  ]
}


###################################################
# Service IP Ranges
###################################################

module "service_ip_ranges" {
  source = "../../modules/service-ip-ranges"
  # source  = "tedilabs/modules/http//modules/service-ip-ranges"
  # version = "~> 0.1.0"

  for_each = toset(local.services)

  service = each.value
}
