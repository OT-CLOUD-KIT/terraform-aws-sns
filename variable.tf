variable "sns_topic_name" {
  type        = string
  description = "SNS topic name"
  default     = "topic"
}

variable "sns_display_name" {
  type        = string
  description = "Display name for SNS topic (SMS-compatible)"
  default     = "MySNSTopic"
}

variable "sns_delivery_policy" {
  type        = any
  description = "SNS delivery policy (as object)"
  default     = {}
}

variable "sns_access_policy" {
  type        = any
  description = "SNS access policy (as object)"
  default     = {}
}


variable "encryption_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable KMS encryption"
}

variable "sns_kms_master_key_id" {
  type        = string
  default     = null
  description = "KMS key ARN for SNS topic encryption"
}

# Feedback role controls
variable "http_feedback_enabled" {
  type    = bool
  default = false
}

variable "sqs_feedback_enabled" {
  type    = bool
  default = false
}

variable "application_feedback_enabled" {
  type    = bool
  default = false
}

variable "lambda_feedback_enabled" {
  type    = bool
  default = false
}

variable "http_success_feedback_sample_rate" {
  type    = number
  default = 0
}

variable "sqs_success_feedback_sample_rate" {
  type    = number
  default = 0
}

variable "application_success_feedback_sample_rate" {
  type    = number
  default = 0
}

variable "lambda_success_feedback_sample_rate" {
  type    = number
  default = 0
}

# IAM Policies
variable "iam_assume_role" {
  type    = any
  default = {
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "sns.amazonaws.com"
        }
      }
    ]
  }
}

variable "iam_sns_policy" {
  type    = any
  default = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sns:Publish",
          "sns:Subscribe"
        ]
        Resource = "*"
      }
    ]
  }
}

variable "snsfailedfeedbackpolicy" {
  type    = string
  default = "SNSFailedFeedbackPolicy"
}

variable "snssuccessfeedbackpolicy" {
  type    = string
  default = "SNSSuccessFeedbackPolicy"
}

# Subscriptions
variable "sns_subscription_setting" {
  type = map(object({
    protocol             = string
    endpoint             = string
    raw_message_delivery = optional(bool)
  }))
  description = "SNS topic subscriptions"
  default     = {}
}

variable "endpoint_auto_confirms" {
  type    = bool
  default = false
}

variable "confirmation_timeout_in_minutes" {
  type    = number
  default = 1
}

variable "filter_policy" {
  type    = any
  default = null
}

variable "delivery_policy" {
  type    = any
  default = null
}

variable "fifo_enabled" {
  type        = bool
  default     = false
  description = "Enable FIFO SNS topic"
}

variable "content_based_deduplication_enabled" {
  type        = bool
  default     = false
  description = "Enable content-based deduplication for FIFO topics"
}

variable "owner" {
 type = string
 default = "opstree"
}

variable "env" {
  type = string
  default = "dev"
}

variable "app" {
  type = string
  default = "otcloud-kit"
}