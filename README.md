AWS SNS Topic & Subscription Terraform module
======================================

Terraform module which creates SNS topic & subscription on AWS.

These types of resources are supported:

[SNS Topic & Subscription](https://aws.amazon.com/sns/)

Terraform versions
------------------

Terraform 0.13.

Tags
----
* Tags are assigned to resources with name variable as prefix.
* Additial tags can be assigned by tags variables as defined above.


usage 
-----

```
module "sns_topic" {
  source = "../sns-topic"
  sns_topic_name = var.sns_topic_name
  sns_display_name = var.sns_display_name
  sns_topic_tags = var.sns_topic_tags
  sns_kms_master_key_id = var.sns_kms_master_key_id
  http_success_feedback_sample_rate = var.http_success_feedback_sample_rate
  sqs_success_feedback_sample_rate = var.sqs_success_feedback_sample_rate
  application_success_feedback_sample_rate = var.application_success_feedback_sample_rate
  lambda_success_feedback_sample_rate = var.lambda_success_feedback_sample_rate
  http_feedback_enabled = var.http_feedback_enabled
  encryption_enabled = var.encryption_enabled
  sqs_feedback_enabled = var.sqs_feedback_enabled
  application_feedback_enabled = var.application_feedback_enabled
  lambda_feedback_enabled = var.lambda_feedback_enabled
  sns_subscription_setting = var.snssub_settings
}

# Under varaible 

variable "snssub_settings" {
  default     = {
    "sqsname" = { protocol = "sqs", endpoint = "ARN", raw_message_delivery = true },
    "httpname" = { protocol = "http", endpoint = "HTTP URL", raw_message_delivery = true },
    "sqsname2" = { protocol = "sqs", endpoint = "", raw_message_delivery = true  },
    "lambdafuncname2" = { protocol = "lambda", endpoint = "" }
    }
}

```
