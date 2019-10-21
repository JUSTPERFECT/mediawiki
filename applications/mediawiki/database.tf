resource "aws_db_subnet_group" "mediawiki" {
  name       = "${var.db_subnet_group_name}"
  subnet_ids = ["${module.private_subnets.private_subnet_ids}"]
}

module "mediawiki_rds" {
  source               = "git@github.com:JUSTPERFECT/aws-terraform-modules.git//rds?ref=v0.1.3"
  identifier           = "${var.rds_identifier}"
  security_group       = "${aws_security_group.rds_sg.id}"
  db_subnet_group_name = "${aws_db_subnet_group.mediawiki.id}"
  username             = "${var.username}"
  password             = "${var.password}"
  skip_final_snapshot  = true
}
