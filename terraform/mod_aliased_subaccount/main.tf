locals {
  subaccount_name = "${var.basename}-${var.subname}"
}

resource "aws_organizations_account" "subaccount" {
  name                       = "${local.subaccount_name}"
  email                      = "${var.root_email}"
  iam_user_access_to_billing = "${var.allow_access_to_billing ? "ALLOW" : "DENY"}"
  role_name                  = "${var.organization_role_name}"
}

provider "aws" {
  alias = "subaccount"

  assume_role {
    session_name = "${var.organization_role_name}"
    role_arn     = "arn:aws:iam::${aws_organizations_account.subaccount.id}:role/${var.organization_role_name}"
  }
}

resource "aws_iam_account_alias" "subaccount_alias" {
  provider = "aws.subaccount"

  account_alias = "${local.subaccount_name}"
}

resource "null_resource" "order" {
  triggers {
    order = "${var.create_after}"
  }
}
