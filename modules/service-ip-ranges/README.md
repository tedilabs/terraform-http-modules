# service-ip-ranges

This module does not create any resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_http"></a> [http](#requirement\_http) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_http"></a> [http](#provider\_http) | 3.2.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
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
| <a name="output_cidrs"></a> [cidrs](#output\_cidrs) | The list of IP CIDRs for the service. |
| <a name="output_service"></a> [service](#output\_service) | The service which owns the IP ranges. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
