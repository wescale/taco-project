provider "aws" {
  alias = "root"
}

provider "aws" {
  alias = "sec"

  assume_role {
    session_name = "${var.organization_role_name}"
    role_arn     = "arn:aws:iam::${var.account_id_list["sec"]}:role/${var.organization_role_name}"
  }
}

module "tfbackend" {
  providers = {
    aws.bucket = "aws.sec"
    aws.dynamo = "aws.root"
  }

  source               = "../mod_tfbackend_master"
  deploy_region        = "${var.main_region}"
  bucket_tfstates_name = "${var.basename}-tfstates"

  administrators = [
    "arn:aws:iam::${var.account_id_list["sec"]}:role/${var.organization_role_name}",
  ]

  users = [
    "arn:aws:iam::${var.account_id_list["root"]}:user/${var.first_admin_name}",
  ]

  tags {
    Owner = "${var.basename}"
  }
}
