# service-ip-ranges

This module does not create any resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_http"></a> [http](#requirement\_http) | >= 3.5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_http"></a> [http](#provider\_http) | 3.5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [http_http.atlassian](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.checkly_ipv4](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.checkly_ipv6](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.github](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.okta](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.scalr](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.terraform_cloud](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_service"></a> [service](#input\_service) | (Required) The service which owns the IP ranges. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all_ipv4_cidrs"></a> [all\_ipv4\_cidrs](#output\_all\_ipv4\_cidrs) | A set of all IPv4 CIDRs for the service. |
| <a name="output_all_ipv6_cidrs"></a> [all\_ipv6\_cidrs](#output\_all\_ipv6\_cidrs) | A set of all IPv6 CIDRs for the service. |
| <a name="output_categories"></a> [categories](#output\_categories) | A set of all available categories for the service. |
| <a name="output_ipv4_cidrs"></a> [ipv4\_cidrs](#output\_ipv4\_cidrs) | A set of IPv4 CIDRs for the service per category. |
| <a name="output_ipv6_cidrs"></a> [ipv6\_cidrs](#output\_ipv6\_cidrs) | A set of IPv6 CIDRs for the service per category. |
| <a name="output_service"></a> [service](#output\_service) | The service which owns the IP ranges. |
<!-- END_TF_DOCS -->
