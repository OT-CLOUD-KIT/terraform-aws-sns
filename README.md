AWS SNS Topic & Subscription Terraform module
======================================

Terraform module which creates SNS topic & subscription on AWS.

These types of resources are supported:

[SNS Topic & Subscription](https://aws.amazon.com/sns/)

Terraform versions
------------------

Terraform 0.13

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
  sns_topic_tags = var.sns_topic_tags
}

# Under varaible specify subscription list by specifing type, endpoint & raw_message_delivery depending upon the protocol type

variable "sns_subscription_setting" {
  default     = {
    "name1" = { protocol = "sqs", endpoint = "arn:aws:sqs:ap-south-1:123456789xxx:testsqsarn", raw_message_delivery = true },
    "name2" = { protocol = "http", endpoint = "http://testdomain.net", raw_message_delivery = true },
    "name3" = { protocol = "TYPE", endpoint = "arn:aws:lambda:ap-south-1:123456789xxx:testlambdaarn" }
    }
}

```

Inputs
------
| Name | Description | Type | Default | dependent | Required |
|:------:|:-------------:|:------:|:---------:|:----------:|:-----------:|
| sns_topic_name | name for the SNS topic | `string` | | | yes|
| sns_display_name | Display name for SNS topic|`string`|||yes|
|sns_kms_master_key_id|The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK|`string`||encryption_enabled|No|
|encryption_enabled | To enable encryption for SNS Topic|`boolean`|`"false"`||No|
|http_feedback_enabled|To enable HTTP success/failure feedback for SNS topic|`boolean`|`"false"`||No|
|sqs_feedback_enabled | To enable SQS success/failure feedback for SNS topic|`boolean`|`"false"`||No|
|application_feedback_enabled|To enable application success/failure feedback for SNS topic|`boolean`|`"false"`||No|
|lambda_feedback_enabled|To enable Lambda success/failure feedback for SNS topic |`boolean`|`"false"`||No|
|http_success_feedback_sample_rate| Percentage of success to sample HTTP |`string`|`"false"`|http_feedback_enabled|No|
|sqs_success_feedback_sample_rate| Percentage of success to sample for SQS |`string`|`"false"`|sqs_feedback_enabled|No|
|application_success_feedback_sample_rate|Percentage of success to sample for application|`string`|`"false"`|application_feedback_enabled|No|
|lambda_success_feedback_sample_rate|Percentage of success to sample for Lambda |`string`|`"false"`|lambda_feedback_enabled|No|
|sns_delivery_policy|The SNS delivery policy|`string`|`aws-managed`||No|
|sns_access_policy|The fully-formed AWS policy as JSON|`string`|`aws-managed`||No|
|sns_subscription_setting|To setup SNS subscriptions for specific SNS topic |`JSON`|`"false"`||No|
|filter_policy|JSON String with the filter policy that will be used in the subscription to filter messages seen by the target resource|`string`|||No|
|delivery_policy|JSON String with the delivery policy (retries, backoff, etc.) that will be used in the subscription - this only applies to HTTP/S subscriptions|`string`|||No|
|confirmation_timeout_in_minutes|Integer indicating number of minutes to wait in retying mode for fetching subscription arn before marking it as failure|`number`|`1`||No|
|endpoint_auto_confirms|Boolean indicating whether the end point is capable of auto confirming subscription|`boolean`|`true`||No|
|sns_topic_tags|Additional tags for sns topic|`string`|||No|
|snsfailedfeedbackpolicy| The IAM policy name permitted to receive failed feedback for SNS topic |`string`|`SNSFailedFeedbackPolicy`||No|
|snssuccessfeedbackpolicy|The IAM policy name permitted to receive feedback for SNS topic|`string`|`SNSSuccessFeedbackPolicy`||No|
|iam_assume_role|SNS IAM assume role|`string`|`aws-managed`||No|
|iam_sns_policy|SNS topic IAM policy for cloudwatch logs|`string`|`aws-managed`||No|


protocol required key for subscription setting [ sns_subscription_setting ]
-------------------------------

| Protocol | name [String] | endpoint [ARN] |raw_message_delivery [Boolean]|
|------|---------|---------|-------|
| sqs | yes | yes | yes |
| http | yes | yes | yes |
| https | yes | yes | yes |
| sms | yes | yes | no |
| lambda | yes | yes | no |
| application | yes | yes | no |


Output
------
| Name | Description |
|------|-------------|
| id | SNS topic ID |
| arn | SNS topic ARN |




### Contributors

[![bhupender singh][bhupender_avatar]][bhupender_homepage]<br/>[bhupender singh][bhupender_homepage] 

  [bhupender_homepage]: https://github.com/b44rawat
  [bhupender_avatar]: https://avatars1.githubusercontent.com/u/26429558?s=460&u=26006df9d10be9c1103731c5f89f7d6447fd8887&v=4
