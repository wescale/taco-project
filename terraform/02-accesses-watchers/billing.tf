module "watchers_billing_group" {
  source = "../mod_group_allowing_assume_role"

  group_name = "watchers-billing"

  allow_assume_prefixed_roles_in_accounts = [
    "${var.account_id_list["root"]}",
    "${var.account_id_list["sec"]}",
    "${var.account_id_list["dev"]}",
    "${var.account_id_list["rec"]}",
    "${var.account_id_list["pil"]}",
    "${var.account_id_list["prd"]}",
  ]

  members = "${var.memberlist_watchers_billing}"
}

# -----------------------------------------------------------------------------
# Role assumable by users, linked to root account
# -----------------------------------------------------------------------------
module "root_watchers_billing_role" {
  source            = "../mod_role_for_users"
  group_name        = "watchers-billing"
  role_name         = "base"
  root_account_id   = "${var.account_id_list["root"]}"
  target_account_id = "${var.account_id_list["root"]}"
  template          = "${file("${path.module}/policies/watchers_billing.json")}"
  allow_users       = "${var.memberlist_watchers_billing}"

  allow_assume_prefixed_roles_in_accounts = [
    "${var.account_id_list["sec"]}",
    "${var.account_id_list["dev"]}",
    "${var.account_id_list["rec"]}",
    "${var.account_id_list["pil"]}",
    "${var.account_id_list["prd"]}",
  ]

  run_as = "arn:aws:iam::${var.account_id_list["root"]}:role/keepers-base"
}

# -----------------------------------------------------------------------------
# Role assumable by specified role, linked to target account
# root_account_id is used to mix with allow_roles names to generate assumed role
# ARNs.
# -----------------------------------------------------------------------------
module "billing_watchers_sec_role" {
  source            = "../mod_role_for_users"
  group_name        = "watchers-billing"
  role_name         = "base"
  root_account_id   = "${var.account_id_list["root"]}"
  target_account_id = "${var.account_id_list["sec"]}"
  template          = "${file("${path.module}/policies/watchers_billing.json")}"
  allow_users       = "${var.memberlist_watchers_billing}"
  run_as            = "arn:aws:iam::${var.account_id_list["sec"]}:role/keepers-base"
}

module "billing_watchers_dev_role" {
  source            = "../mod_role_for_users"
  group_name        = "watchers-billing"
  role_name         = "base"
  root_account_id   = "${var.account_id_list["root"]}"
  target_account_id = "${var.account_id_list["dev"]}"
  template          = "${file("${path.module}/policies/watchers_billing.json")}"
  allow_users       = "${var.memberlist_watchers_billing}"
  run_as            = "arn:aws:iam::${var.account_id_list["dev"]}:role/keepers-base"
}

module "billing_watchers_uat_role" {
  source            = "../mod_role_for_users"
  group_name        = "watchers-billing"
  role_name         = "base"
  root_account_id   = "${var.account_id_list["root"]}"
  target_account_id = "${var.account_id_list["rec"]}"
  template          = "${file("${path.module}/policies/watchers_billing.json")}"
  allow_users       = "${var.memberlist_watchers_billing}"
  run_as            = "arn:aws:iam::${var.account_id_list["rec"]}:role/keepers-base"
}

module "billing_watchers_pre_role" {
  source            = "../mod_role_for_users"
  group_name        = "watchers-billing"
  role_name         = "base"
  root_account_id   = "${var.account_id_list["root"]}"
  target_account_id = "${var.account_id_list["pil"]}"
  template          = "${file("${path.module}/policies/watchers_billing.json")}"
  allow_users       = "${var.memberlist_watchers_billing}"
  run_as            = "arn:aws:iam::${var.account_id_list["pil"]}:role/keepers-base"
}

module "billing_watchers_prod_role" {
  source            = "../mod_role_for_users"
  group_name        = "watchers-billing"
  role_name         = "base"
  root_account_id   = "${var.account_id_list["root"]}"
  target_account_id = "${var.account_id_list["prd"]}"
  template          = "${file("${path.module}/policies/watchers_billing.json")}"
  allow_users       = "${var.memberlist_watchers_billing}"
  run_as            = "arn:aws:iam::${var.account_id_list["prd"]}:role/keepers-base"
}
