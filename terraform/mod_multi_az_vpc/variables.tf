variable "vpc_cidr" {}

variable "region" {}

variable "az_list" {
  type    = "list"
  default = []
}

variable "environment" {}
variable "owner" {}
variable "stack" {}
variable "cost" {}

variable "run_as" {}

provider "aws" {
  alias = "module_local"

  assume_role {
    session_name = "module_local"
    role_arn     = "${var.run_as}"
  }
}
