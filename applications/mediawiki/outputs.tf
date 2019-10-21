output "mediawiki_elb_url" {
  value = "${format("http://%s/mediawiki", module.elb.classic_elb_dns_name)}"
}
