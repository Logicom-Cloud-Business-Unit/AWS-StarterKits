output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.this.bucket
}

output "bucket_website_domain" {
  description = "The domain name of the S3 bucket website"
  value       = aws_s3_bucket_website_configuration.this.website_endpoint
}

output "origin_access_identity" {
  description = "The CloudFront origin access identity for accessing the bucket"
  value       = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
}

output "origin_access_identity_arn" {
  description = "The ARN of the CloudFront origin access identity"
  value       = aws_cloudfront_origin_access_identity.this.iam_arn
}
