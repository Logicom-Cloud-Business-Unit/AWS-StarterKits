variable "name" {
  description = "The name of the ALB"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID to associate with the ALB"
  type        = string
}

variable "subnets" {
  description = "A list of subnet IDs to associate with the ALB"
  type        = list(string)
}

variable "enable_deletion_protection" {
  description = "Whether to enable deletion protection on the ALB"
  type        = bool
  default     = false
}

variable "idle_timeout" {
  description = "The idle timeout for the ALB"
  type        = number
  default     = 60
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

variable "target_ids" {
  description = "A list of instance IDs to register with the ALB target group"
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "redirect_to_https" {
  description = "If true, redirect HTTP requests to HTTPS"
  type        = bool
  default     = false
}


variable "certificate_arn" {
  description = "The ARN of the SSL certificate for HTTPS listeners"
  type        = string
}


