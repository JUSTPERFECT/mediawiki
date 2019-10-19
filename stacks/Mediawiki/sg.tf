resource "aws_security_group" "elb_sg" {
  name   = "mediawiki-sg"
  vpc_id = "${var.vpc_id}"
}

resource "aws_security_group_rule" "mediawiki_elb_egress-out-1" {
  security_group_id = "${aws_security_group.elb_sg.id}"
  description       = "ELB out"
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "mediawiki_elb_ingress-in-1" {
  security_group_id = "${aws_security_group.elb_sg.id}"
  description       = "ELB in"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "instance_sg" {
  name   = "MEDIAWIKI-EC2-SG"
  vpc_id = "${var.vpc_id}"
}

resource "aws_security_group_rule" "mediawiki_instance_egress-out-1" {
  security_group_id = "${aws_security_group.instance_sg.id}"
  description       = "EC2 out"
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "mediawiki_instance_ingress-in-1" {
  security_group_id        = "${aws_security_group.instance_sg.id}"
  description              = "EC2 in"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.elb_sg.id}"
}

resource "aws_security_group_rule" "mediawiki_instance_ingress-in-2" {
  security_group_id = "${aws_security_group.instance_sg.id}"
  description       = "EC2 SSH in"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "rds_sg" {
  name   = "mediawiki-sg"
  vpc_id = "${var.vpc_id}"
}

resource "aws_security_group_rule" "mediawiki_rds_egress-out-1" {
  security_group_id        = "${aws_security_group.rds_sg.id}"
  description              = "rds out"
  type                     = "egress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.instance_sg.id}"
}

resource "aws_security_group_rule" "mediawiki_rds_ingress-in-1" {
  security_group_id        = "${aws_security_group.rds_sg.id}"
  description              = "rds in"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.instance_sg.id}"
}
