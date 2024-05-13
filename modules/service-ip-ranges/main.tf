locals {
  all_cidrs = {
    ## Atlassian
    "ATLASSIAN" = merge(
      local.atlassian_cidrs,
      try({
        "all" = setunion(values(local.atlassian_cidrs)...)
      }, {})
    )
    ## Checkly
    "CHECKLY" = {
      "all" = setunion(
        local.checkly_ipv4_cidrs,
        local.checkly_ipv6_cidrs,
      )
    }
    ## GitHub
    "GITHUB" = merge(
      local.github_cidrs,
      try({
        "all" = setunion(values(local.github_cidrs)...)
      }, {})
    )
    ## HashiCorp
    "TERRAFORM_CLOUD" = merge(
      local.terraform_cloud_cidrs,
      try({
        "all" = setunion(values(local.terraform_cloud_cidrs)...)
      }, {})
    )
    ## Okta
    "OKTA" = merge(
      local.okta_cidrs,
      try({
        "all" = setunion(values(local.okta_cidrs)...)
      }, {})
    )
    ## Scalr
    "SCALR" = {
      "all" = local.scalr_cidrs
    }
  }
  service_cidrs = local.all_cidrs[var.service]
  cidrs         = local.service_cidrs[var.category]
}


###################################################
# IP Ranges for Atlassian
###################################################

data "http" "atlassian" {
  count = var.service == "ATLASSIAN" ? 1 : 0

  url = "https://ip-ranges.atlassian.com/"
}

locals {
  atlassian_data = (var.service == "ATLASSIAN"
    ? jsondecode(trimspace(data.http.atlassian[0].response_body)).items
    : []
  )

  atlassian_categories = ["bitbucket", "confluence", "jira", "trello"]
  atlassian_cidrs = {
    for category in local.atlassian_categories :
    category => toset([
      for item in local.atlassian_data :
      item.cidr
      if contains(item.product, category) && contains(item.direction, "egress")
    ])
  }
}


###################################################
# IP Ranges for Checkly
###################################################

data "http" "checkly_ipv4" {
  count = var.service == "CHECKLY" ? 1 : 0

  url = "https://api.checklyhq.com/v1/static-ips"
}

data "http" "checkly_ipv6" {
  count = var.service == "CHECKLY" ? 1 : 0

  url = "https://api.checklyhq.com/v1/static-ipv6s"
}

locals {
  checkly_ipv4_data = (var.service == "CHECKLY"
    ? jsondecode(trimspace(data.http.checkly_ipv4[0].response_body))
    : []
  )
  checkly_ipv6_data = (var.service == "CHECKLY"
    ? jsondecode(trimspace(data.http.checkly_ipv6[0].response_body))
    : []
  )
  checkly_ipv4_cidrs = toset([
    for ip in local.checkly_ipv4_data :
    "${ip}/32"
  ])
  checkly_ipv6_cidrs = toset([
    for ip in local.checkly_ipv6_data :
    ip
  ])
}


###################################################
# IP Ranges for GitHub.com
###################################################

data "http" "github" {
  count = var.service == "GITHUB" ? 1 : 0

  url = "https://api.github.com/meta"
}

locals {
  github_data = (var.service == "GITHUB"
    ? jsondecode(trimspace(data.http.github[0].response_body))
    : tomap({})
  )

  github_categories = ["hooks", "web", "api", "git", "packages", "pages", "importer", "actions", "dependabot"]
  github_cidrs = try({
    for category in local.github_categories :
    category => toset(local.github_data[category])
  }, {})
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
