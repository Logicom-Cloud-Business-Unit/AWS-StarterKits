# modules/cloudfront/variables.tf

variable "alb_dns_name" {
  description = "The DNS name of the ALB to route traffic to"
  type        = string
}

variable "default_ttl" {
  description = "Default TTL for cached objects"
  type        = number
  default     = 3600  # 1 hour
}

variable "max_ttl" {
  description = "Maximum TTL for cached objects"
  type        = number
  default     = 86400  # 1 day
}

variable "tags" {
  description = "A map of tags to assign to CloudFront distribution"
  type        = map(string)
  default     = {}
}

variable "s3_bucket_website_domain" {
  description = "S3 bucket website endpoint, used for CloudFront origin"
  type        = string
}

variable "s3_origin_access_identity" {
  description = "CloudFront origin access identity for S3"
  type        = string
}
