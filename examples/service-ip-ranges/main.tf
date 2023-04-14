locals {
  targets = [
    {
      service  = "SCALR"
      category = "ALL"
    },
    {
      service  = "TERRAFORM_CLOUD"
      category = "ALL"
    },
    {
      service  = "TERRAFORM_CLOUD"
      category = "API"
    },
  ]
}


###################################################
# Service IP Ranges
###################################################

module "service_ip_ranges" {
  source = "../../modules/service-ip-ranges"
  # source  = "tedilabs/modules/http//modules/service-ip-ranges"
  # version = "~> 0.1.0"

  for_each = {
    for target in local.targets :
    "${target.service}/${target.category}" => target
  }

  service  = each.value.service
  category = each.value.category
}
