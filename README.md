# terraform-aws-chatbot-slack

Terraform module setting up Slack notifications from AWS using
[AWS Chatbot](https://docs.aws.amazon.com/chatbot/index.html).

This module creates a Slack channel configuration in AWS Chatbot,
an SNS topic which Chatbot is subscribed to as well as IAM permissions
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
> steps 1 to 5 of [Setting up AWS Chatbot with Slack](https://docs.aws.amazon.com/chatbot/latest/adminguide/slack-setup.html#slack-client-setup).

See [example](examples/complete).

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.20 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudformation_stack.slack_channel_config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack) | resource |
| [aws_cloudwatch_event_rule.health](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.health](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_role.chatbot](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.chatbot_lambda_invoke](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.chatbot_notifications](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.chatbot_read_only_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.chatbot_support_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_sns_topic.chatbot](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.chatbot_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.chatbot_lambda_invoke](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.chatbot_notifications_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sns_chatbot](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chatbot_config_name"></a> [chatbot\_config\_name](#input\_chatbot\_config\_name) | Name of Slack channel configuration in AWS Chatbot. | `string` | n/a | yes |
| <a name="input_chatbot_role_allow_labmda_invoke"></a> [chatbot\_role\_allow\_labmda\_invoke](#input\_chatbot\_role\_allow\_labmda\_invoke) | Allow users to invoke Lambda functions from Slack. | `bool` | `false` | no |
| <a name="input_chatbot_role_allow_notifications"></a> [chatbot\_role\_allow\_notifications](#input\_chatbot\_role\_allow\_notifications) | Grant read access for CloudWatch to AWS Chatbot. Enables Chatbot<br>to e.g. show metrics graphs and users to invoke cloudwatch commands in<br>Slack. | `bool` | `true` | no |
| <a name="input_chatbot_role_allow_read_only_access"></a> [chatbot\_role\_allow\_read\_only\_access](#input\_chatbot\_role\_allow\_read\_only\_access) | Provide users with read access to all AWS resources from within Slack. | `bool` | `false` | no |
| <a name="input_chatbot_role_allow_support_access"></a> [chatbot\_role\_allow\_support\_access](#input\_chatbot\_role\_allow\_support\_access) | Allow users to interact with AWS support from Slack. | `bool` | `false` | no |
| <a name="input_chatbot_role_permissions_boundary_policy_arn"></a> [chatbot\_role\_permissions\_boundary\_policy\_arn](#input\_chatbot\_role\_permissions\_boundary\_policy\_arn) | IAM policy document to use as permissions boundary in the Chatbot IAM role.<br>Useful in combination with read only access to limit resources that can<br>be accessed from Slack. | `string` | `""` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether to create resources or not. | `bool` | `true` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | KMS key id to use with SNS topic. | `string` | `""` | no |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | Log level AWS Chatbot should use. Possible values are ERROR, INFO, NONE. | `string` | `"INFO"` | no |
| <a name="input_slack_channel_id"></a> [slack\_channel\_id](#input\_slack\_channel\_id) | ID of the Slack channel configure with AWS Chatbot.<br>Can be determined by right-clicking the channel in Slack and choosing<br>copy link. The channel ID is the last part of the copied URL. | `string` | n/a | yes |
| <a name="input_slack_workspace_id"></a> [slack\_workspace\_id](#input\_slack\_workspace\_id) | ID of the Slack workspace containing the channel to use with AWS Chatbot.<br>Can be found in the AWS Chatbot console. | `string` | n/a | yes |
| <a name="input_sns_topic_name"></a> [sns\_topic\_name](#input\_sns\_topic\_name) | Name of SNS topic to subscribe AWS Chatbot to. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of IAM role assigned to AWS Chatbot. |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | Name of IAM role assigned to AWS Chatbot. |
| <a name="output_sns_topic_arn"></a> [sns\_topic\_arn](#output\_sns\_topic\_arn) | ARN of SNS topic which AWS Chatbot is subscribed to. |
