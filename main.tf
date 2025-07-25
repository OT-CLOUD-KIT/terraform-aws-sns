#############################
# main.tf
#############################
resource "aws_sns_topic" "sns_topic" {
name = var.fifo_enabled ? "${local.base_name}-${var.sns_topic_name}.fifo" : "${local.base_name}-${var.sns_topic_name}"
  display_name                  = var.sns_display_name
  delivery_policy               = jsonencode(var.sns_delivery_policy)
  policy                        = jsonencode(var.sns_access_policy)
  kms_master_key_id             = var.encryption_enabled ? var.sns_kms_master_key_id : null

  fifo_topic                    = var.fifo_enabled
  content_based_deduplication  = var.fifo_enabled ? var.content_based_deduplication_enabled : null

  http_success_feedback_role_arn          = var.http_feedback_enabled ? aws_iam_role.iam_success_feedback_role.arn : null
  http_failure_feedback_role_arn          = var.http_feedback_enabled ? aws_iam_role.iam_failed_feedback_role.arn : null
  http_success_feedback_sample_rate       = var.http_feedback_enabled ? var.http_success_feedback_sample_rate : 0

  sqs_success_feedback_role_arn           = var.sqs_feedback_enabled ? aws_iam_role.iam_success_feedback_role.arn : null
  sqs_failure_feedback_role_arn           = var.sqs_feedback_enabled ? aws_iam_role.iam_failed_feedback_role.arn : null
  sqs_success_feedback_sample_rate        = var.sqs_feedback_enabled ? var.sqs_success_feedback_sample_rate : 0

  application_success_feedback_role_arn   = var.application_feedback_enabled ? aws_iam_role.iam_success_feedback_role.arn : null
  application_failure_feedback_role_arn   = var.application_feedback_enabled ? aws_iam_role.iam_failed_feedback_role.arn : null
  application_success_feedback_sample_rate = var.application_feedback_enabled ? var.application_success_feedback_sample_rate : 0

  lambda_success_feedback_role_arn        = var.lambda_feedback_enabled ? aws_iam_role.iam_success_feedback_role.arn : null
  lambda_failure_feedback_role_arn        = var.lambda_feedback_enabled ? aws_iam_role.iam_failed_feedback_role.arn : null
  lambda_success_feedback_sample_rate     = var.lambda_feedback_enabled ? var.lambda_success_feedback_sample_rate : 0

  # tags = merge({
  #   Name        = var.sns_topic_name
  #   PROVISIONER = "Terraform"
  # }, var.sns_topic_tags)

  tags = merge(
  {
    Name = var.fifo_enabled ? "${local.base_name}-${var.sns_topic_name}.fifo" : "${local.base_name}-${var.sns_topic_name}"
  },
  local.common_tags,
  var.sns_topic_tags
)

}

resource "aws_iam_role" "iam_success_feedback_role" {
  name               = "${local.base_name}-SNSSuccessFeedbackRole"
  assume_role_policy = jsonencode(var.iam_assume_role)
}

resource "aws_iam_role" "iam_failed_feedback_role" {
  name               = "${local.base_name}-SNSFailedFeedbackRole"
  assume_role_policy = jsonencode(var.iam_assume_role)
}

resource "aws_iam_role_policy" "iam_success_feedback_role_policy" {
  name   = "${local.base_name}-${var.snssuccessfeedbackpolicy}"
  role   = aws_iam_role.iam_success_feedback_role.id
  policy = jsonencode(var.iam_sns_policy)
}

resource "aws_iam_role_policy" "iam_failed_feedback_role_policy" {
  name   = "${local.base_name}-${var.snsfailedfeedbackpolicy}"
  role   = aws_iam_role.iam_failed_feedback_role.id
  policy = jsonencode(var.iam_sns_policy)
}

resource "aws_sns_topic_subscription" "sns_topic_subscription" {
  for_each = var.sns_subscription_setting

  topic_arn                        = aws_sns_topic.sns_topic.arn
  protocol                         = each.value.protocol
  endpoint                         = each.value.endpoint
  endpoint_auto_confirms           = var.endpoint_auto_confirms
  confirmation_timeout_in_minutes = var.confirmation_timeout_in_minutes
  raw_message_delivery             = contains(["sqs", "http", "https"], each.value.protocol) ? try(each.value.raw_message_delivery, false) : false
  filter_policy                    = var.filter_policy
  delivery_policy                  = var.delivery_policy
  
}
