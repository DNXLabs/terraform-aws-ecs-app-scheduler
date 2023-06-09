variable "name" {
  description = "Name of your ECS service"
}

variable "memory" {
  default     = "512"
  description = "Hard memory of the container"
}

variable "cpu" {
  default     = "0"
  description = "Hard limit for CPU for the container"
}

variable "cluster_name" {
  default = "Name of existing ECS Cluster to deploy this app to"
  type = string
}

variable "service_role_arn" {
  description = "Existing service role ARN created by ECS cluster module"
  type = string
}

variable "task_role_arn" {
  description = "Existing task role ARN created by ECS cluster module"
  type = string
}

variable "image" {
  description = "Docker image to deploy (can be a placeholder)"
  default     = "alpine:latest"
  type = string
}

variable "vpc_id" {
  description = "VPC ID to deploy this app to"
  type = string
}

variable "subnets_ids" {
  type    = list(string)
  default = null
}

variable "security_group_ids" {
  type    = list(string)
  default = null
}

variable "assign_public_ip" {
  type    = bool
  default = null
}

variable "platform_version" {
  type    = string
  default = "LATEST"
}

variable "cloudwatch_logs_retention" {
  default     = 120
  type = number
  description = "Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653."
}

variable "cloudwatch_logs_export" {
  default     = false
  type = bool
  description = "Whether to mark the log group to export to an S3 bucket (needs terraform-aws-log-exporter to be deployed in the account/region)"
}

variable "rule_enabled" {
  default     = true
  type = bool
  description = "Whether the rule should be enabled"
}

variable "launch_type" {
  default     = "EC2"
  type = string
  description = "Instance type. Fargate allowed"
}

variable "schedule_expression" {
  description = "Cron expression"
  type        = string
}

variable "iam_path" {
  default = "/"
  type    = string
}

variable "event_description" {
  default = "ECS task"
  type = string
}

variable "account_id" {
}
