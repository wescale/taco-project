# -----------------------------------------------------------------------------

provider "aws" {
  alias = "sec"

  assume_role {
    session_name = "keepers-base"
    role_arn     = "arn:aws:iam::${var.account_id_list["sec"]}:role/keepers-base"
  }
}

# -----------------------------------------------------------------------------

variable "organization_role_name" {
  type = "string"
}

variable "account_id_list" {
  type = "map"
}

variable "deploy_region" {
  type = "string"
}

variable "memberlist_settlers_base" {
  type    = "list"
  default = []
}

variable "tfstate_bucket_name" {
  type = "string"
}

variable "tfstate_kms_key_arn" {
  type = "string"
}
