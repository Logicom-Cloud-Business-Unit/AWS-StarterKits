# modules/s3_bucket/main.tf

# S3 Bucket
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  tags   = var.tags
}

# S3 Bucket Website Configuration
resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


# S3 Bucket Policy to Allow CloudFront Access
resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.this.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = "*",
        Action = "s3:GetObject",
        Resource = "arn:aws:s3:::${aws_s3_bucket.this.id}/*"
      }
    ]
  })
}

# Origin Access Identity for CloudFront
resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "Origin Access Identity for S3 bucket"
}

# Upload index.html to S3
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.this.id
  key    = "static/index.html"
  source = "${path.module}/index.html"  # Assuming index.html is in the same directory as this .tf file
  acl    = "private"                    # Set to private for secure access through CloudFront only

  content_type = "text/html"
}

# Upload image.jpg to S3
resource "aws_s3_object" "image_jpg" {
  bucket = aws_s3_bucket.this.id
  key    = "static/image.jpg"
  source = "${path.module}/image.jpg"   # Assuming image.jpg is in the same directory as this .tf file
  acl    = "private"                    # Set to private for secure access through CloudFront only

  content_type = "image/jpeg"
}
