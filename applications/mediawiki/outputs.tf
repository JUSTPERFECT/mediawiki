output "mediawiki_elb_url" {
  value = "${format("http://%s/mediawiki", var.dns_name)}"
}
