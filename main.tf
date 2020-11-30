## SNS topic module

resource "aws_sns_topic" "sns_topic" {
  name = var.sns_topic_name
  delivery_policy = var.sns_delivery_policy
  policy = var.sns_access_policy
  display_name = var.sns_display_name
  kms_master_key_id = var.encryption_enabled == true ? var.sns_kms_master_key_id : ""
  http_success_feedback_role_arn = var.http_feedback_enabled == true ? aws_iam_role.iam_success_feedback_role.arn : ""
  http_failure_feedback_role_arn = var.http_feedback_enabled == true ? aws_iam_role.iam_failed_feedback_role.arn : ""
  http_success_feedback_sample_rate = var.http_feedback_enabled == true ? var.http_success_feedback_sample_rate : 0
  sqs_success_feedback_role_arn = var.sqs_feedback_enabled == true ? aws_iam_role.iam_success_feedback_role.arn : ""
  sqs_failure_feedback_role_arn = var.sqs_feedback_enabled == true ? aws_iam_role.iam_failed_feedback_role.arn : ""
  sqs_success_feedback_sample_rate = var.sqs_feedback_enabled == true ? var.sqs_success_feedback_sample_rate : 0
  application_success_feedback_role_arn = var.application_feedback_enabled == true ? aws_iam_role.iam_success_feedback_role.arn : ""
  application_failure_feedback_role_arn = var.application_feedback_enabled == true ? aws_iam_role.iam_failed_feedback_role.arn : ""
  application_success_feedback_sample_rate = var.application_feedback_enabled == true ? var.application_success_feedback_sample_rate : 0
  lambda_success_feedback_role_arn = var.lambda_feedback_enabled == true ? aws_iam_role.iam_success_feedback_role.arn : ""
  lambda_failure_feedback_role_arn = var.lambda_feedback_enabled == true ? aws_iam_role.iam_failed_feedback_role.arn : ""
  lambda_success_feedback_sample_rate = var.lambda_feedback_enabled == true ? var.lambda_success_feedback_sample_rate : 0
  tags = merge(
    {
      Name = var.sns_topic_name
    },
    {
      PROVISIONER = "Terraform"
    },
    var.sns_topic_tags,
  )
}

## IAM role/policy for SNS feebacks

resource "aws_iam_role_policy" "iam_failed_feedback_role_policy" {
  name = var.snsfailedfeedbackpolicy
  role = aws_iam_role.iam_failed_feedback_role.id
  policy = var.iam_sns_policy
}

resource "aws_iam_role_policy" "iam_success_feedback_role_policy" {
  name = var.snssuccessfeedbackpolicy
  role = aws_iam_role.iam_success_feedback_role.id
  policy = var.iam_sns_policy
}

resource "aws_iam_role" "iam_failed_feedback_role" {
  name = "SNSFailedFeedbackRole"
  assume_role_policy = var.iam_assume_role
}

resource "aws_iam_role" "iam_success_feedback_role" {
  name = "SNSSuccessFeedbackRole"
  assume_role_policy = var.iam_assume_role
}

## SNS Subscription

resource "aws_sns_topic_subscription" "sns-topic-subscription" {
    for_each = var.sns_subscription_setting
    topic_arn = aws_sns_topic.sns_topic.arn
    protocol  = each.value.protocol
    endpoint  = each.value.endpoint
    endpoint_auto_confirms = var.endpoint_auto_confirms
    confirmation_timeout_in_minutes = var.confirmation_timeout_in_minutes
    raw_message_delivery = each.value.protocol == "sqs" || each.value.protocol == "http" || each.value.protocol == "https"  ? each.value.raw_message_delivery : false
    filter_policy = var.filter_policy
    delivery_policy = var.delivery_policy
}
