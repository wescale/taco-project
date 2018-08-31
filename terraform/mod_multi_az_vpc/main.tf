resource "aws_vpc" "vpc" {
  provider = "aws.module_local"

  cidr_block = "${var.vpc_cidr}"

  enable_dns_hostnames = true

  tags {
    Name        = "vpc-${var.environment}"
    Environment = "${var.environment}"
    Owner       = "${var.owner}"
    Stack       = "${var.stack}"
    Cost        = "${var.cost}"
  }

  lifecycle {
    prevent_destroy = "true"
  }
}

resource "aws_internet_gateway" "gateway" {
  provider = "aws.module_local"

  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name        = "igw-${var.environment}"
    Environment = "${var.environment}"
    Owner       = "${var.owner}"
    Stack       = "${var.stack}"
    Cost        = "${var.cost}"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route_table" "main" {
  provider = "aws.module_local"

  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name        = "vpc-main-routing-${var.environment}"
    Environment = "${var.environment}"
    Owner       = "${var.owner}"
    Stack       = "${var.stack}"
    Cost        = "${var.cost}"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route" "main_to_everything" {
  provider               = "aws.module_local"
  route_table_id         = "${aws_route_table.main.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gateway.id}"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_main_route_table_association" "main" {
  provider = "aws.module_local"

  route_table_id = "${aws_route_table.main.id}"
  vpc_id         = "${aws_vpc.vpc.id}"

  lifecycle {
    prevent_destroy = true
  }
}

module "subnets_az_a" {
  source      = "../mod_az_subnets"
  environment = "${var.environment}"
  owner       = "${var.owner}"
  stack       = "${var.stack}"
  cost        = "${var.cost}"

  availability_zone = "${var.region}a"

  vpc_id = "${aws_vpc.vpc.id}"

  public_subnet_cidr = "${cidrsubnet(var.vpc_cidr, 8, 1)}"

  private_subnet_cidr = "${cidrsubnet(var.vpc_cidr, 6, 4)}"

  public_gateway_route_table_id = "${aws_route_table.main.id}"

  run_as = "${var.run_as}"
}

module "subnets_az_b" {
  source      = "../mod_az_subnets"
  environment = "${var.environment}"
  owner       = "${var.owner}"
  stack       = "${var.stack}"
  cost        = "${var.cost}"

  availability_zone = "${var.region}b"

  vpc_id = "${aws_vpc.vpc.id}"

  public_subnet_cidr = "${cidrsubnet(var.vpc_cidr, 8, 2)}"

  private_subnet_cidr = "${cidrsubnet(var.vpc_cidr, 6, 6)}"

  public_gateway_route_table_id = "${aws_route_table.main.id}"

  run_as = "${var.run_as}"
}

module "subnets_az_c" {
  source      = "../mod_az_subnets"
  environment = "${var.environment}"
  owner       = "${var.owner}"
  stack       = "${var.stack}"
  cost        = "${var.cost}"

  availability_zone = "${var.region}c"

  vpc_id = "${aws_vpc.vpc.id}"

  public_subnet_cidr = "${cidrsubnet(var.vpc_cidr, 8, 3)}"

  private_subnet_cidr = "${cidrsubnet(var.vpc_cidr, 6, 8)}"

  public_gateway_route_table_id = "${aws_route_table.main.id}"

  run_as = "${var.run_as}"
}
