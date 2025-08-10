#############################################
# ----            VPC Module           ---- #
#############################################

module "vpc" {
  source              = "../../modules/network"
  name                = "${var.project_name}-VPC"
  cidr                = var.cidr
  azs                 = var.azs
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  database_subnets    = var.database_subnets
  infra_env           = var.infra_env
  project_name        = var.project_name
  retention_in_days   = var.retention_in_days
}

#############################################
# ----       Security Group Module      ----#
#############################################

module "security_group" {
  source                = "../../modules/security_group"
  security_group_name   = var.security_group_name
  vpc_id                = module.vpc.vpc_id
  alb_security_group_id = module.alb.alb_security_group_id
  allow_http            = var.allow_http
  allow_https           = var.allow_https
  allow_ssh             = var.allow_ssh
  ssh_cidr_block        = var.ssh_cidr_block
  tags                  = var.security_group_tags
}


#############################################
# ----         EC2 Instance Modules      ---#
#############################################

module "ec2" {
  source                  = "../../modules/ec2"
  # vpc_id                  = module.vpc.vpc_id
  vpc_security_group_ids  = [module.security_group.security_group_id]
  subnet_id               = module.vpc.public_subnets[1]
  instance_name           = var.instance_names[0]
  instance_type           = var.instance_type
  key_name                = var.key_name
  ami                     = var.ami
  associate_public_ip_address = var.associate_public_ip_address
  tags                    = var.tags
  user_data               = var.user_data
}

module "ec2_1" {
  source                  = "../../modules/ec2"
  # vpc_id                  = module.vpc.vpc_id
  vpc_security_group_ids  = [module.security_group.security_group_id]
  subnet_id               = module.vpc.public_subnets[0]
  instance_name           = var.instance_names[1]
  instance_type           = var.instance_type
  key_name                = var.key_name
  ami                     = var.ami
  associate_public_ip_address = var.associate_public_ip_address
  tags                    = var.tags
  user_data               = var.user_data
}


module "ec2_3" {
  source                  = "../../modules/ec2"
  # vpc_id                  = module.vpc.vpc_id
  vpc_security_group_ids  = [module.security_group.security_group_id]
  subnet_id               = module.vpc.public_subnets[2]
  instance_name           = var.instance_names[2]
  instance_type           = var.instance_type
  key_name                = var.key_name
  ami                     = var.ami
  associate_public_ip_address = var.associate_public_ip_address
  tags                    = var.tags
  user_data               = var.user_data
}

#############################################
# ----      Application LoadBalancer     ---#
#############################################

module "alb" {
  source                    = "../../modules/alb"
  name                      = var.alb_name
  vpc_id                    = module.vpc.vpc_id
  subnets                   = module.vpc.public_subnets
  enable_deletion_protection = false
  idle_timeout              = 60

  target_group_name_prefix  = var.target_group_name_prefix
  target_group_port         = var.target_group_port
  target_group_protocol     = var.target_group_protocol
  target_type               = var.target_type

  health_check_path         = var.health_check_path
  health_check_interval     = var.health_check_interval
  health_check_timeout      = var.health_check_timeout
  healthy_threshold         = var.healthy_threshold
  unhealthy_threshold       = var.unhealthy_threshold

  target_ids                = [
    module.ec2_1.instance_id,
    module.ec2.instance_id,
    module.ec2_3.instance_id
  ]
  certificate_arn           = var.certificate_arn
  redirect_to_https         = var.redirect_to_https

  tags = var.tags
}


#############################################
# ----         CloudFront Module         ---#
#############################################

module "cloudfront" {
  source                    = "../../modules/cloudfront"
  alb_dns_name              = module.alb.dns_name
  s3_bucket_website_domain  = module.s3_bucket.bucket_website_domain
  s3_origin_access_identity = module.s3_bucket.origin_access_identity
  default_ttl               = var.default_ttl
  max_ttl                   = var.max_ttl

  tags = var.tags
}

output "cloudfront_endpoint" {
  description = "The endpoint URL for the CloudFront distribution"
  value       = "https://${module.cloudfront.cloudfront_domain_name}"
}

#############################################
# ----           S3 Bucket Module        ---#
#############################################

module "s3_bucket" {
  source                    = "../../modules/s3"
  bucket_name               = var.bucket_name
  index_document            = var.index_document
  error_document            = var.error_document
  block_public_acls         = var.block_public_acls
  block_public_policy       = var.block_public_policy
  ignore_public_acls        = var.ignore_public_acls
  restrict_public_buckets   = var.restrict_public_buckets
  index_html_source         = var.index_html_source
  image_jpg_source          = var.image_jpg_source

  tags = {
    Environment = var.infra_env
    Project     = var.project_name
  }
}

#############################################
# ----             RDS Module            ---#
#############################################

module "rds" {
  source                    = "../../modules/data/postgres"
  vpc_id                    = module.vpc.vpc_id
  username                  = var.rds_username
  infra_env                 = var.infra_env
  family                    = var.family
  parameter_group_name      = var.parameter_group_name
  availability_zone         = var.availability_zone
  db_subnet_group_name      = module.vpc.database_subnet_group_name
  secret_manager_id         = module.microservice_secret_manager_dev.secret_manager_id
  CIDRS                     = var.rds_cidrs
  identifier                = var.rds_identifier
  sg_name                   = var.rds_sg_name
  instance_class            = var.rds_instance_class
  ingress_rules             = var.ingress_rules  # Dynamic ingress rules
  egress_rules              = var.egress_rules   # Dynamic egress rules

}

#############################################
# ----      Secrets Manager Module       ---#
#############################################

module "microservice_secret_manager_dev" {
  source       = "../../modules/secret_manager"
  infra_env    = var.infra_env
  secret_name  = var.secret_name
}
