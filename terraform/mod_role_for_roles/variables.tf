variable "root_account_id" {
  type = "string"
}

variable "target_account_id" {
  type = "string"
}

variable "organization_role_name" {
  type = "string"
}

variable "template" {}

variable "group_name" {}

variable "role_name" {}

variable "allow_roles" {
  type = "list"
}

variable "allow_roles_arn" {
  type    = "list"
  default = []
}

variable "run_as" {}

provider "aws" {
  alias = "module_local"

  assume_role {
    session_name = "module_local"
    role_arn     = "${var.run_as}"
  }
}

data "aws_caller_identity" "module_local" {
  provider = "aws.module_local"
}
