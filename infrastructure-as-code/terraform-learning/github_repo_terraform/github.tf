terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.14.1"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "eu-west-1"
  profile = "Afsheen28"
}

# Configure the GitHub Provider
provider "github" {
  token = "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"
}

resource "github_repository" "tech511-afsheen-tf-created-repo" {
  name        = "tech511-afsheen-test-terraform-repo"
  description = "tech511-afsheen-test-terraform-repo"

  visibility = "public"
}

resource "github_repository_file" "readme" {
  repository          = github_repository.tech511-afsheen-tf-created-repo.name
  file                = "README.md"
  content             = "#This repo was created with Terraform."
  commit_message      = "Add README.md"
  overwrite_on_create = true
}
