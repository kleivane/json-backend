terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region  = "eu-north-1"
  version = "~> 2.47"
}

locals {
  url         = "test.skysett.net"
  environment = "test"
}

module "bekk_test_static_json_label" {
  source      = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.16.0"
  name        = "static-json"
  attributes  = ["public"]
  environment = local.environment


  tags = {
    "managed_by" = "terraform"
  }
}

resource "aws_ecs_task_definition" "backend" {
  family = module.bekk_test_static_json_label.id
  container_definitions = templatefile("task-definitions/service.json.tpl", {
    app_image = "525817628861.dkr.ecr.eu-north-1.amazonaws.com/static-json@sha256:6edd73d5bd08e7e2d36d203bd403254c1a8e53e0c89251c063780c1470736c19",
    app_port  = "80"
  })
  network_mode = "awsvpc"
execution_role_arn  =
  requires_compatibilities = ["FARGATE"]
  memory                   = "512"
  cpu                      = "256"
  tags                     = module.bekk_test_static_json_label.tags
}

resource "aws_ecs_service" "backend" {
  name            = module.bekk_test_static_json_label.id
  cluster         = aws_ecs_cluster.backend.id
  desired_count   = 1
  task_definition = aws_ecs_task_definition.backend.arn

  # Allow external changes without Terraform plan difference
  # Dermed kan desired_count kunne bruke autoscaling uten at terraform apply vil kjøre endringer
  lifecycle {
    ignore_changes = [desired_count]
  }

  tags = module.bekk_test_static_json_label.tags

}

resource "aws_ecs_cluster" "backend" {
  name = "white-hart"
  tags = module.bekk_test_static_json_label.tags
}
