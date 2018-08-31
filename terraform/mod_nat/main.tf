# -----------------------------------------------------------------------------
# NAT in AZ A
# -----------------------------------------------------------------------------

# provides details for NAT created to a specific Route (in route table).
resource "aws_route" "private_a_to_nat_a" {
  route_table_id         = "${var.route_table_id_a}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat_b.id}"
}

# -----------------------------------------------------------------------------
# NAT in AZ B
# -----------------------------------------------------------------------------

resource "aws_eip" "nat_b" {}

resource "aws_nat_gateway" "nat_b" {
  allocation_id = "${aws_eip.nat_b.id}"
  subnet_id     = "${var.subnet_id_b}"

  tags {
    Name = "NAT Gateway for ${var.deploy_env} in AZ b"
  }
}

resource "aws_route" "private_b_to_nat_b" {
  route_table_id         = "${var.route_table_id_b}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat_b.id}"
}

resource "aws_route" "private_c_to_nat_b" {
  route_table_id         = "${var.route_table_id_c}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat_b.id}"
}
