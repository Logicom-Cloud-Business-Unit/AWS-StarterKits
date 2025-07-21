
variable "infra_env" {
  type        = string
  description = "infrastructure environment"
}

variable "project_name" {
  type = string
}

variable "name" {
  type = string
  
}
variable "cidr" {
  type        = string
  description = "The CIDR block for the VPC"
}
variable "azs" {
  type        = list(string)
  description = "a list contain the avilable AZs inside the region we apply in it"
}
variable "database_subnets" {
  type        = list(string)
  description = "list of database private subnets in the vpc"
}
variable "private_subnets" {
  type        = list(string)
  description = "list of  private subnets in the vpc"
}
variable "public_subnets" {
  type        = list(string)
  description = "list of public subnets in the vpc"
}

variable "retention_in_days" {
  default = 14
}


variable "public_dedicated_network_acl" {
    default = true
}
variable "public_inbound_acl_rules" {
  default = [
  {
    "cidr_block": "0.0.0.0/0",
    "from_port": 0,
    "protocol": "-1",
    "rule_action": "allow",
    "rule_number": 100,
    "to_port": 0
  }
]
}
variable "public_outbound_acl_rules" {
  default = [
  {
    "cidr_block": "0.0.0.0/0",
    "from_port": 0,
    "protocol": "-1",
    "rule_action": "allow",
    "rule_number": 100,
    "to_port": 0
  }
]
}


variable "private_dedicated_network_acl" {
  default = true
}
variable "private_inbound_acl_rules" {
  default = [
  {
    "cidr_block": "0.0.0.0/0",
    "from_port": 0,
    "protocol": "-1",
    "rule_action": "allow",
    "rule_number": 100,
    "to_port": 0
  }
]
}
variable "private_outbound_acl_rules" {
  default = [
  {
    "cidr_block": "0.0.0.0/0",
    "from_port": 0,
    "protocol": "-1",
    "rule_action": "allow",
    "rule_number": 100,
    "to_port": 0
  }
]
}

variable "database_dedicated_network_acl" {
  default = true
}
variable "database_inbound_acl_rules" {
  default = [
  {
    "cidr_block": "0.0.0.0/0",
    "from_port": 0,
    "protocol": "-1",
    "rule_action": "allow",
    "rule_number": 100,
    "to_port": 0
  }
]
}
variable "database_outbound_acl_rules" {
  default = [
  {
    "cidr_block": "0.0.0.0/0",
    "from_port": 0,
    "protocol": "-1",
    "rule_action": "allow",
    "rule_number": 100,
    "to_port": 0
  }
]
}