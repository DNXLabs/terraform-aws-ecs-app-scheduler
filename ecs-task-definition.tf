resource "aws_ecs_task_definition" "default" {
  family = "${var.cluster_name}-${var.name}"

  execution_role_arn = var.task_role_arn
  task_role_arn      = var.task_role_arn

  container_definitions = <<EOT
[
  {
    "name": "${var.name}",
    "image": "${var.image}",
    "command": ["echo","${var.cluster_name}: ECS scheduled task"],
    "cpu": ${var.cpu},
    "memory": ${var.memory},
    "essential": true,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.default.name}",
          "awslogs-region": "${data.aws_region.current.name}",
          "awslogs-stream-prefix": "${var.name}"
      }
    }
  }
]
EOT
}