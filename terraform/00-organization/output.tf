output "accounts_id" {
  value = {
    root = "${data.aws_caller_identity.current.account_id}"
    sec  = "${module.sec_account.id}"
    dev  = "${module.dev_account.id}"
    rec  = "${module.rec_account.id}"
    pre  = "${module.pre_account.id}"
    prd  = "${module.prd_account.id}"
  }
}

output "accounts_id_for_terrabot" {
  value = <<EOF
account_id_list:
  root: "${data.aws_caller_identity.current.account_id}"
  sec: "${module.sec_account.id}"
  dev: "${module.dev_account.id}"
  rec: "${module.rec_account.id}"
  pre: "${module.pre_account.id}"
  prd: "${module.prd_account.id}"

organization_role_name: "${var.organization_role_name}"
EOF
}
