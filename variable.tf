## SNS topic variables

variable "sns_topic_name" {
  description = " friendly name for the SNS topic"
  type        = string
  default     = ""
}

variable "sns_display_name" {
  description = "Display name for SNS topic"
  type        = string
  default     = ""
}

variable "sns_delivery_policy" {
  description = "The SNS delivery policy"
  type        = string
  default     = ""
}

variable "sns_access_policy" {
  description = " The fully-formed AWS policy as JSON"
  type        = string
  default     = ""
}

variable "encryption_enabled" {
  description = "To enable encryption for SNS Topic"
  type        = bool
  default = false
}

variable "sns_kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK"
  type        = string
  default     = ""
}

variable "http_feedback_enabled" {
  description = "To enable HTTP success/failure feedback for SNS topic"
  type        = bool
  default = false
}

variable "sqs_feedback_enabled" {
  description = "To enable SQS success/failure feedback for SNS topic"
  type        = bool
  default = false
}

variable "application_feedback_enabled" {
  description = "To enable application success/failure feedback for SNS topic"
  type        = bool
  default = false
}

variable "lambda_feedback_enabled" {
  description = "To enable Lambda success/failure feedback for SNS topic"
  type        = bool
  default = false
}

variable "http_success_feedback_sample_rate" {
  description = "Percentage of success to sample"
  type        = string
  default     = ""
}

variable "sqs_success_feedback_sample_rate" {
  description = "Percentage of success to sample"
  type        = string
  default     = ""
}

variable "application_success_feedback_sample_rate" {
  description = "Percentage of success to sample"
  type        = string
  default     = ""
}

variable "lambda_success_feedback_sample_rate" {
  description = "Percentage of success to sample"
  type        = string
  default     = ""
}

variable "sns_topic_tags" {
  description = "Additional tags for sns topic"
  type        = map(string)
  default     = {}
}

## IAM role/policy for SNS

variable "snsfailedfeedbackpolicy" {
  description = "The IAM policy name permitted to receive failed feedback for SNS topic"
  type        = string
  default     = "SNSFailedFeedbackPolicy"
}

variable "snssuccessfeedbackpolicy" {
  description = "The IAM policy name permitted to receive feedback for SNS topic"
  type        = string
  default     = "SNSSuccessFeedbackPolicy"
}

variable "iam_assume_role" {
  description = "SNS IAM assume role"
  type        = string
  default     = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
        "Service": "sns.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
    }
    ]
  }
  EOF
}

variable "iam_sns_policy" {
  description = "SNS topic IAM policy for cloudwatch logs"
  type        = string
  default     = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:PutMetricFilter",
        "logs:PutRetentionPolicy"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

## SNS subscription variables

variable "sns_subscription_setting" {
  description = "Use to specify sns subscription details"
  type        = map(any)
  default     = {}
}

variable "filter_policy" {
  description = "JSON String with the filter policy that will be used in the subscription to filter messages seen by the target resource. "
  type        = string
  default     = ""
}

variable "delivery_policy" {
  description = "JSON String with the delivery policy (retries, backoff, etc.) that will be used in the subscription - this only applies to HTTP/S subscriptions."
  type        = string
  default     = ""
}

variable "confirmation_timeout_in_minutes" {
  description = "Integer indicating number of minutes to wait in retying mode for fetching subscription arn before marking it as failure."
  type        = number
  default     = 1
}

variable "endpoint_auto_confirms" {
  description = "Boolean indicating whether the end point is capable of auto confirming subscription e.g., PagerDuty"
  type        = bool
  default = true
}
