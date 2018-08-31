output "public_subnet_id" {
  value = "${aws_subnet.public_subnet.id}"
}

output "public_subnet_cidr" {
  value = "${aws_subnet.public_subnet.cidr_block}"
}

output "private_subnet_id" {
  value = "${aws_subnet.private_subnet.id}"
}

output "private_subnet_cidr" {
  value = "${aws_subnet.private_subnet.cidr_block}"
}

output "private_subnet_route_table_id" {
  value = "${aws_route_table.private_subnet_route.id}"
}
