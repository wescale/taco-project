variable "vpc_id" {}

variable "public_subnet_cidr" {}

variable "private_subnet_cidr" {}

variable "availability_zone" {}

variable "environment" {}
variable "owner" {}
variable "stack" {}
variable "cost" {}

variable "public_gateway_route_table_id" {}

variable "run_as" {}

provider "aws" {
  alias = "module_local"

  assume_role {
    session_name = "module_local"
    role_arn     = "${var.run_as}"
  }
}
