module "vpc" {
  source        = "terraform-aws-modules/vpc/aws"
  version       = "~> 5.14.0"

  name          = var.name
  cidr          = var.cidr

  azs                     = var.azs
  private_subnets         = var.private_subnets
  public_subnets          = var.public_subnets
  database_subnets        = var.database_subnets

  enable_dns_hostnames                = true
  propagate_public_route_tables_vgw   = true
  propagate_private_route_tables_vgw  = true
  default_security_group_egress =[]
  default_security_group_ingress = []

  # configure nat gatway
  enable_nat_gateway            = true
  single_nat_gateway            = true
  one_nat_gateway_per_az        = false
  create_database_subnet_group  = true

  public_dedicated_network_acl   = var.public_dedicated_network_acl 
  public_inbound_acl_rules       = var.public_inbound_acl_rules
  public_outbound_acl_rules      = var.public_outbound_acl_rules

  private_dedicated_network_acl   = var.private_dedicated_network_acl
  private_inbound_acl_rules       = var.private_inbound_acl_rules 
  private_outbound_acl_rules      = var.private_outbound_acl_rules

  database_dedicated_network_acl  = var.database_dedicated_network_acl  
  database_inbound_acl_rules      = var.database_inbound_acl_rules
  database_outbound_acl_rules     = var.database_outbound_acl_rules
  
  tags = {
    Name                 = "${var.project_name}-${var.infra_env}-vpc"
    Application          = "AWS VPC"
    Application_Role     = "virtual network"
    Environment          = var.infra_env
    ManagedBy            = "Terraform"   
    }
  nat_gateway_tags ={
    Name ="${var.project_name}-${var.infra_env} Nat" 
  }
  igw_tags ={
    Name = "${var.project_name}-${var.infra_env} IGW"
  }
  public_subnet_tags = {
    Name = "${var.project_name}-${var.infra_env} public-subnet"
  }
  database_subnet_tags ={
    Name = "${var.project_name}-${var.infra_env} database-subnet"
  }
}
