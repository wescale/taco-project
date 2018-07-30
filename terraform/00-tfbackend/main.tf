provider "aws" {
  alias = "sec"

  assume_role {
    session_name = "${var.organization_role_name}"
    role_arn     = "arn:aws:iam::${var.account_id_list.sec}:role/LumoAdmin"
  }
}

module "tfbackend" {
  providers = {
    aws = "aws.sec"
  }

  source               = "../mod_tfbackend_master"
  deploy_region        = "eu-west-3"
  bucket_tfstates_name = "${var.basename}-tfstates"

  administrators = [
    "arn:aws:iam::${var.account_id_list.sec}:role/${var.organization_role_name}"
  ]

  users = [
    "arn:aws:iam::${var.root_account_id}:role/LumoAdmin",
    "arn:aws:iam::${var.root_account_id}:role/keepers-base",
  ]

  tags {
    Owner = "${var.basename}"
  }
}
