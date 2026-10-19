# service-ip-ranges

This module does not create any resources.

## GitHub authentication

Set `github_token` to authenticate requests to the GitHub metadata API. Leaving it
unset or setting it to `null` preserves unauthenticated requests. The token is
only sent when `service = "GITHUB"`; other services do not receive it.

```hcl
variable "github_token" {
  type      = string
  default   = null
  sensitive = true
}

module "github_ip_ranges" {
  source = "tedilabs/modules/http//modules/service-ip-ranges"

  service      = "GITHUB"
  github_token = var.github_token
}
```

Supply the root variable through `TF_VAR_github_token` or a sensitive workspace
variable. The HTTP provider does not automatically read `GITHUB_TOKEN` or use
GitHub CLI credentials.

GitHub's unauthenticated REST API limit is 60 requests per hour per source IP.
Personal access token authentication normally raises this to 5,000 requests per
hour; other token types have different limits. See the
[GitHub rate limit documentation](https://docs.github.com/en/rest/using-the-rest-api/rate-limits-for-the-rest-api).
Authentication increases the available quota; it does not cache responses or
reduce the number of requests.

Although the input is marked sensitive, the HTTP provider stores request headers
in Terraform state, including the token. Protect access to state and saved plan
files; `sensitive` redacts CLI output but does not omit the token from those files.

## Reuse lookups across child modules

Declare this module once per service in the root module, then pass its outputs to
the child modules that need them. Separate instances of this module perform
separate HTTP lookups, even when their `service` values are identical.

For example, two applications that allow GitHub webhook traffic can share one
GitHub lookup:

```hcl
locals {
  application_services = {
    frontend = "GITHUB"
    backend  = "GITHUB"
  }
}

module "service_ip_ranges" {
  source  = "tedilabs/modules/http//modules/service-ip-ranges"
  version = "~> 0.4.0"

  for_each = toset(values(local.application_services))

  service = each.value
}

module "application" {
  source = "./modules/application"

  for_each = local.application_services

  allowed_ipv4_cidrs = module.service_ip_ranges[each.value].ipv4_cidrs["hooks"]
}
```

Here, `./modules/application` represents your own child module. Replace its
internal `service-ip-ranges` lookup with an input, and use that input in its
existing allowlist resources:

```hcl
variable "allowed_ipv4_cidrs" {
  description = "IPv4 CIDRs supplied by the root module for the application allowlist."
  type        = set(string)
  nullable    = false
}
```

Both application instances receive the same `hooks` IPv4 CIDRs. The set used by
`for_each` contains only one `GITHUB` entry, so adding applications that use GitHub
does not add more GitHub HTTP data sources. Select the appropriate category and
IPv4 or IPv6 output for each consumer.

This shares a lookup within one root configuration; it does not cache responses
across Terraform runs or separate root configurations. Each normal plan still
reads the HTTP data source. The [multi-service example](../../examples/service-ip-ranges)
also uses one module instance per distinct service.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_http"></a> [http](#requirement\_http) | >= 3.5.0 |
| <a name="requirement_telemetry"></a> [telemetry](#requirement\_telemetry) | >= 0.2.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_http"></a> [http](#provider\_http) | >= 3.5.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [http_http.atlassian](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.checkly_ipv4](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.checkly_ipv6](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.github](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.okta](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.scalr](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.terraform_cloud](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_service"></a> [service](#input\_service) | (Required) The service which owns the IP ranges. | `string` | n/a | yes |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | (Optional) GitHub token used to authenticate IP range requests when `service` is `GITHUB`. Defaults to unauthenticated requests. The token is stored in Terraform state as part of the HTTP request headers. | `string` | `null` | no |
| <a name="input_telemetry"></a> [telemetry](#input\_telemetry) | (Optional) A configuration to collect telemetry data for the module. This is used to improve the module and its features. To send pseudonyms instead of identifying values such as the hostname and the Git remote, set `pseudonymization_enabled` to `true`. Pseudonyms are not anonymous; to keep data from being sent, disable its collector. The default configuration enables telemetry collection for machine, network, git, github, github actions, HCP Terraform, terraform, and toolchain. You can disable telemetry collection by setting `enabled` to `false`. `telemetry` block as defined below.<br/>    (Optional) `enabled` - Whether to enable telemetry collection. Default is `true`.<br/>    (Optional) `capture_machine` - Whether to capture machine information. Default is `true`.<br/>    (Optional) `capture_network` - Whether to capture network information. Default is `true`.<br/>    (Optional) `capture_git` - Whether to capture git information. Default is `true`.<br/>    (Optional) `capture_github` - Whether to capture GitHub information. Default is `true`.<br/>    (Optional) `capture_github_actions` - Whether to capture GitHub Actions information. Default is `true`.<br/>    (Optional) `capture_hcp_terraform` - Whether to capture HCP Terraform information. Default is `true`.<br/>    (Optional) `capture_terraform` - Whether to capture Terraform information. Default is `true`.<br/>    (Optional) `capture_toolchain` - Whether to capture toolchain information. Default is `true`.<br/>    (Optional) `pseudonymization_enabled` - Whether to enable pseudonymization of the captured data. Default is `false`. | <pre>object({<br/>    enabled = optional(bool, true)<br/><br/>    capture_machine        = optional(bool, true)<br/>    capture_network        = optional(bool, true)<br/>    capture_git            = optional(bool, true)<br/>    capture_github         = optional(bool, true)<br/>    capture_github_actions = optional(bool, true)<br/>    capture_hcp_terraform  = optional(bool, true)<br/>    capture_terraform      = optional(bool, true)<br/>    capture_toolchain      = optional(bool, true)<br/><br/>    pseudonymization_enabled = optional(bool, false)<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_all_ipv4_cidrs"></a> [all\_ipv4\_cidrs](#output\_all\_ipv4\_cidrs) | A set of all IPv4 CIDRs for the service. |
| <a name="output_all_ipv6_cidrs"></a> [all\_ipv6\_cidrs](#output\_all\_ipv6\_cidrs) | A set of all IPv6 CIDRs for the service. |
| <a name="output_categories"></a> [categories](#output\_categories) | A set of all available categories for the service. |
| <a name="output_ipv4_cidrs"></a> [ipv4\_cidrs](#output\_ipv4\_cidrs) | A set of IPv4 CIDRs for the service per category. |
| <a name="output_ipv6_cidrs"></a> [ipv6\_cidrs](#output\_ipv6\_cidrs) | A set of IPv6 CIDRs for the service per category. |
| <a name="output_service"></a> [service](#output\_service) | The service which owns the IP ranges. |
<!-- END_TF_DOCS -->
