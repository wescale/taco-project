output "id" {
  value = "${aws_organizations_account.subaccount.id}"
}

output "alias" {
  value = "${local.subaccount_name}"
}

output "organization_role_name" {
  value = "${var.organization_role_name}"
}
