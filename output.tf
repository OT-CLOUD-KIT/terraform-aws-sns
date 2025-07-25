output "sns_topic_arn" {
  value       = aws_sns_topic.sns_topic.arn
  description = "ARN of the SNS topic"
}

output "sns_topic_name" {
  value       = aws_sns_topic.sns_topic.name
  description = "Name of the SNS topic"
}

output "sns_subscriptions" {
  value       = [for sub in aws_sns_topic_subscription.sns_topic_subscription : sub.arn]
  description = "List of subscription ARNs"
}
