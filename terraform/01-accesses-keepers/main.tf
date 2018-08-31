# -----------------------------------------------------------------------------
# Group that allow users to assume roles named like "${group_name}-*" in
# specified accounts
# -----------------------------------------------------------------------------
module "keepers_base_group" {
  source = "../mod_group_allowing_assume_role"

  group_name = "keepers"

  allow_assume_prefixed_roles_in_accounts = [
    "${values(var.account_id_list)}",
  ]

  members = "${var.memberlist_keepers_base}"
}

# -----------------------------------------------------------------------------
# Role assumable by users, linked to root account
# -----------------------------------------------------------------------------
module "root_keepers_base_role" {
  source = "../mod_role_for_users"

  group_name = "keepers"
  role_name  = "base"

  root_account_id   = "${var.account_id_list["root"]}"
  target_account_id = "${var.account_id_list["root"]}"

  template    = "${file("${path.module}/policies/keepers_base.json")}"
  allow_users = "${var.memberlist_keepers_base}"

  organization_role_name = "${var.organization_role_name}"

  tfstate_bucket_name = "${var.tfstate_bucket_name}"

  tfstate_kms_key_arn = "${var.tfstate_kms_key_arn}"

  allow_assume_prefixed_roles_in_accounts = [
    "${values(var.account_id_list)}",
  ]

  run_as = "arn:aws:iam::${var.account_id_list["root"]}:role/${var.run_as}"
}

# -----------------------------------------------------------------------------
# Role assumable by specified role, linked to target account
# root_account_id is used to mix with allow_roles names to generate assumed role
# ARNs.
# -----------------------------------------------------------------------------
module "sec_keepers_base_role" {
  source = "../mod_role_for_roles"

  group_name = "keepers"
  role_name  = "base"

  root_account_id   = "${var.account_id_list["root"]}"
  target_account_id = "${var.account_id_list["sec"]}"

  template = "${file("${path.module}/policies/keepers_sub.json")}"

  organization_role_name = "${var.organization_role_name}"

  allow_roles = [
    "${module.root_keepers_base_role.role_name}",
  ]

  run_as = "arn:aws:iam::${var.account_id_list["sec"]}:role/${var.run_as}"
}

# -----------------------------------------------------------------------------
# Role assumable by specified role, linked to target account
# root_account_id is used to mix with allow_roles names to generate assumed role
# ARNs.
# -----------------------------------------------------------------------------
module "dev_keepers_base_role" {
  source = "../mod_role_for_roles"

  group_name = "keepers"
  role_name  = "base"

  root_account_id = "${var.account_id_list["root"]}"

  template = "${file("${path.module}/policies/keepers_sub.json")}"

  organization_role_name = "${var.organization_role_name}"

  allow_roles = [
    "${module.root_keepers_base_role.role_name}",
  ]

  target_account_id = "${var.account_id_list["dev"]}"
  run_as            = "arn:aws:iam::${var.account_id_list["dev"]}:role/${var.run_as}"
}

module "rec_keepers_base_role" {
  source = "../mod_role_for_roles"

  group_name = "keepers"
  role_name  = "base"

  root_account_id = "${var.account_id_list["root"]}"

  template = "${file("${path.module}/policies/keepers_sub.json")}"

  organization_role_name = "${var.organization_role_name}"

  allow_roles = [
    "${module.root_keepers_base_role.role_name}",
  ]

  target_account_id = "${var.account_id_list["rec"]}"
  run_as            = "arn:aws:iam::${var.account_id_list["rec"]}:role/${var.run_as}"
}

module "pil_keepers_base_role" {
  source = "../mod_role_for_roles"

  group_name = "keepers"
  role_name  = "base"

  root_account_id = "${var.account_id_list["root"]}"

  template = "${file("${path.module}/policies/keepers_sub.json")}"

  organization_role_name = "${var.organization_role_name}"

  allow_roles = [
    "${module.root_keepers_base_role.role_name}",
  ]

  target_account_id = "${var.account_id_list["pil"]}"
  run_as            = "arn:aws:iam::${var.account_id_list["pil"]}:role/${var.run_as}"
}

module "prod_keepers_base_role" {
  source = "../mod_role_for_roles"

  group_name = "keepers"
  role_name  = "base"

  root_account_id = "${var.account_id_list["root"]}"

  template = "${file("${path.module}/policies/keepers_sub.json")}"

  organization_role_name = "${var.organization_role_name}"

  allow_roles = [
    "${module.root_keepers_base_role.role_name}",
  ]

  target_account_id = "${var.account_id_list["prd"]}"
  run_as            = "arn:aws:iam::${var.account_id_list["prd"]}:role/${var.run_as}"
}
