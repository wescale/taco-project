# -----------------------------------------------------------------------------
# Group that allow users to assume roles named like "${group_name}-*" in
# specified accounts
# -----------------------------------------------------------------------------
module "builders_base_group" {
  source = "../mod_group_allowing_assume_role"

  group_name = "builders"

  allow_assume_prefixed_roles_in_accounts = [
    "${var.account_id_list["root"]}",
  ]

  members = "${var.memberlist_builders_base}"
}

# -----------------------------------------------------------------------------
# Role assumable by users, linked to root account
# -----------------------------------------------------------------------------
module "root_builders_base_role" {
  source = "../mod_role_for_users"

  group_name = "builders"
  role_name  = "base"

  root_account_id   = "${var.account_id_list["root"]}"
  target_account_id = "${var.account_id_list["dev"]}"

  template    = "${file("${path.module}/policies/builders_base.json")}"
  allow_users = "${var.memberlist_builders_base}"

  allow_assume_prefixed_roles_in_accounts = [
    "${var.account_id_list["dev"]}",
    "${var.account_id_list["rec"]}",
  ]

  run_as              = "arn:aws:iam::${var.account_id_list["root"]}:role/keepers-base"
  tfstate_bucket_name = "${var.tfstate_bucket_name}"
  tfstate_kms_key_arn = "${var.tfstate_kms_key_arn}"
}

# -----------------------------------------------------------------------------
# Role assumable by specified role, linked to target account
# account_id_list["root"] is used to mix with allow_roles names to generate assumed role
# ARNs.
# -----------------------------------------------------------------------------

module "dev_builders_base_role" {
  source = "../mod_role_for_roles"

  group_name = "builders"
  role_name  = "base"

  root_account_id = "${var.account_id_list["root"]}"

  template = "${file("${path.module}/policies/builders_sub.json")}"

  allow_roles = [
    "${module.root_builders_base_role.role_name}",
  ]

  target_account_id = "${var.account_id_list["dev"]}"

  run_as                 = "arn:aws:iam::${var.account_id_list["dev"]}:role/keepers-base"
  organization_role_name = "${var.organization_role_name}"
}

module "rec_builders_base_role" {
  source = "../mod_role_for_roles"

  group_name = "builders"
  role_name  = "base"

  root_account_id = "${var.account_id_list["root"]}"
  template        = "${file("${path.module}/policies/builders_sub.json")}"

  allow_roles = [
    "${module.root_builders_base_role.role_name}",
  ]

  target_account_id = "${var.account_id_list["rec"]}"

  run_as                 = "arn:aws:iam::${var.account_id_list["rec"]}:role/keepers-base"
  organization_role_name = "${var.organization_role_name}"
}
