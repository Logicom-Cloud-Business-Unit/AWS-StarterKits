variable "instance_name" {
  description = "Custom name for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "ami" {
  description = "AMI ID to use for the EC2 instance"
  type        = string
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address"
  type        = bool
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs to associate with the EC2 instance"
  type        = list(string)
}

variable "subnet_id" {
  description = "Subnet ID to launch the EC2 instance in"
  type        = string
}

variable "monitoring" {
  description = "Enable detailed monitoring"
  type        = bool
  default     = true
}

variable "user_data" {
  description = "User data script for the instance initialization"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the EC2 instance"
  type        = map(string)
}
