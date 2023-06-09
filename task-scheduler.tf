data "aws_ecs_cluster" "ecs_apps" {
  cluster_name = var.cluster_name
}

resource "aws_cloudwatch_event_rule" "default" {
  name                = var.name
  description         = var.event_description
  is_enabled          = var.rule_enabled
  schedule_expression = "cron(${var.schedule_expression})"
}

resource "aws_cloudwatch_event_target" "default" {
  target_id   = var.name
  arn         = data.aws_ecs_cluster.ecs_apps.arn
  rule        = aws_cloudwatch_event_rule.default.name
  role_arn    = aws_iam_role.ecs_events.arn
  launch_type = var.launch_type


  ecs_target {
    task_definition_arn = "arn:aws:ecs:${data.aws_region.current.name}:${var.account_id}:task-definition/${var.cluster_name}-${var.name}"
    #platform_version = var.platform_version
    network_configuration {
      subnets          = var.subnet_ids
      security_groups  = var.security_group_ids
      assign_public_ip = var.assign_public_ip
    }
  }
}

resource "aws_iam_role" "ecs_events" {
  name               = local.ecs_events_iam_name
  assume_role_policy = data.aws_iam_policy_document.ecs_events_assume_role_policy.json
  path               = var.iam_path
  description        = var.event_description
  tags               = { "Name" = local.ecs_events_iam_name }
}

data "aws_iam_policy_document" "ecs_events_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "ecs_events" {
  name        = local.ecs_events_iam_name
  policy      = data.aws_iam_policy.ecs_events.policy
  path        = var.iam_path
  description = var.event_description
}

data "aws_iam_policy" "ecs_events" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceEventsRole"
}

resource "aws_iam_role_policy_attachment" "ecs_events" {
  role       = aws_iam_role.ecs_events.name
  policy_arn = aws_iam_policy.ecs_events.arn
}

locals {
  ecs_events_iam_name = "${var.name}-ecs-events"
}
