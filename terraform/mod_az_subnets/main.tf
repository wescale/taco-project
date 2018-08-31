###############################################################################
# PUBLIC SUBNET
###############################################################################
resource "aws_subnet" "public_subnet" {
  provider = "aws.module_local"

  vpc_id = "${var.vpc_id}"

  cidr_block = "${var.public_subnet_cidr}"

  availability_zone = "${var.availability_zone}"

  tags {
    Name        = "public-subnet-${var.environment}-${var.availability_zone}"
    Environment = "${var.environment}"
    Owner       = "settlers"
    Stack       = "network-landscape"
    Cost        = "global"
  }

  lifecycle {
    prevent_destroy = true
  }
}

# -------------------------------------
# Associating public subnet to VPC main route table
# -------------------------------------
resource "aws_route_table_association" "public_subnet_to_gateway" {
  provider = "aws.module_local"

  subnet_id = "${aws_subnet.public_subnet.id}"

  route_table_id = "${var.public_gateway_route_table_id}"

  lifecycle {
    prevent_destroy = true
  }
}

###############################################################################
# PRIVATE SUBNET
###############################################################################
resource "aws_subnet" "private_subnet" {
  provider = "aws.module_local"

  vpc_id = "${var.vpc_id}"

  cidr_block = "${var.private_subnet_cidr}"

  availability_zone = "${var.availability_zone}"

  tags {
    Name        = "private-subnet-${var.environment}-${var.availability_zone}"
    Environment = "${var.environment}"
    Owner       = "settlers"
    Stack       = "network-landscape"
    Cost        = "global"
  }

  lifecycle {
    prevent_destroy = true
  }
}

# -------------------------------------
# Private subnet own route table
# -------------------------------------
resource "aws_route_table" "private_subnet_route" {
  provider = "aws.module_local"

  vpc_id = "${var.vpc_id}"

  tags {
    Name        = "private-subnet-routing-${var.environment}-${var.availability_zone}"
    Environment = "${var.environment}"
    Owner       = "settlers"
    Stack       = "network-landscape"
    Cost        = "global"
  }

  lifecycle {
    prevent_destroy = true
  }
}

# -------------------------------------
# Associating private subnet to its own route table.
# -------------------------------------
resource "aws_route_table_association" "private_subnet_to_nat" {
  provider       = "aws.module_local"
  subnet_id      = "${aws_subnet.private_subnet.id}"
  route_table_id = "${aws_route_table.private_subnet_route.id}"

  lifecycle {
    prevent_destroy = true
  }
}
