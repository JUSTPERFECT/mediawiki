output "subnet_ids" {
  description = "created subnet IDs"
  value       = ["${aws_subnet.subnet.*.id}"]
}

output "subnet_cidr_blocks" {
  description = "created subnets CIDR"
  value       = ["${aws_subnet.subnet.*.cidr_block}"]
}

output "subnet_availability_zones" {
  description = "created subnets availability zones"
  value       = ["${aws_subnet.subnet.*.availability_zone}"]
}
