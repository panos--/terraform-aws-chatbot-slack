# terraform-aws-chatbot-slack

Terraform module setting up Slack notifications from AWS using
[AWS Chatbot](https://docs.aws.amazon.com/chatbot/index.html).

This module creates a Slack channel configuration in AWS Chatbot,
an SNS topic which Chatbot is subsribed to as well as IAM permissions
required for supported services to publish to the SNS topic.

See [Using AWS Chatbot with other AWS services](https://docs.aws.amazon.com/chatbot/latest/adminguide/related-services.html)
for supported sources of notifications.

Additionally an IAM role for Chatbot itself is created which defines
what Chatbot can do via Slack commands. Permissions corresponding to
the policy templates provided by the AWS Chatbot console are supported
by this module.

Currently this module creates a CloudWatch Events rule forwarding AWS Health
events to AWS Chatbot. AWS Config, GuardDuty and Security Hub should follow.

Implementation note: Since terraform does [not support](https://github.com/terraform-providers/terraform-provider-aws/issues/12304) AWS Chatbot yet this module uses a [CloudFormation Stack resource](https://www.terraform.io/docs/providers/aws/r/cloudformation_stack.html) to create the slack channel configuration.

## Usage

> NOTE: Before applying this module AWS Chatbot has to be manually
> authorized to access the Slack workspace in question by performing
> steps 1 to 4 of [Setting up AWS Chatbot with Slack](https://docs.aws.amazon.com/chatbot/latest/adminguide/getting-started.html#slack-setup).

See [example](examples/complete).

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.20 |
| aws | >= 2.0 |
| template | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| chatbot\_config\_name | Name of Slack channel configuration in AWS Chatbot. | `string` | n/a | yes |
| chatbot\_role\_allow\_labmda\_invoke | Allow users to invoke Lambda functions from Slack. | `bool` | `false` | no |
| chatbot\_role\_allow\_notifications | Grant read access for CloudWatch to AWS Chatbot. Enables Chatbot<br>to e.g. show metrics graphs and users to invoke cloudwatch commands in<br>Slack. | `bool` | `true` | no |
| chatbot\_role\_allow\_read\_only\_access | Provide users with read access to all AWS resources from within Slack. | `bool` | `false` | no |
| chatbot\_role\_allow\_support\_access | Allow users to interact with AWS support from Slack. | `bool` | `false` | no |
| chatbot\_role\_permissions\_boundary\_policy\_arn | IAM policy document to use as permissions boundary in the Chatbot IAM role.<br>Useful in combination with read only access to limit resources that can<br>be accessed from Slack. | `string` | `""` | no |
| enabled | Whether to create resources or not. | `bool` | `true` | no |
| kms\_key\_id | KMS key id to use with SNS topic. | `string` | `""` | no |
| log\_level | Log level AWS Chatbot should use. Possible values are ERROR, INFO, NONE. | `string` | `"INFO"` | no |
| slack\_channel\_id | ID of the Slack channel configure with AWS Chatbot.<br>Can be determined by right-clicking the channel in Slack and choosing<br>copy link. The channel ID is the last part of the copied URL. | `string` | n/a | yes |
| slack\_workspace\_id | ID of the Slack workspace containing the channel to use with AWS Chatbot.<br>Can be found in the AWS Chatbot console. | `string` | n/a | yes |
| sns\_topic\_name | Name of SNS topic to subscribe AWS Chatbot to. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| iam\_role\_arn | ARN of IAM role assigned to AWS Chatbot. |
| iam\_role\_name | Name of IAM role assigned to AWS Chatbot. |
| sns\_topic\_arn | ARN of SNS topic which AWS Chatbot is subscribed to. |

