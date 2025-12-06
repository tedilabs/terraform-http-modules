locals {
  targets = ["ATLASSIAN", "CHECKLY", "GITHUB", "OKTA", "SCALR", "TERRAFORM_CLOUD"]
}


###################################################
# Service IP Ranges
###################################################

module "service_ip_ranges" {
  source = "../../modules/service-ip-ranges"
  # source  = "tedilabs/modules/http//modules/service-ip-ranges"
  # version = "~> 0.3.0"

  for_each = toset(local.targets)

  service = each.value
}
