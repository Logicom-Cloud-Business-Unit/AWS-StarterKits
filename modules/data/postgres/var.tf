variable "infra_env" {}
variable "vpc_id" {}
variable "username" {type = string}
variable "sg_name" {}
variable "engine" {default = "postgres"}
variable "engine_version" {default = "16.3"}
variable "allow_major_version_upgrade" {
    default = false
}
variable "instance_class" {default = "db.t3.micro"}
variable "allocated_storage" {default = "5"}
variable "max_allocated_storage" {default = "20"}
variable "publicly_accessible" {default = false}
variable "db_subnet_group_name" {}
variable  "availability_zone" {}
variable "identifier" {}
#variable "vpc_security_group_ids" {}
variable "db_iam_authentication" {default = false}
variable "apply_immediately" { default = false}
variable "copy_tags_to_snapshot"  {default = true}
variable "retention_in_days" {
    default = 14
}
# variable "create_cloudwatch_log_group"       {default=true}
# variable "enabled_cloudwatch_logs_exports"   {default="postgresql"} 
################################
##      Automated Backup      ##
################################
variable "skip_final_snapshot" {default = true}
variable  "backup_window" {default = "03:00-06:00"}
variable  "backup_retention_period" {default = 0}
variable "create_db_parameter_group" {default = false}
variable "parameter_group_name" {}
variable "family" {}
variable "secret_manager_id" {}
variable "CIDRS" {}

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
      from_port   = 5432
      to_port     = 5432
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
