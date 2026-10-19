mock_provider "http" {
  mock_data "http" {
    defaults = {
      response_body = "{\"api\":[\"192.0.2.0/24\",\"2001:db8::/32\"]}"
    }
  }
}

variables {
  service   = "GITHUB"
  telemetry = { enabled = false }
}

run "github_without_token" {
  command = plan

  assert {
    condition     = try(length(data.http.github[0].request_headers), 0) == 0
    error_message = "GitHub requests must remain unauthenticated when no token is supplied."
  }
}

run "github_with_token" {
  command = plan

  variables {
    github_token = "test-github-token"
  }

  assert {
    condition     = try(data.http.github[0].request_headers["Authorization"], "") == "Bearer test-github-token"
    error_message = "GitHub requests must include the supplied token as Bearer authorization."
  }

  assert {
    condition = (
      output.ipv4_cidrs["api"] == toset(["192.0.2.0/24"]) &&
      output.ipv6_cidrs["api"] == toset(["2001:db8::/32"])
    )
    error_message = "Authentication must preserve the categorized IPv4 and IPv6 outputs."
  }
}

run "other_services_do_not_receive_token" {
  command = plan

  variables {
    service      = "TERRAFORM_CLOUD"
    github_token = "test-github-token"
  }

  assert {
    condition = (
      length(data.http.github) == 0 &&
      data.http.terraform_cloud[0].request_headers == null
    )
    error_message = "The GitHub token must not be sent to other services."
  }
}
