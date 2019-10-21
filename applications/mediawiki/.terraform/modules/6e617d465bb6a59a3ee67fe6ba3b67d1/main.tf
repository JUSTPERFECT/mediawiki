resource "aws_subnet" "subnet" {
  count                   = "${length(var.subnet_cidr_blocks)}"
  cidr_block              = "${element(var.subnet_cidr_blocks, count.index)}"
  vpc_id                  = "${var.vpc_id}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"

  tags = {
      Name="${var.subnet_name}${count.index + 1}"
  }
}
