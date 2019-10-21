resource "aws_route53_record" "mediawiki" {
  zone_id = "${var.zone_id}"
  name    = "${var.dns_name}"
  type    = "A"
  ttl     = "60"
  records = ["${module.elb.classic_elb_dns_name}"]
}
