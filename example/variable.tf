variable "sns_topic_name" {
  type = string
}

variable "sns_display_name" {
  type = string
}

variable "fifo_enabled" {
  type    = bool
  default = false
}

variable "content_based_deduplication_enabled" {
  type    = bool
  default = false
}

variable "encryption_enabled" {
  type    = bool
  default = false
}

variable "sns_kms_master_key_id" {
  type    = string
  default = null
}

variable "sns_delivery_policy" {
  type = any
}

variable "sns_access_policy" {
  type = any
}



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

variable "iam_assume_role" {
  type = any
}

variable "iam_sns_policy" {
  type = any
}

variable "snssuccessfeedbackpolicy" {
  type = string
}

variable "snsfailedfeedbackpolicy" {
  type = string
}

variable "sns_subscription_setting" {
  type = map(object({
    protocol             = string
    endpoint             = string
    raw_message_delivery = optional(bool)
  }))
  default = {}
}

variable "endpoint_auto_confirms" {
  type    = bool
  default = true
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

variable "region" {
  type = string
  default = "us-east-1"
}