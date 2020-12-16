module "chatbot" {
  source = "../../"

  enabled = true

  chatbot_config_name = "chatbot-terraform-test"
  sns_topic_name = "chatbot-terraform-test"
  kms_key_id = var.kms_key_id
  slack_workspace_id = var.slack_workspace_id
  slack_channel_id = var.slack_channel_id
  log_level = "INFO"

  chatbot_role_allow_notifications = true
  chatbot_role_allow_labmda_invoke = true
  chatbot_role_allow_support_access = true
  chatbot_role_allow_read_only_access = true
  chatbot_role_permissions_boundary_policy_arn = var.chatbot_role_permissions_boundary_policy_arn
}
