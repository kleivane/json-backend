terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = "eu-north-1"
  version = "~> 2.47"
}

locals {
  environment = "prod"
}

resource "aws_ecr_repository" "images" {
  name                 = "static-json"
  image_tag_mutability = "IMMUTABLE"
}
