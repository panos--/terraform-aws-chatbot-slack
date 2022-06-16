output "sns_topic_arn" {
  value       = var.enabled ? aws_sns_topic.chatbot[0].arn : ""
  description = "ARN of SNS topic which AWS Chatbot is subscribed to."
}

output "iam_role_name" {
  value       = var.enabled ? aws_iam_role.chatbot[0].name : ""
  description = "Name of IAM role assigned to AWS Chatbot."
}

output "iam_role_arn" {
  value       = var.enabled ? aws_iam_role.chatbot[0].arn : ""
  description = "ARN of IAM role assigned to AWS Chatbot."
}
