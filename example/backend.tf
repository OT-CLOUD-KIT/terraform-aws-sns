terraform {
  backend "s3" {
    bucket = "ot-cloud-kit-bucket-2"
    key    = "ot/module/SNS/terraform.tfstate"
    region = "us-east-1"

  }
}