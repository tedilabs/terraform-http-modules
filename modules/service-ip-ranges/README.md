# service-ip-ranges

This module does not create any resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_http"></a> [http](#requirement\_http) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_http"></a> [http](#provider\_http) | 3.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [http_http.atlassian](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.github](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.okta](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.scalr](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.terraform_cloud](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_service"></a> [service](#input\_service) | (Required) The service which owns the IP ranges. | `string` | n/a | yes |
| <a name="input_category"></a> [category](#input\_category) | (Optional) The category to use for filtering the IP ranges of the service. By default, it returns all IP ranges. Defaults to `all`. Valid values are depends on which service is selected. | `string` | `"all"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_category"></a> [category](#output\_category) | The category to use for filtering the IP ranges of the service. |
| <a name="output_cidrs"></a> [cidrs](#output\_cidrs) | The list of all IP CIDRs for the service. |
| <a name="output_ipv4_cidrs"></a> [ipv4\_cidrs](#output\_ipv4\_cidrs) | The list of IPv4 CIDRs for the service. |
| <a name="output_ipv6_cidrs"></a> [ipv6\_cidrs](#output\_ipv6\_cidrs) | The list of IPv6 CIDRs for the service. |
| <a name="output_service"></a> [service](#output\_service) | The service which owns the IP ranges. |
<!-- END_TF_DOCS -->
