output "sns_topic_id" {
  description = "SNS topic id"
  value       = aws_sns_topic.sns_topic.id
}

output "secret_name" {
  description = "SNS Topic ARN"
  value       = aws_sns_topic.sns_topic.arn
}
