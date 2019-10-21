resource "aws_security_group" "rds_sg" {
  name   = "mediawiki-rds-sg"
  vpc_id = "${module.vpc.vpc_id}"
}

resource "aws_security_group_rule" "mediawiki_rds_egress" {
  security_group_id        = "${aws_security_group.rds_sg.id}"
  description              = "rds out"
  type                     = "egress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.instance_sg.id}"
}

resource "aws_security_group_rule" "mediawiki_rds_ingress" {
  security_group_id        = "${aws_security_group.rds_sg.id}"
  description              = "rds in"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.instance_sg.id}"
}

resource "aws_security_group" "instance_sg" {
  name   = "mediawiki-instance-sg"
  vpc_id = "${module.vpc.vpc_id}"
}

resource "aws_security_group_rule" "mediawiki_instance_egress" {
  security_group_id = "${aws_security_group.instance_sg.id}"
  description       = "instance out"
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "mediawiki_instance_egress2" {
  security_group_id        = "${aws_security_group.instance_sg.id}"
  description              = "rds out"
  type                     = "egress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.rds_sg.id}"
}

resource "aws_security_group_rule" "mediawiki_instance_ingress" {
  security_group_id        = "${aws_security_group.instance_sg.id}"
  description              = "instance in"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.elb_sg.id}"
}

resource "aws_security_group_rule" "mediawiki_instance_ingress2" {
  security_group_id = "${aws_security_group.instance_sg.id}"
  description       = "instance SSH in"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}


resource "aws_security_group" "elb_sg" {
  name   = "mediawiki-elb-sg"
  vpc_id = "${module.vpc.vpc_id}"
}

resource "aws_security_group_rule" "mediawiki_elb_egress" {
  security_group_id = "${aws_security_group.elb_sg.id}"
  description       = "ELB out"
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "mediawiki_elb_ingress" {
  security_group_id = "${aws_security_group.elb_sg.id}"
  description       = "ELB in"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}