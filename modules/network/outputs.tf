

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "the id of the vpc"
}

output "vpc_cidr" {
  value       = module.vpc.vpc_cidr_block
  description = "vpc cidr block"
}

output "public_subnets" {
  value       = module.vpc.public_subnets
  description = "list of vpc public subnets"
}

output "private_subnets" {
  value       = module.vpc.private_subnets
  description = "list of vpc private subnets"
}

output "database_subnets" {
  value       = module.vpc.database_subnets
  description = "list of database private subnets"
}
output "database_subnet_group_name"{
  value = module.vpc.database_subnet_group_name
}


output "private_route_table_ids" {
  value = module.vpc.private_route_table_ids
}

output "private_subnets_cidr_blocks" {
  value = module.vpc.private_subnets_cidr_blocks  
}
output "vpc_database_subnets" {
  value = module.vpc.database_subnets
}

output "default_security_group_id" {
  value = module.vpc.default_security_group_id
}