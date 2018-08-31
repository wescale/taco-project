variable "root_account_id" {
  type = "string"
}

variable "target_account_id" {
  type = "string"
}

variable "template" {}

variable "group_name" {}

variable "role_name" {}

variable "allow_users" {
  type    = "list"
  default = []
}

variable "organization_role_name" {
  type    = "string"
  default = ""
}

variable "tfstate_bucket_name" {
  type    = "string"
  default = ""
}

variable "tfstate_kms_key_arn" {
  type    = "string"
  default = ""
}

variable "allow_assume_prefixed_roles_in_accounts" {
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
