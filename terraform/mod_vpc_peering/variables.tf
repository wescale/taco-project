variable deploy_region {
  type = "string"
}

variable "requester_env" {
  type = "string"
}

variable "requester_account_id" {
  type = "string"
}

variable "requester_vpc_id" {
  type = "string"
}

variable "requester_private_route_table_list" {
  type = "list"
}

variable "accepter_private_route_table_list" {
  type = "list"
}

variable "accepter_main_route_table" {
  type = "string"
}

variable "accepter_cidr_block" {
  type = "string"
}

variable "accepter_env" {
  type = "string"
}

variable "accepter_account_id" {
  type = "string"
}

variable "accepter_vpc_id" {}

variable "requester_cidr_block" {}

variable "run_as" {}

provider "aws" {
  alias = "requester"

  assume_role {
    session_name = "requester"
    role_arn     = "arn:aws:iam::${var.requester_account_id}:role/settlers-base"
  }
}

provider "aws" {
  alias = "accepter"

  assume_role {
    session_name = "accepter_${var.accepter_env}"
    role_arn     = "${var.run_as}"
  }
}
