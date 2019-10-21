data "aws_ami" "mediawiki" {
  most_recent = true
  owners      = ["${data.aws_caller_identity.current.account_id}"]

  filter {
    name   = "name"
    values = ["mediawiki-*"]
  }
}

resource "tls_private_key" "key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.key_name}"
  public_key = "${tls_private_key.key_pair.public_key_openssh}"
}

resource "local_file" "private_key" {
  content  = "${tls_private_key.key_pair.private_key_pem}"
  filename = "cert.pem"
}

data "template_file" "mediawiki" {
  template = "${file("${path.module}/userdata.tpl")}"
    vars {
    DNS_NAME    = "${var.dns_name}"
    DB_ENGINE   = "${var.engine}"
    DB_SERVER   = "${module.mediawiki_rds.address}"
    DB_NAME     = "${var.db_name}"
    DB_USER     = "${var.username}"
    DB_PASSWORD = "${var.password}"
  }
}

module "mediawiki_app" {
  source                      = "git@github.com:JUSTPERFECT/aws-terraform-modules.git//asg?ref=v0.1.4"
  lc_name                     = "${var.lc_name}"
  image_id                    = "${data.aws_ami.mediawiki.image_id}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  vpc_security_group_ids      = ["${aws_security_group.instance_sg.id}"]
  asg_name                    = "${var.asg_name}"
  subnet_ids                  = ["${module.private_subnets.private_subnet_ids}"]
  health_check_grace_period   = "${var.health_check_grace_period}"
  health_check_type           = "${var.health_check_type}"
  min_elb_capacity            = "${var.min_elb_capacity}"
  wait_for_elb_capacity       = "${var.wait_for_elb_capacity}"
  default_cooldown            = "${var.default_cooldown}"
  force_delete                = "${var.force_delete}"
  load_balancers              = ["${module.elb.classic_elb_name}"]

  cluster_properties {
    ec2_instance_type    = "${var.ec2_instance_type}"
    iam_instance_profile = "${aws_iam_instance_profile.mediawiki_profile.name}"
    ec2_key_name         = "${aws_key_pair.generated_key.key_name}"
    ec2_custom_userdata  = "${data.template_file.mediawiki.rendered}"
    ec2_asg_min          = "${var.ec2_asg_min}"
    ec2_asg_max          = "${var.ec2_asg_max}"
    ec2_asg_desired      = "${var.ec2_asg_desired}"
  }
}

module "elb" {
  source                    = "git@github.com:JUSTPERFECT/aws-terraform-modules.git//elb?ref=v0.1.4"
  elb_name                  = "mediawiki"
  elb_internal              = "${var.elb_internal}"
  connection_draining       = "${var.connection_draining}"
  cross_zone_load_balancing = "${var.cross_zone_load_balancing}"
  subnet_ids                = ["${module.public_subnets.public_subnet_ids}"]
  security_groups           = ["${aws_security_group.elb_sg.id}"]
  listener                  = "${var.listener}"
  health_check              = "${var.health_check}"
}
