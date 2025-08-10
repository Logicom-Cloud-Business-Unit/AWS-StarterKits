# Environment Variables
variable "infra_env" {
  type        = string
  description = "Infrastructure environment (e.g., Development, Production)"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
}

variable "default_region" {
  type        = string
  description = "AWS region to deploy resources"
}

# VPC and Subnet Configuration
variable "cidr" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "azs" {
  type        = list(string)
  description = "List of Availability Zones"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnet CIDRs"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of private subnet CIDRs"
}

variable "database_subnets" {
  type        = list(string)
  description = "List of database subnet CIDRs"
}

variable "retention_in_days" {
  type        = number
  description = "Log retention period in days"
}

# Instance Configuration
variable "instance_names" {
  type        = list(string)
  description = "List of instance names for EC2 instances"
}

variable "instance_type" {
  description = "Instance type for all EC2 instances"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH access to all EC2 instances"
  type        = string
}

variable "ami" {
  description = "AMI ID to use for all EC2 instances"
  type        = string
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address for all instances"
  type        = bool
}

variable "user_data" {
  description = "User data script for initializing the EC2 instance"
  type        = string
}

# ALB Configuration
variable "alb_name" {
  description = "The name of the ALB"
  type        = string
}

variable "target_group_name_prefix" {
  description = "The prefix for the target group name"
  type        = string
}

variable "target_group_port" {
  description = "The port for the target group"
  type        = number
  default     = 80
}

variable "target_group_protocol" {
  description = "The protocol for the target group (e.g., HTTP, HTTPS)"
  type        = string
  default     = "HTTP"
}

variable "target_type" {
  description = "The type of target (instance, ip, or lambda)"
  type        = string
  default     = "instance"
}

variable "health_check_path" {
  description = "The path for health checking"
  type        = string
  default     = "/"
}

variable "health_check_interval" {
  description = "The interval for health checking"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "The timeout for health checking"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "The threshold for healthy health checks"
  type        = number
  default     = 3
}

variable "unhealthy_threshold" {
  description = "The threshold for unhealthy health checks"
  type        = number
  default     = 3
}

variable "redirect_to_https" {
  description = "Enable HTTP to HTTPS redirection on the ALB"
  type        = bool
  default     = false
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate for HTTPS listener (required if redirect_to_https is true)"
  type        = string
  default     = ""  # Set the actual certificate ARN in terraform.tfvars
}


# CloudFront Configuration
variable "default_ttl" {
  type        = number
  description = "Default TTL for CloudFront cache behavior"
}

variable "max_ttl" {
  type        = number
  description = "Maximum TTL for CloudFront cache behavior"
}

# S3 Bucket Configuration
# S3 variables
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "index_document" {
  description = "Name of the index document for the S3 website configuration"
  type        = string
}

variable "error_document" {
  description = "Name of the error document for the S3 website configuration"
  type        = string
}

variable "block_public_acls" {
  description = "Block public ACLs on the bucket"
  type        = bool
}

variable "block_public_policy" {
  description = "Block public bucket policies"
  type        = bool
}

variable "ignore_public_acls" {
  description = "Ignore public ACLs on the bucket"
  type        = bool
}

variable "restrict_public_buckets" {
  description = "Restrict public bucket policies"
  type        = bool
}

variable "index_html_source" {
  description = "Path to the local index.html file to upload to S3"
  type        = string
}

variable "image_jpg_source" {
  description = "Path to the local image.jpg file to upload to S3"
  type        = string
}


# RDS Configuration
variable "rds_identifier" {
  type        = string
  description = "Identifier for the RDS instance"
}

variable "rds_sg_name" {
  type        = string
  description = "Name of the RDS security group"
}

variable "rds_instance_class" {
  type        = string
  description = "Instance class for the RDS instance"
}

variable "rds_username" {
  type        = string
  description = "Master username for the RDS instance"
}

variable "family" {
  type        = string
  description = "Parameter group family for RDS"
}

variable "parameter_group_name" {
  type        = string
  description = "Name of the RDS parameter group"
}

variable "availability_zone" {
  type        = string
  description = "Availability Zone for the RDS instance"
}

variable "rds_cidrs" {
  type        = list(string)
  description = "List of CIDRs allowed to access RDS"
}
variable "ingress_rules" {
  description = "List of ingress rules for the RDS security group"
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string))
    security_groups = optional(list(string))
    description     = optional(string)
  }))
  default = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow PostgreSQL traffic"
    }
  ]
}

variable "egress_rules" {
  description = "List of egress rules for the RDS security group"
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string))
    security_groups = optional(list(string))
    description     = optional(string)
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }
  ]
}


# Secrets Manager Configuration
variable "secret_name" {
  type        = string
  description = "Name of the Secrets Manager secret"
}

# Tags
variable "tags" {
  type        = map(string)
  description = "Tags for resources"
}

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "ec2-sg"
}

variable "allow_http" {
  description = "Whether to allow HTTP ingress from the ALB security group"
  type        = bool
  default     = true
}

variable "allow_https" {
  description = "Whether to allow HTTPS ingress from the ALB security group"
  type        = bool
  default     = true
}

variable "security_group_tags" {
  description = "A map of tags to assign to the security group"
  type        = map(string)
  default     = {
    Environment = "dev"
    Project     = "Example"
  }
}

variable "allow_ssh" {
  description = "Whether to allow SSH ingress"
  type        = bool
  default     = false
}

variable "ssh_cidr_block" {
  description = "CIDR block to allow SSH access from"
  type        = string
  default     = "0.0.0.0/0"
}
