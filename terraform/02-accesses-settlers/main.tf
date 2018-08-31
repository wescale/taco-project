# -----------------------------------------------------------------------------
# Group that allow users to assume roles named like "${group_name}-*" in
# specified accounts
# -----------------------------------------------------------------------------
module "settlers_base_group" {
  source = "../mod_group_allowing_assume_role"

  group_name = "settlers"

  allow_assume_prefixed_roles_in_accounts = [
    "${values(var.account_id_list)}",
  ]

  members = "${var.memberlist_settlers_base}"
}

# -----------------------------------------------------------------------------
# Role assumable by users, linked to root account
# -----------------------------------------------------------------------------
module "root_settlers_base_role" {
  source = "../mod_role_for_users"

  group_name = "settlers"
  role_name  = "base"

  root_account_id   = "${var.account_id_list["root"]}"
  target_account_id = "${var.account_id_list["root"]}"

  template    = "${file("${path.module}/policies/settlers_base.json")}"
  allow_users = "${var.memberlist_settlers_base}"

  allow_assume_prefixed_roles_in_accounts = [
    "${var.account_id_list["sec"]}",
    "${var.account_id_list["dev"]}",
    "${var.account_id_list["rec"]}",
    "${var.account_id_list["pil"]}",
    "${var.account_id_list["prd"]}",
  ]

  run_as = "arn:aws:iam::${var.account_id_list["root"]}:role/keepers-base"

  tfstate_bucket_name = "${var.tfstate_bucket_name}"
  tfstate_kms_key_arn = "${var.tfstate_kms_key_arn}"
}

# -----------------------------------------------------------------------------
# Role assumable by specified role, linked to target account
# root_account_id is used to mix with allow_roles names to generate assumed role
# ARNs.
# -----------------------------------------------------------------------------
module "sec_settlers_base_role" {
  source = "../mod_role_for_roles"

  group_name = "settlers"
  role_name  = "base"

  root_account_id = "${var.account_id_list["root"]}"

  template = "${file("${path.module}/policies/settlers_sub.json")}"

  allow_roles = [
    "${module.root_settlers_base_role.role_name}",
  ]

  target_account_id      = "${var.account_id_list["sec"]}"
  run_as                 = "arn:aws:iam::${var.account_id_list["sec"]}:role/keepers-base"
  organization_role_name = "${var.organization_role_name}"
}

# -----------------------------------------------------------------------------
# Role assumable by specified role, linked to target account
# root_account_id is used to mix with allow_roles names to generate assumed role
# ARNs.
# -----------------------------------------------------------------------------
module "dev_settlers_base_role" {
  source = "../mod_role_for_roles"

  group_name = "settlers"
  role_name  = "base"

  root_account_id = "${var.account_id_list["root"]}"

  template = "${file("${path.module}/policies/settlers_sub.json")}"

  allow_roles = [
    "${module.root_settlers_base_role.role_name}",
  ]

  target_account_id      = "${var.account_id_list["dev"]}"
  run_as                 = "arn:aws:iam::${var.account_id_list["dev"]}:role/keepers-base"
  organization_role_name = "${var.organization_role_name}"
}

module "rec_settlers_base_role" {
  source = "../mod_role_for_roles"

  group_name = "settlers"
  role_name  = "base"

  root_account_id = "${var.account_id_list["root"]}"

  template = "${file("${path.module}/policies/settlers_sub.json")}"

  allow_roles = [
    "${module.root_settlers_base_role.role_name}",
  ]

  target_account_id      = "${var.account_id_list["rec"]}"
  run_as                 = "arn:aws:iam::${var.account_id_list["rec"]}:role/keepers-base"
  organization_role_name = "${var.organization_role_name}"
}

module "pil_settlers_base_role" {
  source = "../mod_role_for_roles"

  group_name = "settlers"
  role_name  = "base"

  root_account_id = "${var.account_id_list["root"]}"

  template = "${file("${path.module}/policies/settlers_sub.json")}"

  allow_roles = [
    "${module.root_settlers_base_role.role_name}",
  ]

  target_account_id      = "${var.account_id_list["pil"]}"
  run_as                 = "arn:aws:iam::${var.account_id_list["pil"]}:role/keepers-base"
  organization_role_name = "${var.organization_role_name}"
}

module "prd_settlers_base_role" {
  source = "../mod_role_for_roles"

  group_name = "settlers"
  role_name  = "base"

  root_account_id = "${var.account_id_list["root"]}"

  template = "${file("${path.module}/policies/settlers_sub.json")}"

  allow_roles = [
    "${module.root_settlers_base_role.role_name}",
  ]

  target_account_id      = "${var.account_id_list["prd"]}"
  run_as                 = "arn:aws:iam::${var.account_id_list["prd"]}:role/keepers-base"
  organization_role_name = "${var.organization_role_name}"
}
