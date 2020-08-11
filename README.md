# terraform-aws-ecs-app-scheduler

AWS ECS Application Module for Scheduler with no Application Load Balancer (ALB)

This module is designed to be used with `DNXLabs/terraform-aws-ecs`.

This module requires:
 - Terraform Version >=0.12.20

This modules creates the following resources:

 - IAM roles - The cloudwatch event needs an IAM Role to run the ECS task definition. A role is created and a policy will be granted via IAM policy.
 - IAM policy - Policy to be attached to the IAM Role. This policy will have a trust with the cloudwatch event service. And it will use the managed policy `AmazonEC2ContainerServiceEventsRole` created by AWS.
 - Cloudwatch Log Groups   
      - You can specify the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653.
      - Export to a S3 Bucket - Whether to mark the log group to export to an S3 bucket (needs the module terraform-aws-log-exporter (https://github.com/DNXLabs/terraform-aws-log-exporter) to be deployed in the account/region)
 - ECS task definition - A task definition is required to run Docker containers in Amazon ECS. Some of the parameters you can specify in a task definition include:
      - Image - Docker image to deploy 
           -  Default Value = "alpine:latest"
      - CPU - Hard limit of the CPU for the container
           -  Default Value = 0
      - Memory - Hard memory of the container
           -  Default Value = 512
      - Name - Name of the ECS Service
      - Set log configuration

 - ECS Task-scheduler activated by cloudwatch events
 - Cron expression - You can create rules that self-trigger on an automated schedule in CloudWatch Events using cron or rate expressions. All scheduled events use UTC time zone and the minimum precision for schedules is 1 minute.

[![Lint Status](https://github.com/DNXLabs/terraform-aws-ecs-app-scheduler/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-ecs-app-scheduler/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-ecs-app-scheduler)](https://github.com/DNXLabs/terraform-aws-ecs-app-scheduler/blob/master/LICENSE)

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

  

  source               = "git::https://github.com/DNXLabs/terraform-aws-ecs-app-scheduler?ref=0.0.2"
  name                 = "example"
  vpc_id               = data.aws_vpc.selected.id # From DNXLabs/terraform-aws-ecs
  cluster_name         = module.ecs_apps.ecs_name # From DNXLabs/terraform-aws-ecs
  service_role_arn     = module.ecs_apps.ecs_service_iam_role_arn # From DNXLabs/terraform-aws-ecs
  task_role_arn        = module.ecs_apps.ecs_task_iam_role_arn # From DNXLabs/terraform-aws-ecs
  memory               = 512
  schedule_expression  = "0/30 * * * ? *" # it will trigger the task every 30 minutes https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html
  account_id           = var.aws_account_id
}


}
```

<!--- END_TF_DOCS --->


## Authors

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-ecs-app-scheduler/blob/master/LICENSE) for full details.
