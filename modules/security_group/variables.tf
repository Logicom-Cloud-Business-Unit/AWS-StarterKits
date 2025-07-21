# modules/security_group/variables.tf

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}

variable "alb_security_group_id" {
  description = "The security group ID of the ALB to allow traffic from"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the security group"
  type        = map(string)
  default     = {}
}

variable "allow_ssh" {
  description = "Whether to allow SSH ingress from a specific CIDR block"
  type        = bool
  default     = false
}

variable "ssh_cidr_block" {
  description = "CIDR block for SSH access (e.g., office IP or any IP)"
  type        = string
  default     = "0.0.0.0/0"  # Set a more specific IP or network range if needed
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
