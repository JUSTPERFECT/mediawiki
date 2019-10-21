module "vpc" {
  source                 = "git@github.com:JUSTPERFECT/aws-terraform-modules.git//vpc?ref=v0.1.4"
  vpc_name               = "${var.vpc_name}"
  vpc_cidr_block         = "${var.vpc_cidr_block}"
  enable_dns_support     = "${var.enable_dns_support}"
  enable_dns_hostnames   = "${var.enable_dns_hostnames}"
  account                = "${data.aws_caller_identity.current.account_id}"
  vpc_flowlog_role       = "${aws_iam_role.vpc_flow_log.arn}"
  vpc_flow_loggroup_name = "${var.vpc_flow_loggroup_name}"
}

module "private_subnets" {
  source                     = "git@github.com:JUSTPERFECT/aws-terraform-modules.git//private-subnet?ref=v0.1.4"
  vpc_id                     = "${module.vpc.vpc_id}"
  private_subnet_cidr_blocks = ["${var.private_subnet_cidr_blocks}"]
  availability_zones         = ["${var.private_availability_zones}"]
  private_subnet_name        = "${var.private_subnet_name}"
}

module "public_subnets" {
  source                    = "git@github.com:JUSTPERFECT/aws-terraform-modules.git//public-subnet?ref=v0.1.4"
  vpc_id                    = "${module.vpc.vpc_id}"
  public_subnet_cidr_blocks = ["${var.public_subnet_cidr_blocks}"]
  availability_zones        = ["${var.public_availability_zones}"]
  public_subnet_name        = "${var.public_subnet_name}"
}

module "internet-gateway" {
  source      = "git@github.com:JUSTPERFECT/aws-terraform-modules.git//igw?ref=v0.1.4"
  vpc_id      = "${module.vpc.vpc_id}"
  igw_name    = "${var.igw_name}"
}

module "nat-gateway" {
  source           = "git@github.com:JUSTPERFECT/aws-terraform-modules.git//nat-gateway?ref=v0.1.4"
  eip_name         = "${var.eip_name}"
  nat_count        = "${length(var.public_subnet_cidr_blocks)}"
  subnet_ids       = "${module.public_subnets.public_subnet_ids}"
  nat_gateway_name = "${var.nat_gateway_name}"
  depends          = "${module.internet-gateway.internet_gateway_id}"
}

module "private-route-table" {
  source                    = "git@github.com:JUSTPERFECT/aws-terraform-modules.git//private-route-table?ref=v0.1.4"
  vpc_id                    = "${module.vpc.vpc_id}"
  private_route_table_count = "${length(var.private_subnet_cidr_blocks)}"
  private_routetable_name   = "${var.private_routetable_name}"
  destination_cidr_block    = "${var.private_destination_cidr_block}"
  nat_enabled               = "${var.nat_enabled}"
  nat_gateway_ids           = ["${module.nat-gateway.nat_gateway_ids}"]
}

module "private-route-table-association" {
  source            = "git@github.com:JUSTPERFECT/aws-terraform-modules.git//route-table-association?ref=v0.1.4"
  association_count = "${length(var.private_subnet_cidr_blocks)}"
  subnet_ids        = ["${module.private_subnets.private_subnet_ids}"]
  route_table_ids   = ["${module.private-route-table.private_route_table_ids}"]
}

module "public-route-table" {
  source                   = "git@github.com:JUSTPERFECT/aws-terraform-modules.git//public-route-table?ref=v0.1.4"
  vpc_id                   = "${module.vpc.vpc_id}"
  public_route_table_count = "${length(var.public_subnet_cidr_blocks)}"
  public_routetable_name   = "${var.public_routetable_name}"
  destination_cidr_block   = "${var.public_destination_cidr_block}"
  igw_enabled              = "${var.igw_enabled}"
  internet_gateway_id      = "${module.internet-gateway.internet_gateway_id}"
}

module "public-route-table-association" {
  source            = "git@github.com:JUSTPERFECT/aws-terraform-modules.git//route-table-association?ref=v0.1.4"
  association_count = "${length(var.public_subnet_cidr_blocks)}"
  subnet_ids        = ["${module.public_subnets.public_subnet_ids}"]
  route_table_ids   = ["${module.public-route-table.public_route_table_ids}"]
}

module "private-nacl" {
  source            = "git@github.com:JUSTPERFECT/aws-terraform-modules.git//nacl?ref=v0.1.4"
  vpc_id            = "${module.vpc.vpc_id}"
  nacl_name         = "${var.private_nacl_name}"
  subnet_ids        = ["${module.private_subnets.private_subnet_ids}"]
  network_acl_rules = "${var.private_network_acl_rules}"
}

module "public-nacl" {
  source            = "git@github.com:JUSTPERFECT/aws-terraform-modules.git//nacl?ref=v0.1.4"
  vpc_id            = "${module.vpc.vpc_id}"
  nacl_name         = "${var.public_nacl_name}"
  subnet_ids        = ["${module.public_subnets.public_subnet_ids}"]
  network_acl_rules = "${var.public_network_acl_rules}"
}
