variable "region" {
  description = "name of region"
  default     = "ap-southeast-2"
}

### VPC variables
variable "vpc_name" {
  description = "Name of VPC to create"
}

variable "vpc_cidr_block" {
  description = "CIDR to be assigned to VPC"
}

variable "enable_dns_support" {
  description = "Flag to enable DNS support for VPC"
}

variable "enable_dns_hostnames" {
  description = "Flag to enable DNS hostname support for VPC"
}

variable "vpc_flowlog_role" {
  description = "name of VPC flow log role"
}

variable "vpc_flow_loggroup_name" {
  description = "loggroup name for vpc flowlog"
}

### private subnet variables
variable "private_subnet_cidr_blocks" {
  description = "list of CIDR block for the private subnets"
  type        = "list"
}

variable "private_availability_zones" {
  description = "list of az to deploy private subnets"
  type        = "list"
}

variable "private_subnet_name" {
  description = "Name of the public Subnet"
}

### public subnet variables
variable "public_subnet_cidr_blocks" {
  description = "list of CIDR block for the public subnets"
  type        = "list"
}

variable "public_availability_zones" {
  description = "list of az to deploy public subnets"
  type        = "list"
}

variable "public_subnet_name" {
  description = "Name of the public Subnet"
}

### Internet Gateway variables

variable "igw_name" {
  description = "Name of the internet gateway"
}

### NAT gateway variables
variable "nat_gateway_name" {
  description = "Name of the NAT gateway"
}

variable "eip_name" {
  description = "Name of the eip attached to NAT gateway"
}

### Private route table variables
variable "private_destination_cidr_block" {
  description = "cidr block range of route to create"
}

variable "private_routetable_name" {
  description = "Name of the route table"
}

### Flag to add ngw to route table
variable "nat_enabled" {
  description = "NAT enablement for private route"
}

### Public route table variables
variable "public_destination_cidr_block" {
  description = "cidr block range of route to create"
}

variable "public_routetable_name" {
  description = "Name of the route table"
}

### Flag to add igw to route table
variable "igw_enabled" {
  description = "IGW enablement for public route"
}

### private NACL variables
variable "private_network_acl_rules" {
  description = "rules for private network acl"
  type        = "list"
  default     = []
}

variable "private_nacl_name" {
  description = "network private acl name"
}

### public NACL variables
variable "public_network_acl_rules" {
  description = "rules for public network acl"
  type        = "list"
  default     = []
}

variable "public_nacl_name" {
  description = "network public acl name"
}

### RDS variables
variable "db_subnet_group_name" {
  description = "db subnet group to create"
}

variable "rds_identifier" {
  description = "name of rds instance"
}

variable "db_name" {
  description = "name of database to create"
}

variable "username" {
  description = "admin username for rds user"
  default = "wiki"
}

variable "password" {
  description = "admin password for rds user"
  default = "changeme"
}

variable "engine" {
  description = "database engine"
  default = "mysql"
}

### ASG variables

variable "lc_name" {
  description = "name of launch configuration"
  default     = "mediawiki"
}

variable "associate_public_ip_address" {
  description = "Launching instances with public IP"
  default     = false
}

variable "asg_name" {
  description = "name of autoscaling group"
  default     = "mediawiki"
}

variable "health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health"
  default     = 300
}

variable "health_check_type" {
  description = "Controls how health checking is done. Values are - EC2 and ELB"
  default     = "EC2"
}

variable "min_elb_capacity" {
  description = "Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes"
  default     = 1
}

variable "wait_for_elb_capacity" {
  description = "Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over min_elb_capacity behavior."
  default     = false
}

variable "default_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  default     = 300
}

variable "force_delete" {
  description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling"
  default     = false
}

variable "ec2_instance_type" {
  description = "Instance type to be used for asg"
  default     = "t2.micro"
}

variable "key_name" {
  default = "mediawiki"
}

variable "ec2_asg_min" {
  description = "Autoscaling group minimum instance count"
  default     = "1"
}

variable "ec2_asg_max" {
  description = "Autoscaling group maximum instance count"
  default     = "1"
}

variable "ec2_asg_desired" {
  description = "Autoscaling group desired instance count"
  default     = "1"
}

### ELB variables
variable "create_elb" {
  description = "if true, ELB will be created"
  default     = true
}

variable "elb_name" {
  description = "classic load balancer name to be created"
  default     = ""
}

variable "elb_internal" {
  description = "Flag to define whether ELB is internal or external"
  default     = false
}

variable "cross_zone_load_balancing" {
  description = "Flag to enable cross zone load balancing"
  default     = true
}

variable "connection_draining" {
  description = "Flag for connection draining"
  default = false
}

variable "idle_timeout" {
  description = "The time given for connection to be idle"
  default     = 300
}

variable "listener" {
  description = "list of elb listeners"
  type        = "list"

  default = [
    {
      instance_port     = 80
      instance_protocol = "http"
      lb_port           = 80
      lb_protocol       = "http"
    },
  ]
}

variable "health_check" {
  description = "list of elb health checks"
  type        = "list"
  default     = [
  {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:80"
    interval            = 30
  },
]
}

### Route53 variables

variable "dns_name" {
  description = "dns record for application"
}
