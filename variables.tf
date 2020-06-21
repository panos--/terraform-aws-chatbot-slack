variable "enabled" {
  type = bool
  default = true
  description = "Whether to create resources or not."
}

variable "sns_topic_name" {
  type = string
  description = "Name of SNS topic to subscribe AWS Chatbot to."
}

variable "kms_key_id" {
  type = string
  description = "KMS key id to use with SNS topic."
}

variable "chatbot_config_name" {
  type = string
  description = "Name of Slack channel configuration in AWS Chatbot."
}

variable "slack_workspace_id" {
  type = string
  description = <<-EOT
    ID of the Slack workspace containing the channel to use with AWS Chatbot.
    Can be found in the AWS Chatbot console.
    EOT
}

variable "slack_channel_id" {
  type = string
  description = <<-EOT
    ID of the Slack channel configure with AWS Chatbot.
    Can be determined by right-clicking the channel in Slack and choosing
    copy link. The channel ID is the last part of the copied URL.
    EOT
}

variable "log_level" {
  type = string
  default = "INFO"
  description = <<-EOT
    Log level AWS Chatbot should use. Possible values are ERROR, INFO, NONE.
    EOT
}

variable "chatbot_role_allow_notifications" {
  type = bool
  default = true
  description = <<-EOT
    Grant read access for CloudWatch to AWS Chatbot. Enables Chatbot
    to e.g. show metrics graphs and users to invoke cloudwatch commands in
    Slack.
    EOT
}

variable "chatbot_role_allow_labmda_invoke" {
  type = bool
  default = false
  description = "Allow users to invoke Lambda functions from Slack."
}

variable "chatbot_role_allow_support_access" {
  type = bool
  default = false
  description = "Allow users to interact with AWS support from Slack."
}

variable "chatbot_role_allow_read_only_access" {
  type = bool
  default = false
  description = "Provide users with read access to all AWS resources from within Slack."
}

variable "chatbot_role_permissions_boundary_policy_arn" {
  type = string
  default = ""
  description = <<-EOT
    IAM policy document to use as permissions boundary in the Chatbot IAM role.
    Useful in combination with read only access to limit resources that can
    be accessed from Slack.
    EOT
}
