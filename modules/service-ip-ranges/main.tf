locals {
  all_cidrs = {
    "OKTA" = merge(
      local.okta_cidrs,
      try({
        "all" = setunion(values(local.okta_cidrs)...)
      }, {})
    )
    "SCALR" = {
      "all" = local.scalr_cidrs
    }
    "TERRAFORM_CLOUD" = merge(
      local.terraform_cloud_cidrs,
      try({
        "all" = setunion(values(local.terraform_cloud_cidrs)...)
      }, {})
    )
  }
  service_cidrs = local.all_cidrs[var.service]
  cidrs         = local.service_cidrs[var.category]
}


###################################################
# IP Ranges for Okta
###################################################

data "http" "okta" {
  count = var.service == "OKTA" ? 1 : 0

  url = "https://s3.amazonaws.com/okta-ip-ranges/ip_ranges.json"
}

locals {
  okta_data = (var.service == "OKTA"
    ? jsondecode(trimspace(data.http.okta[0].response_body))
    : {}
  )
  okta_cidrs = {
    for category, data in local.okta_data :
    category => toset(data.ip_ranges)
  }
}


###################################################
# IP Ranges for Scalr
###################################################

data "http" "scalr" {
  count = var.service == "SCALR" ? 1 : 0

  url = "https://scalr.io/.well-known/allowlist.txt"
}

locals {
  scalr_data = (var.service == "SCALR"
    ? split("\n", trimspace(data.http.scalr[0].response_body))
    : []
  )
  scalr_cidrs = toset([
    for ip in local.scalr_data :
    "${ip}/32"
  ])
}


###################################################
# IP Ranges for Terraform Cloud
###################################################

data "http" "terraform_cloud" {
  count = var.service == "TERRAFORM_CLOUD" ? 1 : 0

  url = "https://app.terraform.io/api/meta/ip-ranges"
}

locals {
  terraform_cloud_data = (var.service == "TERRAFORM_CLOUD"
    ? jsondecode(trimspace(data.http.terraform_cloud[0].response_body))
    : {}
  )
  terraform_cloud_cidrs = {
    for category, cidrs in local.terraform_cloud_data :
    category => toset(cidrs)
  }
}
