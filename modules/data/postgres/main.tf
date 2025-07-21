# Module configuration for RDS with custom parameter group
module "rds" {
  source                               = "terraform-aws-modules/rds/aws"
  version                              = "~> 6.10.0"
  identifier                           = var.identifier
               
  instance_class                       = var.instance_class 
  allocated_storage                    = var.allocated_storage
  max_allocated_storage                = var.max_allocated_storage  
  engine                               = var.engine
  engine_version                       = var.engine_version
  allow_major_version_upgrade          = var.allow_major_version_upgrade
  skip_final_snapshot                  = var.skip_final_snapshot
  publicly_accessible                  = var.publicly_accessible
  availability_zone                    = var.availability_zone
  vpc_security_group_ids               = [aws_security_group.rds_postgres_sg.id]
  db_subnet_group_name                 = var.db_subnet_group_name
  username                             = var.username
  manage_master_user_password          = false
  password                             = random_string.uddin-db-password.result
  create_db_parameter_group            = false                          # Disable parameter group creation in module
  parameter_group_name                 = aws_db_parameter_group.sandbox_pgsql_14.name  # Use custom parameter group
  family                               = var.family
  apply_immediately                    = var.apply_immediately 
  iam_database_authentication_enabled  = var.db_iam_authentication
  copy_tags_to_snapshot                = var.copy_tags_to_snapshot  

  # Automated Backups
  backup_window                        = var.backup_window
  backup_retention_period              = var.backup_retention_period

  cloudwatch_log_group_retention_in_days = var.retention_in_days

  tags = {
    Name                 = "${var.identifier}-${var.infra_env}-Sandbox-rds-postgres"
    Application          = "AWS RDS"
    Application_Role     = "SQL Database"
    Environment          = var.infra_env
    ManagedBy            = "Terraform"   
  }

  depends_on = [aws_db_parameter_group.sandbox_pgsql_14]  # Ensure parameter group exists before RDS
}

# Custom Parameter Group
resource "aws_db_parameter_group" "sandbox_pgsql_14" {
  name        = "sandbox-pgsql-16"
  family      = "postgres16"
  description = "Parameter group for PostgreSQL 16"

  tags = {
    Environment = var.infra_env
  }

  lifecycle {
    prevent_destroy = true  # Prevent accidental deletion
  }
}

# Secrets Manager for storing DB credentials
resource "aws_secretsmanager_secret_version" "set_credentials" {
  secret_id     = var.secret_manager_id
  secret_string = jsonencode({
    DB_PORT     = "${element(split(":", module.rds.db_instance_endpoint),1)}",
    DB_ENGINE   = "postgresql",
    DB_HOST     = "${element(split(":", module.rds.db_instance_endpoint),0)}",
    DB_USERNAME = module.rds.db_instance_username,
    DB_NAME     = var.identifier,
    DB_PASSWORD = random_string.uddin-db-password.result
  })
}

# Random Password Generator
resource "random_string" "uddin-db-password" {
  length           = 32
  upper            = true
  numeric          = true
  special          = true
  override_special = "()-=+[]{}<>?!"
}

# Security Group for RDS Instance
# Dynamic Security Group for RDS Instance
resource "aws_security_group" "rds_postgres_sg" {
  vpc_id      = var.vpc_id
  name        = "Sandbox-rds-postgres-${var.sg_name}-${var.infra_env}"
  description = "Security Group for RDS Postgres allowing specified inbound and outbound access"

  # Dynamic ingress (inbound) rules
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = lookup(ingress.value, "cidr_blocks", null)
      security_groups = lookup(ingress.value, "security_groups", null)
      description = lookup(ingress.value, "description", "Allow inbound traffic")
    }
  }

  # Dynamic egress (outbound) rules
  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = lookup(egress.value, "cidr_blocks", null)
      security_groups = lookup(egress.value, "security_groups", null)
      description = lookup(egress.value, "description", "Allow outbound traffic")
    }
  }

  tags = {
    Name                 = "Sandbox-${var.infra_env}-rds-postgres-${var.sg_name}_security_group"
    Application          = "AWS Security Group"
    Application_Role     = "Security Group (virtual firewall)"
    Environment          = var.infra_env
    ManagedBy            = "Terraform"
  }
}
