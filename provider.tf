provider "aws" {
  region = "us-west-2" # Update to your region
}
variable "region" {
  description = "The AWS region to deploy resources"
  default     = "us-west-2"  # Set your default region here
}
variable "account_id" {
  description = "851725642392"
  type        = string
}

locals {
  aws_account_id = data.aws_caller_identity.current.account_id
}
