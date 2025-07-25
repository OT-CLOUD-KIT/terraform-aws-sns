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

variable "sns_topic_tags" {
  type        = map(string)
  default     = {}
  description = "Tags for SNS topic"
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

variable "bu" {
  description = "Business unit name (e.g., BP, GURUKU). Max 6 characters."
  type        = string
  default     = "BP"

  validation {
    condition     = length(var.bu) <= 10
    error_message = "The business unit name must be less than or equal to 6 characters."
  }
}

variable "program" {
  description = "Name of the program (e.g., OT, BP)."
  type        = string
  default     = "OT"
}

variable "app" {
  description = "Application name (e.g., network, shared). Max 6 characters."
  type        = string
  default     = "database"

  validation {
    condition     = length(var.app) <= 10
    error_message = "The app name must be less than or equal to 6 characters."
  }
}

variable "env" {
  description = "Environment code: 'd' (dev), 'p' (prod), 'q' (qa), 's' (stage), 'g' (global)."
  type        = string
  default     = "p"

  validation {
    condition     = contains(["d", "p", "q", "s", "g"], var.env)
    error_message = "env must be one of 'd', 'p', 'q', 's', 'g'."
  }
}

variable "team" {
  description = "Team email responsible for the application (e.g., digitalops@gehealthcare.com)."
  type        = string
  default     = "infra"
}

variable "region" {
  description = "AWS region (e.g., us-east-1, ap-south-1)."
  type        = string
  default     = "us-east-1"
}
