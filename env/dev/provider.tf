#Configuring the AWS Provider
terraform {
required_providers {
  aws = {
    source      = "hashicorp/aws"
    version = ">=6.0.0"
    
  }
}
#   backend "s3" {
#   bucket  = "S3 Bucket name"                                          # Make sure to add the created bucket in your AWS account
#   key     = "Infra/dev/terraform.tfstate"
#   region  = "eu-central-1"
#   dynamodb_table = "terraform-lock-table"                                  # Make sure to add the created Dyanmo DB in your AWS account
#   }
}

provider "aws" {
region  = "eu-central-1"
 default_tags {
   tags = {
    tag="default_tag"
   }
 }
}