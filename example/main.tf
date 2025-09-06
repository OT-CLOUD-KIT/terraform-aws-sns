
module "sns_topic" {
  source = "git@github.com:OT-CLOUD-KIT/terraform-aws-sns.git?ref=Feature"

  sns_topic_name                         = var.sns_topic_name
  sns_display_name                       = var.sns_display_name
  fifo_enabled                           = var.fifo_enabled
  content_based_deduplication_enabled    = var.content_based_deduplication_enabled
  encryption_enabled                     = var.encryption_enabled
  sns_kms_master_key_id                  = var.sns_kms_master_key_id
  sns_delivery_policy                    = var.sns_delivery_policy
  sns_access_policy                      = var.sns_access_policy
  env = var.env
  owner = var.owner
  app = var.app

  http_feedback_enabled                  = var.http_feedback_enabled
  sqs_feedback_enabled                   = var.sqs_feedback_enabled
  application_feedback_enabled           = var.application_feedback_enabled
  lambda_feedback_enabled                = var.lambda_feedback_enabled

  http_success_feedback_sample_rate      = var.http_success_feedback_sample_rate
  sqs_success_feedback_sample_rate       = var.sqs_success_feedback_sample_rate
  application_success_feedback_sample_rate = var.application_success_feedback_sample_rate
  lambda_success_feedback_sample_rate    = var.lambda_success_feedback_sample_rate

  iam_assume_role                        = var.iam_assume_role
  iam_sns_policy                         = var.iam_sns_policy
  snssuccessfeedbackpolicy              = var.snssuccessfeedbackpolicy
  snsfailedfeedbackpolicy               = var.snsfailedfeedbackpolicy

  sns_subscription_setting               = var.sns_subscription_setting
  endpoint_auto_confirms                 = var.endpoint_auto_confirms
  confirmation_timeout_in_minutes        = var.confirmation_timeout_in_minutes
  filter_policy                          = var.filter_policy
  delivery_policy                        = var.delivery_policy
}
