# terraform-aws-ecs-app-scheduler

[![Lint Status](https://github.com/DNXLabs/terraform-aws-ecs-app-scheduler/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-ecs-app-scheduler/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-ecs-app-scheduler)](https://github.com/DNXLabs/terraform-aws-ecs-app-scheduler/blob/master/LICENSE)

AWS ECS Application Module for Scheduler (no ALB)

This module is designed to be used with `DNXLabs/terraform-aws-ecs`.

<!--- BEGIN_TF_DOCS --->

## Resources

1. [Cloudwatch Events](#Cloudwatch\ Events)
2. [Cron expression](#Cron\ expression)
3. [IAM role](#Iam\ Role)
4. [IAM policy](#IAM\ Policy)
5. [Cloudwatch Log Group](#Cloudwatch\ Log\ Group)
6. [ECS task definition](#Task\ Definition)

## Resources definition

### Cloudwatch Events

Amazon CloudWatch Events delivers a near real-time stream of system events that describe changes in Amazon Web Services (AWS) resources. Using simple rules that you can quickly set up, you can match events and route them to one or more target functions or streams. CloudWatch Events becomes aware of operational changes as they occur. CloudWatch Events responds to these operational changes and takes corrective action as necessary, by sending messages to respond to the environment, activating functions, making changes, and capturing state information.

[Cloudwatch Events documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/WhatIsCloudWatchEvents.html)

### Cron expression

You can create rules that self-trigger on an automated schedule in CloudWatch Events using cron or rate expressions. All scheduled events use UTC time zone and the minimum precision for schedules is 1 minute.

[Schedule expressions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html)

### Iam Role

The cloudwatch event needs an IAM Role to run the ECS task definition. A role is created and a policy will be granted via IAM policy.

### IAM Policy

Policy to be attached to the IAM Role. This policy will have a trust with the cloudwatch event service. And it will use the managed policy `AmazonEC2ContainerServiceEventsRole` created by AWS.

### Cloudwatch Log Group

A log group is a group of log streams that share the same retention, monitoring, and access control settings. You can define log groups and specify which streams to put into each group. There is no limit on the number of log streams that can belong to one log group.

[Log Groups](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/Working-with-log-groups-and-streams.html)

### Task Definition

A task definition is required to run Docker containers in Amazon ECS. Some of the parameters you can specify in a task definition include:

- The Docker image to use with each container in your task
- How much CPU and memory to use with each task or each container within a task
- The launch type to use, which determines the infrastructure on which your tasks are hosted
- The Docker networking mode to use for the containers in your task
- The logging configuration to use for your tasks
- Whether the task should continue to run if the container finishes or fails
- The command the container should run when it is started
- Any data volumes that should be used with the containers in the task
- The IAM role that your tasks should use

[Task definitions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definitions.html)

## Mudule usage

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloudwatch\_logs\_export | Whether to mark the log group to export to an S3 bucket (needs terraform-aws-log-exporter to be deployed in the account/region) | `bool` | `false` | no |
| cloudwatch\_logs\_retention | Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. | `number` | `120` | no |
| cluster\_name | n/a | `string` | `"Name of existing ECS Cluster to deploy this app to"` | no |
| cpu | Hard limit for CPU for the container | `string` | `"0"` | no |
| image | Docker image to deploy (can be a placeholder) | `string` | `"alpine:latest"` | no |
| memory | Hard memory of the container | `string` | `"512"` | no |
| name | Name of your ECS service | `any` | n/a | yes |
| service\_role\_arn | Existing service role ARN created by ECS cluster module | `any` | n/a | yes |
| task\_role\_arn | Existing task role ARN created by ECS cluster module | `any` | n/a | yes |
| vpc\_id | VPC ID to deploy this app to | `any` | n/a | yes |
| rule_enabled | Whether the cloudwatch rule should be enabled | `bool` | true | no |
| launch_type | Instance type | `string`| EC2 | no |
| schedule_expression | Cron based expression. Ref: [Cron Expressions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html#CronExpressions) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aws\_cloudwatch\_log\_group\_arn | n/a |

## Example

```bash
module "example" {
  source = "./.terraform/modules2/terraform-aws-ecs-app-scheduler"

  vpc_id                          = data.aws_vpc.selected.id # From DNXLabs/terraform-aws-ecs
  cluster_name                    = module.ecs_apps.ecs_name # From DNXLabs/terraform-aws-ecs
  service_role_arn                = module.ecs_apps.ecs_service_iam_role_arn # From DNXLabs/terraform-aws-ecs
  task_role_arn                   = module.ecs_apps.ecs_task_iam_role_arn # From DNXLabs/terraform-aws-ecs
  memory                          = 512
  schedule_expression             = "0/30 * * * ? *" # it will trigger the task every 30 minutes https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html
  
  name                   = "example"
}
```

<!--- END_TF_DOCS --->


## Authors

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-ecs-app-scheduler/blob/master/LICENSE) for full details.