# terraform-aws-ecs-app-scheduler

[![Lint Status](https://github.com/DNXLabs/terraform-aws-ecs-app-scheduler/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-ecs-app-scheduler/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-ecs-app-scheduler)](https://github.com/DNXLabs/terraform-aws-ecs-app-scheduler/blob/master/LICENSE)

AWS ECS Application Module for Scheduler (no ALB)

This module is designed to be used with `DNXLabs/terraform-aws-ecs`.

<!--- BEGIN_TF_DOCS --->

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
| event\_description | n/a | `string` | `"ECS task"` | no |
| iam\_path | n/a | `string` | `"/"` | no |
| image | Docker image to deploy (can be a placeholder) | `string` | `"alpine:latest"` | no |
| launch\_type | Instance type. Fargate allowed | `string` | `"EC2"` | no |
| memory | Hard memory of the container | `string` | `"512"` | no |
| name | Name of your ECS service | `any` | n/a | yes |
| rule\_enabled | Whether the rule should be enabled | `bool` | `true` | no |
| schedule\_expression | Cron expression | `any` | n/a | yes |
| service\_role\_arn | Existing service role ARN created by ECS cluster module | `any` | n/a | yes |
| task\_role\_arn | Existing task role ARN created by ECS cluster module | `any` | n/a | yes |
| vpc\_id | VPC ID to deploy this app to | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aws\_cloudwatch\_log\_group\_arn | n/a |

<!--- END_TF_DOCS --->


## Authors

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-ecs-app-scheduler/blob/master/LICENSE) for full details.