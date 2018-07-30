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
