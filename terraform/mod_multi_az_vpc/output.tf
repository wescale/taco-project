output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "vpc_cidr" {
  value = "${var.vpc_cidr}"
}

# -----------------------------------------------------------------------------

output "public_subnet_id_a" {
  value = "${module.subnets_az_a.public_subnet_id}"
}

output "public_subnet_cidr_a" {
  value = "${module.subnets_az_a.public_subnet_cidr}"
}

output "private_subnet_id_a" {
  value = "${module.subnets_az_a.private_subnet_id}"
}

output "private_subnet_route_table_id_a" {
  value = "${module.subnets_az_a.private_subnet_route_table_id}"
}

output "private_subnet_cidr_a" {
  value = "${module.subnets_az_a.private_subnet_cidr}"
}

# -----------------------------------------------------------------------------

output "public_subnet_id_b" {
  value = "${module.subnets_az_b.public_subnet_id}"
}

output "public_subnet_cidr_b" {
  value = "${module.subnets_az_b.public_subnet_cidr}"
}

output "private_subnet_id_b" {
  value = "${module.subnets_az_b.private_subnet_id}"
}

output "private_subnet_route_table_id_b" {
  value = "${module.subnets_az_b.private_subnet_route_table_id}"
}

output "private_subnet_cidr_b" {
  value = "${module.subnets_az_b.private_subnet_cidr}"
}

# ------------------------------------------------------------------------------

output "public_subnet_id_c" {
  value = "${module.subnets_az_c.public_subnet_id}"
}

output "public_subnet_cidr_c" {
  value = "${module.subnets_az_c.public_subnet_cidr}"
}

output "private_subnet_id_c" {
  value = "${module.subnets_az_c.private_subnet_id}"
}

output "private_subnet_route_table_id_c" {
  value = "${module.subnets_az_c.private_subnet_route_table_id}"
}

output "private_subnet_cidr_c" {
  value = "${module.subnets_az_c.private_subnet_cidr}"
}

# ------------------------------------------------------------------------------
output "main_route_table_id" {
  value = "${aws_route_table.main.id}"
}
