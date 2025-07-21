
resource "aws_cloudfront_distribution" "this" {
  enabled             = true
  comment             = "CloudFront distribution for ALB and S3"
  default_root_object = "index.html"

  # Origin for ALB (dynamic content)
  origin {
    domain_name = var.alb_dns_name
    origin_id   = "alb-origin"

    custom_origin_config {
      origin_protocol_policy = "http-only"  # ALB supports HTTP for CloudFront
      http_port              = 80
      https_port             = 443
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  # Origin for S3 Bucket (static content)
  origin {
    domain_name = var.s3_bucket_website_domain
    origin_id   = "s3-origin"

    custom_origin_config {  # Use custom_origin_config for website endpoints
    origin_protocol_policy = "http-only"  # S3 website endpoints only support HTTP
    http_port              = 80
    https_port             = 443
    origin_ssl_protocols   = ["TLSv1.2"]
  }

  }

  # Default Cache Behavior for ALB (dynamic content)
  default_cache_behavior {
    target_origin_id       = "alb-origin"
    viewer_protocol_policy = "allow-all"  # Allows both HTTP and HTTPS from clients
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "POST", "PUT", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD"]

    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }

    min_ttl     = 0
    default_ttl = var.default_ttl
    max_ttl     = var.max_ttl
  }

  # Additional Cache Behavior for S3 (static content with /static/* path)
  ordered_cache_behavior {
    path_pattern           = "static/*"
    target_origin_id       = "s3-origin"
    viewer_protocol_policy = "redirect-to-https"  # Redirect HTTP to HTTPS for security on S3
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]

    forwarded_values {
      query_string = false  # Avoid forwarding unnecessary query strings
      cookies {
        forward = "none"  # Do not forward cookies to S3 for static content
      }
    }

    min_ttl     = 0
    default_ttl = var.default_ttl
    max_ttl     = var.max_ttl
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true  # Use the default CloudFront certificate for HTTPS
  }

  tags = var.tags
}
