fifo_enabled                       = false                         
content_based_deduplication_enabled = false                        

sns_topic_name                     = "topic"
sns_display_name                   = "DevAlerts"

encryption_enabled                 = true
sns_kms_master_key_id             = "arn:aws:kms:us-east-1:509633460021:key/119bd441-337d-4dfe-bc7f-ffc228833a83"

sns_delivery_policy = {
  http = {
    defaultHealthyRetryPolicy = {
      minDelayTarget     = 20
      maxDelayTarget     = 20
      numRetries         = 3
      numMaxDelayRetries = 0
      numNoDelayRetries  = 0
      numMinDelayRetries = 0
      backoffFunction    = "linear"
    }
    disableSubscriptionOverrides = false
    defaultRequestPolicy = {
      headerContentType = "text/plain; charset=UTF-8"
    }
  }
}

# Access Policy
sns_access_policy = {
  Version = "2008-10-17"
  Id      = "__default_policy_ID"
  Statement = [
    {
      Sid       = "__default_statement_ID"
      Effect    = "Allow"
      Principal = {
        AWS = "*"
      }
      Action = [
        "SNS:Publish",
        "SNS:RemovePermission",
        "SNS:SetTopicAttributes",
        "SNS:DeleteTopic",
        "SNS:ListSubscriptionsByTopic",
        "SNS:GetTopicAttributes",
        "SNS:AddPermission",
        "SNS:Subscribe"
      ]
      Resource = "arn:aws:sns:us-east-1:509633460021:demo"
      Condition = {
        StringEquals = {
          "AWS:SourceAccount" = "509633460021"
        }
      }
    },
    {
      Sid       = "AWSCloudTrailSNSPolicy20150319Forlogs_trail"
      Effect    = "Allow"
      Principal = {
        Service = "cloudtrail.amazonaws.com"
      }
      Action   = "SNS:Publish"
      Resource = "arn:aws:sns:us-east-1:509633460021:demo"
      Condition = {
        StringEquals = {
          "AWS:SourceArn" = "arn:aws:cloudtrail:us-east-1:509633460021:trail/logs_trail"
        }
      }
    }
  ]
}

# Feedback Configuration
http_feedback_enabled              = true
sqs_feedback_enabled               = false
application_feedback_enabled       = true
lambda_feedback_enabled            = true

http_success_feedback_sample_rate        = 0
sqs_success_feedback_sample_rate         = 100
application_success_feedback_sample_rate = 0
lambda_success_feedback_sample_rate      = 0

# IAM Roles and Policies
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

snsfailedfeedbackpolicy  = "sns-failed-feedback"
snssuccessfeedbackpolicy = "sns-success-feedback"

# Subscriptions (optional — empty now)
sns_subscription_setting = {
  # Example if needed:
  # "sub-sqs" = {
  #   protocol             = "sqs"
  #   endpoint             = "arn:aws:sqs:us-east-1:123456789012:dev-queue"
  #   raw_message_delivery = true
  # }
}

# Other configs
endpoint_auto_confirms           = true
confirmation_timeout_in_minutes = 1
filter_policy                    = null
delivery_policy                  = null

# Tags
sns_topic_tags = {
  Environment = "dev"
  Owner       = "Nikita"
}


random_alphanumeric_len = 4

bu       = "ot"
app      = "bp"
env      = "d"
resource = "SNS"
tenant   = ""

special = false
upper   = false
number  = true

gen_no_of_names = 1

team    = "infra"
program = "ot"

