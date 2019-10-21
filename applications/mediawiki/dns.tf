resource "aws_route53_record" "mediawiki" {
  zone_id = "${var.zone_id}"
  name    = "${var.dns_name}"
  type    = "A"

  alias {
    name    = "${module.elb.classic_elb_dns_name}"
    zone_id = "${module.elb.classic_elb_zone_id}"
    evaluate_target_health = false
  }
}
