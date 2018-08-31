locals {
  clean_assumed_role_list = "${formatlist("\"arn:aws:sts::%s:assumed-role/%s/%s\"", var.root_account_id, var.allow_roles, var.allow_roles)}"
  clean_arn_list          = "${formatlist("\"%s\"", var.allow_roles_arn)}"
}

locals {
  full_allowed_arn_list = "${concat(local.clean_arn_list,local.clean_assumed_role_list)}"
}

resource "aws_iam_role" "managed_role" {
  provider = "aws.module_local"

  name = "${var.group_name}-${var.role_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": [
          ${join(",", local.full_allowed_arn_list)}
        ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "template_file" "managed_policy" {
  template = "${var.template}"

  vars {
    group_name = "${var.group_name}"

    root_account_id        = "${var.root_account_id}"
    target_account_id      = "${var.target_account_id}"
    organization_role_name = "${var.organization_role_name}"
  }
}

resource "aws_iam_role_policy" "managed_role_policy_association" {
  provider = "aws.module_local"

  name   = "${var.group_name}-${var.role_name}-policy"
  role   = "${aws_iam_role.managed_role.id}"
  policy = "${data.template_file.managed_policy.rendered}"
}
