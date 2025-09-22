# Terraform AWS SNS Topic Module

This module provides a reusable and configurable way to create and manage AWS SNS (Simple Notification Service) topics using Terraform. It supports both Standard and FIFO topics, KMS encryption, subscription management across various protocols (like Email, Lambda, SQS), and optional feedback roles for detailed delivery metrics.

---

## Features

-  Standard and FIFO Topic Support
-  KMS Encryption (optional)
-  Configurable delivery & access policies
-  Multiple subscription protocols (email, SQS, Lambda, etc.)
-  Feedback roles for metrics/logs
-  Custom tagging support

---

## Providers

| Name                                              | Version  |
|---------------------------------------------------|----------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.82.2   |
| <a name="terraform_module"></a> [Terraform](Terraform\module) | >= 1.12.1|

___

##  Architecture


![SNS](https://github.com/user-attachments/assets/88c53563-5503-41d4-81aa-b6e9d21a4d94)# Terraform AWS SNS Topic Module

---

##  Usage

```hcl
module "sns_topic" {
  source = "./modules/terraform-aws-sns-topic" # Or your Git source

  sns_topic_name                        = "dev-alerts-topic"
  sns_display_name                      = "DevAlerts"
  fifo_enabled                          = false
  content_based_deduplication_enabled  = false

  encryption_enabled                    = true
  sns_kms_master_key_id                 = "arn:aws:kms:us-east-1:123456789012:key/example-key"

  sns_delivery_policy = {
    http = {
      defaultHealthyRetryPolicy = {
        minDelayTarget     = 20
        maxDelayTarget     = 20
        numRetries         = 3
        backoffFunction    = "linear"
      }
      disableSubscriptionOverrides = false
      defaultRequestPolicy = {
        headerContentType = "text/plain; charset=UTF-8"
      }
    }
  }

  sns_access_policy = {
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = "*"
      Action    = "SNS:Publish"
      Resource  = "*"
    }]
  }

 

  http_feedback_enabled        = true
  lambda_feedback_enabled      = true
  application_feedback_enabled = false
  sqs_feedback_enabled         = false

  http_success_feedback_sample_rate        = 100
  lambda_success_feedback_sample_rate      = 0
  application_success_feedback_sample_rate = 0
  sqs_success_feedback_sample_rate         = 0

  iam_assume_role = {
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "sns.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  }

  iam_sns_policy = {
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "cloudwatch:PutMetricData",
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Resource = "*"
    }]
  }

  snssuccessfeedbackpolicy = "sns-success-feedback"
  snsfailedfeedbackpolicy  = "sns-failed-feedback"

  sns_subscription_setting = {
    "email-sub" = {
      protocol = "email"
      endpoint = "alerts@example.com"
    }
  }

  endpoint_auto_confirms           = true
  confirmation_timeout_in_minutes  = 1
  filter_policy                    = null
  delivery_policy                  = null
}

```

## Resources

| Name                                                                                                                                                         | Type     |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------- |
| [aws\_sns\_topic.sns\_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic)                                          | resource |
| [aws\_iam\_role.iam\_success\_feedback\_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                          | resource |
| [aws\_iam\_role.iam\_failed\_feedback\_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                           | resource |
| [aws\_iam\_role\_policy.iam\_success\_feedback\_role\_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy)   | resource |
| [aws\_iam\_role\_policy.iam\_failed\_feedback\_role\_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy)    | resource |
| [aws\_sns\_topic\_subscription.sns\_topic\_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |

___

## Input

| Name                                                                                                                                                        | Description                        | Type          | Default | Required |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------- | ------------- | ------- | :------: |
| <a name="input_sns_topic_name"></a> [`sns_topic_name`](#input_sns_topic_name)                                                                               | Name of the SNS topic              | `string`      | n/a     |     Yes   |
| <a name="input_sns_display_name"></a> [`sns_display_name`](#input_sns_display_name)                                                                         | Display name for console           | `string`      | n/a     |     Yes   |
| <a name="input_fifo_enabled"></a> [`fifo_enabled`](#input_fifo_enabled)                                                                                     | Whether this is a FIFO topic       | `bool`        | `false` |     No    |
| <a name="input_content_based_deduplication_enabled"></a> [`content_based_deduplication_enabled`](#input_content_based_deduplication_enabled)                | Enable FIFO deduplication          | `bool`        | `false` |     No    |
| <a name="input_encryption_enabled"></a> [`encryption_enabled`](#input_encryption_enabled)                                                                   | Whether to enable KMS encryption   | `bool`        | `false` |     No    |
| <a name="input_sns_kms_master_key_id"></a> [`sns_kms_master_key_id`](#input_sns_kms_master_key_id)                                                          | ARN of KMS key for encryption      | `string`      | `null`  |     No    |
| <a name="input_sns_delivery_policy"></a> [`sns_delivery_policy`](#input_sns_delivery_policy)                                                                | JSON delivery policy map           | `any`         | `{}`    |     Yes   |
| <a name="input_sns_access_policy"></a> [`sns_access_policy`](#input_sns_access_policy)                                                                      | JSON access policy map             | `any`         | `{}`    |     Yes   |
| <a name="input_sns_topic_tags"></a> [`sns_topic_tags`](#input_sns_topic_tags)                                                                               | Tags for the topic                 | `map(string)` | `{}`    |     No    |
| <a name="input_http_feedback_enabled"></a> [`http_feedback_enabled`](#input_http_feedback_enabled)                                                          | Enable HTTP feedback roles         | `bool`        | `false` |     No    |
| <a name="input_lambda_feedback_enabled"></a> [`lambda_feedback_enabled`](#input_lambda_feedback_enabled)                                                    | Enable Lambda feedback roles       | `bool`        | `false` |     No    |
| <a name="input_application_feedback_enabled"></a> [`application_feedback_enabled`](#input_application_feedback_enabled)                                     | Enable App feedback roles          | `bool`        | `false` |     No    |
| <a name="input_sqs_feedback_enabled"></a> [`sqs_feedback_enabled`](#input_sqs_feedback_enabled)                                                             | Enable SQS feedback roles          | `bool`        | `false` |     No    |
| <a name="input_http_success_feedback_sample_rate"></a> [`http_success_feedback_sample_rate`](#input_http_success_feedback_sample_rate)                      | HTTP feedback rate                 | `number`      | `0`     |     No    |
| <a name="input_lambda_success_feedback_sample_rate"></a> [`lambda_success_feedback_sample_rate`](#input_lambda_success_feedback_sample_rate)                | Lambda feedback rate               | `number`      | `0`     |     No    |
| <a name="input_application_success_feedback_sample_rate"></a> [`application_success_feedback_sample_rate`](#input_application_success_feedback_sample_rate) | App feedback rate                  | `number`      | `0`     |     No    |
| <a name="input_sqs_success_feedback_sample_rate"></a> [`sqs_success_feedback_sample_rate`](#input_sqs_success_feedback_sample_rate)                         | SQS feedback rate                  | `number`      | `0`     |     No    |
| <a name="input_iam_assume_role"></a> [`iam_assume_role`](#input_iam_assume_role)                                                                            | IAM assume role JSON for SNS       | `any`         | n/a     |     Yes   |
| <a name="input_iam_sns_policy"></a> [`iam_sns_policy`](#input_iam_sns_policy)                                                                               | IAM permissions for feedback roles | `any`         | n/a     |     Yes   |
| <a name="input_snssuccessfeedbackpolicy"></a> [`snssuccessfeedbackpolicy`](#input_snssuccessfeedbackpolicy)                                                 | Name of success policy             | `string`      | n/a     |     Yes   |
| <a name="input_snsfailedfeedbackpolicy"></a> [`snsfailedfeedbackpolicy`](#input_snsfailedfeedbackpolicy)                                                    | Name of failure policy             | `string`      | n/a     |     Yes   |
| <a name="input_sns_subscription_setting"></a> [`sns_subscription_setting`](#input_sns_subscription_setting)                                                 | Map of subscription configs        | `map(object)` | `{}`    |     No    |
| <a name="input_endpoint_auto_confirms"></a> [`endpoint_auto_confirms`](#input_endpoint_auto_confirms)                                                       | Whether to auto-confirm            | `bool`        | `true`  |     No    |
| <a name="input_confirmation_timeout_in_minutes"></a> [`confirmation_timeout_in_minutes`](#input_confirmation_timeout_in_minutes)                            | Timeout for confirm                | `number`      | `1`     |     No    |
| <a name="input_filter_policy"></a> [`filter_policy`](#input_filter_policy)                                                                                  | Filter policy for subscriptions    | `any`         | `null`  |     No    |
| <a name="input_delivery_policy"></a> [`delivery_policy`](#input_delivery_policy)                                                                            | Custom delivery policy override    | `any`         | `null`  |     No    |


___ 

## Output

| Name                                                                                     | Description               |
| ---------------------------------------------------------------------------------------- | ------------------------- |
| <a name="output_sns_topic_arn"></a> [`sns_topic_arn`](#output_sns_topic_arn)             | ARN of the SNS topic      |
| <a name="output_sns_topic_name"></a> [`sns_topic_name`](#output_sns_topic_name)          | Name of the SNS topic     |
| <a name="output_sns_subscriptions"></a> [`sns_subscriptions`](#output_sns_subscriptions) | List of subscription ARNs |


___


## Contributors

- [Piyush Upadhyay](https://github.com/piiiyuushh)
- [Nikita Joshi](https://github.com/jnikita19)


