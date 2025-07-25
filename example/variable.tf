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

variable "sns_topic_tags" {
  type    = map(string)
  default = {}
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


variable "env" {
  description = "Environment short name. Must be one of: d (dev), p (prod), q (qa), s (stage), g (global)."
  type        = string
  default     = "d"
  validation {
    condition     = contains(["d", "p", "q", "s", "g"], var.env)
    error_message = "env must be one of 'd', 'p', 'q', 's', 'g'."
  }
}

variable "bu" {
  description = "Business unit name (e.g., pcs, ultrasound). Max 5 characters."
  type        = string
  default     = "ot"
  validation {
    condition     = length(var.bu) <= 5
    error_message = "The business unit name must be less than or equal to 5 characters."
  }
}

variable "app" {
  description = "Application name (e.g., network, shared). Max 6 characters."
  type        = string
  default     = "bp"
  validation {
    condition     = length(var.app) <= 6
    error_message = "The app name must be less than or equal to 6 characters."
  }
}

variable "resource" {
  description = "Resource name (e.g., eks, efs, ecr). Max 15 characters."
  type        = string
  default     = "instance"
  validation {
    condition     = length(var.resource) <= 15
    error_message = "The resource name must be less than or equal to 15 characters."
  }
}

variable "tenant" {
  description = "Tenant name (e.g., app1, app2). Max 6 characters."
  type        = string
  default     = ""
  validation {
    condition     = length(var.tenant) <= 6
    error_message = "The tenant name must be less than or equal to 6 characters."
  }
}

variable "enabled_features" {
  type    = list(string)
  default = []
}

variable "random_alphanumeric_len" {
  description = "The length of random alphanumeric string desired. Min: 1, Max: 4."
  type        = number
  default     = 4
  validation {
    condition     = var.random_alphanumeric_len >= 1 && var.random_alphanumeric_len <= 4
    error_message = "The length must be between 1 and 4."
  }
}

variable "special" {
  description = "Include special characters like !@#$%&*()-_=+[]{}<>:? in the generated name."
  type        = bool
  default     = false
}

variable "upper" {
  description = "Include uppercase characters in the generated name."
  type        = bool
  default     = false
}

variable "number" {
  description = "Include numbers in the generated name."
  type        = bool
  default     = true
}

variable "gen_no_of_names" {
  description = "Number of names to generate."
  type        = number
  default     = 1
}

variable "team" {
  description = "The email address of the team who owns the application, ex:digitalops@gehealthcare.com"
  type        = string
  default     = "infra"
}

variable "program" {
  description = "Name of the Program, For ex: OT, BP etc."
  type        = string
  default     = "ot"
}

variable "region" {
  type    = string
  default = "us-east-1"
}
