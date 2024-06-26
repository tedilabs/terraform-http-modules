locals {
  targets = [
    {
      service  = "ATLASSIAN"
      category = "all"
    },
    {
      service  = "ATLASSIAN"
      category = "confluence"
    },
    {
      service  = "ATLASSIAN"
      category = "jira"
    },
    {
      service  = "CHECKLY"
      category = "all"
    },
    {
      service  = "GITHUB"
      category = "all"
    },
    {
      service  = "GITHUB"
      category = "actions"
    },
    {
      service  = "OKTA"
      category = "all"
    },
    {
      service  = "SCALR"
      category = "all"
    },
    {
      service  = "TERRAFORM_CLOUD"
      category = "all"
    },
    {
      service  = "TERRAFORM_CLOUD"
      category = "api"
    },
  ]
}


###################################################
# Service IP Ranges
###################################################

module "service_ip_ranges" {
  source = "../../modules/service-ip-ranges"
  # source  = "tedilabs/modules/http//modules/service-ip-ranges"
  # version = "~> 0.2.0"

  for_each = {
    for target in local.targets :
    "${target.service}/${target.category}" => target
  }

  service  = each.value.service
  category = each.value.category
}
