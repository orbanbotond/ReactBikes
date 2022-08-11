terraform {
  required_providers {
    heroku = {
      source = "heroku/heroku"
      version = "~> 4.6"
    }
  }
}

provider "heroku" {}

module "heroku" {
  source = "/Users/orbanbotond/profession/devops/terraform-pack"

  app_name  = "bike-rental-rails-flux-react"
  source_code_github_url = "https://github.com/orbanbotond/ReactBikes"
}
