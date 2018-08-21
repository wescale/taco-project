provider "aws" {}

locals {
  rootaccount_name = "${var.basename}-root"
  split_email      = "${split("@",var.root_email)}"
}

resource "aws_iam_account_alias" "root_alias" {
  account_alias = "${local.rootaccount_name}"
}

module "sec_account" {
  source = "../mod_aliased_subaccount"

  basename   = "${var.basename}"
  subname    = "sec"
  root_email = "${local.split_email[0]}+aws-sec@${local.split_email[1]}"

  organization_role_name = "${var.organization_role_name}"
}

module "dev_account" {
  source = "../mod_aliased_subaccount"

  basename   = "${var.basename}"
  subname    = "dev"
  root_email = "${local.split_email[0]}+aws-dev@${local.split_email[1]}"

  organization_role_name = "${var.organization_role_name}"
  create_after           = "${module.sec_account.id}"
}

module "rec_account" {
  source = "../mod_aliased_subaccount"

  basename   = "${var.basename}"
  subname    = "rec"
  root_email = "${local.split_email[0]}+aws-rec@${local.split_email[1]}"

  organization_role_name = "${var.organization_role_name}"
  create_after           = "${module.dev_account.id}"
}

module "pre_account" {
  source = "../mod_aliased_subaccount"

  basename   = "${var.basename}"
  subname    = "pre"
  root_email = "${local.split_email[0]}+aws-pre@${local.split_email[1]}"

  organization_role_name = "${var.organization_role_name}"
  create_after           = "${module.rec_account.id}"
}

module "prd_account" {
  source = "../mod_aliased_subaccount"

  basename   = "${var.basename}"
  subname    = "prd"
  root_email = "${local.split_email[0]}+aws-prd@${local.split_email[1]}"

  organization_role_name = "${var.organization_role_name}"
  create_after           = "${module.prd_account.id}"
}

data "aws_caller_identity" "current" {}
