locals {
  all_cidrs = {
    "SCALR" = {
      "ALL" = local.scalr_cidrs
    }
    "TERRAFORM_CLOUD" = try({
      "ALL" = setunion(
        local.terraform_cloud_cidrs["api"],
        local.terraform_cloud_cidrs["notifications"],
        local.terraform_cloud_cidrs["sentinel"],
        local.terraform_cloud_cidrs["vcs"],
      )
      "API"           = local.terraform_cloud_cidrs["api"]
      "NOTIFICATIONS" = local.terraform_cloud_cidrs["notifications"]
      "SENTINEL"      = local.terraform_cloud_cidrs["sentinel"]
      "VCS"           = local.terraform_cloud_cidrs["vcs"]
    }, {})
  }
  service_cidrs = local.all_cidrs[var.service]
  cidrs         = local.service_cidrs[var.category]
}


###################################################
# IP Ranges for Scalr
###################################################

data "http" "scalr" {
  count = var.service == "SCALR" ? 1 : 0

  url = "https://scalr.io/.well-known/allowlist.txt"
}

data "http" "terraform_cloud" {
  count = var.service == "TERRAFORM_CLOUD" ? 1 : 0

  url = "https://app.terraform.io/api/meta/ip-ranges"
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

  terraform_cloud_data = (var.service == "TERRAFORM_CLOUD"
    ? jsondecode(trimspace(data.http.terraform_cloud[0].response_body))
    : {}
  )
  terraform_cloud_cidrs = {
    for category, cidrs in local.terraform_cloud_data :
    category => toset(cidrs)
  }
}
