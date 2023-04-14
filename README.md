# terraform-http-modules

![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/tedilabs/terraform-http-modules?color=blue&sort=semver&style=flat-square)
![GitHub](https://img.shields.io/github/license/tedilabs/terraform-http-modules?color=blue&style=flat-square)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white&style=flat-square)](https://github.com/pre-commit/pre-commit)

Terraform package to mange useful data modules via HTTP provider.

- [service-ip-ranges](./modules/service-ip-ranges)


## Usage

### Service IP Ranges

```tf
module "okta_ip_ranges" {
  source  = "tedilabs/modules/http//modules/service-ip-ranges"
  version = "~> 0.1.0"

  service = "OKTA"
}

module "scalr_ip_ranges" {
  source  = "tedilabs/modules/http//modules/service-ip-ranges"
  version = "~> 0.1.0"

  service = "SCALR"
}

module "terraform_cloud_api_ip_ranges" {
  source  = "tedilabs/modules/http//modules/service-ip-ranges"
  version = "~> 0.1.0"

  service = "TERRAFORM_CLOUD"
  category = "api"
}
```


## Examples

- [service-ip-ranges](./examples/service-ip-ranges)


## Self Promotion

Like this project? Follow the repository on [GitHub](https://github.com/tedilabs/terraform-http-modules). And if you're feeling especially charitable, follow **[posquit0](https://github.com/posquit0)** on GitHub.


## License

Provided under the terms of the [Apache License](LICENSE).

Copyright © 2022-2023, [Byungjin Park](https://www.posquit0.com).
