# Environment Configuration
infra_env                = "Development"                     # Specifies the environment (e.g., Dev, Prod)
default_region           = "eu-central-1"                    # AWS region for deploying resources
project_name             = "Sandbox"                         # Name of the project for tagging and identification

# VPC and Subnet Configuration
cidr                     = "172.30.0.0/16"                                              # CIDR block for the VPC
azs                      = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]          # List of availability zones for high availability
public_subnets           = ["172.30.0.0/20", "172.30.16.0/20", "172.30.32.0/20"]        # CIDRs for public subnets in each AZ
private_subnets          = ["172.30.48.0/20", "172.30.64.0/20", "172.30.80.0/20"]       # CIDRs for private subnets in each AZ
database_subnets         = ["172.30.96.0/20", "172.30.112.0/20", "172.30.128.0/20"]     # CIDRs for database subnets in each AZ
retention_in_days        = 14                                                           # Log retention period in CloudWatch

# Instance Names
instance_names = [
  "custom-name-for-instance-one",                            # Custom name for EC2 instance one
  "custom-name-for-instance-two",                            # Custom name for EC2 instance two
  "custom-name-for-instance-three"                           # Custom name for EC2 instance three
]

# EC2 Configuration
instance_type              = "t2.micro"                      # EC2 instance type (e.g., t2.micro, t3.medium)
key_name                   = ""                              # Name of the SSH key pair to access instances After creating one
ami                        = "ami-08ec94f928cf25a9d"         # AMI ID for EC2 instances
associate_public_ip_address = true                           # Assign a public IP address to instances
user_data = <<-EOF
            #!/bin/bash
            sudo yum update -y
            sudo yum install -y nginx
            sudo systemctl start nginx
            sudo systemctl enable nginx
            EOF                                             
            
# ALB Configuration
alb_name                   = "my-alb"                        # Name of the Application Load Balancer (ALB)
target_group_name_prefix   = "h1"                            # Prefix for the ALB target group
target_group_port          = 80                              # Port on which the target group listens
target_group_protocol      = "HTTP"                          # Protocol for target group communication (HTTP/HTTPS)
target_type                = "instance"                      # Target type for ALB (e.g., instance, IP)
health_check_path          = "/"                             # Health check path for ALB
health_check_interval      = 30                              # Interval for ALB health checks (seconds)
health_check_timeout       = 5                               # Timeout for ALB health checks (seconds)
healthy_threshold          = 3                               # Number of successful checks for healthy status
unhealthy_threshold        = 3                               # Number of failed checks for unhealthy status
redirect_to_https          = false                           # Enable or disable HTTP to HTTPS redirection
certificate_arn            = "arn:aws:acm:region:account-id:certificate/certificate-id"  # ARN of SSL certificate for HTTPS

# CloudFront Configuration
default_ttl                = 3600                            # Default TTL for CloudFront cached objects
max_ttl                    = 86400                           # Maximum TTL for CloudFront cached objects

# S3 Bucket Configuration
bucket_name                = "logicom-cloudfront-s3-origin"  # Unique name of the S3 bucket
index_document             = "index.html"                    # Default index document for S3 website
error_document             = "error.html"                    # Default error document for S3 website
block_public_acls          = false                           # Block public ACLs (true/false)
block_public_policy        = false                           # Block public bucket policy (true/false)
ignore_public_acls         = false                           # Ignore public ACLs (true/false)
restrict_public_buckets    = false                           # Restrict public access to the bucket (true/false)

index_html_source          = "../../modules/s3/index.html"   # Path to index.html file for S3 upload
image_jpg_source           = "../../modules/s3/image.jpg"    # Path to image.jpg file for S3 upload

# RDS Configuration
rds_identifier             = "microservice-one"              # Identifier for the RDS instance
rds_sg_name                = "db-sg"                         # Name of the security group for RDS
rds_instance_class         = "db.t3.micro"                   # Instance type for RDS
rds_username               = "logicom"                       # Master username for RDS
family                     = "postgres16"                    # Parameter group family (e.g., postgres16 for PostgreSQL)
parameter_group_name       = "sandbox-pgsql-16"              # Parameter group name for RDS
availability_zone          = "eu-central-1a"                 # Availability zone for RDS instance
rds_cidrs                  = ["172.30.0.0/16"]               # Allowed CIDR ranges for RDS access

ingress_rules = [
  {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    description = "Allow PostgreSQL access within VPC"
  }
]

egress_rules = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
]

# Secrets Manager
secret_name               = "Database-secrets"               # Name of the Secrets Manager secret

# Tags
tags = {
  Environment = "Development"                               # Environment tag for resources
  Project     = "Example"                                   # Project tag for resources
}

# Security Groups
security_group_name       = "custom-ec2-sg"                 # Name of the custom security group for EC2
allow_http                = true                            # Allow HTTP access (true/false)
allow_https               = true                            # Allow HTTPS access (true/false)
allow_ssh                 = false                           # Allow SSH access (true/false)
ssh_cidr_block            = "0.0.0.0/0"                     # CIDR block allowed for ports (update to specific IP for security)

security_group_tags = {
  Environment = "Development"                               # Environment tag for security group
  Project     = "ExampleProject"                            # Project tag for security group
}
