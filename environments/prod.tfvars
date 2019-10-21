### VPC variables

vpc_name = "mediawiki-prod-prod"

vpc_cidr_block = "10.90.0.0/16"

enable_dns_support = "true"

enable_dns_hostnames = "true"

vpc_flowlog_role = "Flow-Logs-Role"

vpc_flow_loggroup_name = "mediawiki-prod"

### private subnet variables
# number of subnets depends on number of CIDR's

private_subnet_cidr_blocks = ["10.90.0.0/24", "10.90.1.0/24"]

private_availability_zones = ["ap-southeast-2a", "ap-southeast-2b"]

private_subnet_name = "mediawiki-prod-private"

### public subnet variables

public_subnet_cidr_blocks = ["10.90.2.0/24", "10.90.3.0/24"]

public_availability_zones = ["ap-southeast-2a", "ap-southeast-2b"]

public_subnet_name = "mediawiki-prod-public"

### Internet Gateway variables

igw_name = "mediawiki-prod-igw"

### NAT gateway variables

nat_gateway_name = "mediawiki-prod-nat"

eip_name = "mediawiki-prod-eip"

### Private route table variables

private_routetable_name = "mediawiki-prod-private-routetable"

private_destination_cidr_block = "0.0.0.0/0"

### Flag to add ngw to route table
nat_enabled = true

### Public route table variables

public_routetable_name = "mediawiki-prod-public-routetable"

public_destination_cidr_block = "0.0.0.0/0"

### Flag to add igw to route table
igw_enabled = true

### private NACL variables

private_nacl_name = "mediawiki-prod-private-nacl"

private_network_acl_rules = [
  {
    rule_number = "100"
    egress      = false
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 443
    to_port     = 443
  },
  {
    rule_number = "200"
    egress      = false
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 1024
    to_port     = 65535
  },
  {
    rule_number = "300"
    egress      = false
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 80
    to_port     = 80
  },
  {
    rule_number = "400"
    egress      = false
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "10.80.0.0/16"
    from_port   = 22
    to_port     = 22
  },
  {
    rule_number = "100"
    egress      = true
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 443
    to_port     = 443
  },
  {
    rule_number = "200"
    egress      = true
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 1024
    to_port     = 65535
  },
  {
    rule_number = "300"
    egress      = true
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 80
    to_port     = 80
  },
]

### public NACL variables

public_nacl_name = "mediawiki-prod-public-nacl"

public_network_acl_rules = [
  {
    rule_number = "100"
    egress      = false
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 443
    to_port     = 443
  },
  {
    rule_number = "200"
    egress      = false
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 22
    to_port     = 22
  },
  {
    rule_number = "300"
    egress      = false
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 1024
    to_port     = 65535
  },
  {
    rule_number = "400"
    egress      = false
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 80
    to_port     = 80
  },
  {
    rule_number = "100"
    egress      = true
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 443
    to_port     = 443
  },
  {
    rule_number = "200"
    egress      = true
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "10.90.0.0/16"
    from_port   = 22
    to_port     = 22
  },
  {
    rule_number = "300"
    egress      = true
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 1024
    to_port     = 65535
  },
  {
    rule_number = "400"
    egress      = true
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 80
    to_port     = 80
  },
]

### RDS variables

db_subnet_group_name = "mediawiki-prod"

rds_identifier = "mediawiki-prod"

username = "wiki"
