variable "kms_key_id" {
  type = string
}

variable "slack_workspace_id" {
  type = string
}

variable "slack_channel_id" {
  type = string
}

variable "chatbot_role_permissions_boundary_policy_arn" {
  type = string
  default = ""
}
