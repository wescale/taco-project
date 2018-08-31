locals {
  clean_users_arn_list = "${formatlist("\"arn:aws:iam::%s:user/%s\"", var.root_account_id, var.allow_users)}"
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
          ${join(",", local.clean_users_arn_list)}
        ]
      },
      "Effect": "Allow",
      "Sid": "",
      "Condition": {
        "Bool": {
          "aws:MultiFactorAuthPresent": "true"
        }
      }
    }
  ]
}
EOF
}

data "template_file" "managed_policy" {
  template = "${var.template}"

  vars {
    root_account_id   = "${var.root_account_id}"
    target_account_id = "${var.target_account_id}"
    group_name        = "${var.group_name}"

    organization_role_name = "${var.organization_role_name}"
    tfstate_bucket_name    = "${var.tfstate_bucket_name}"
    tfstate_kms_key_arn    = "${var.tfstate_kms_key_arn}"

    assumable_roles = "${join(",",formatlist("\"arn:aws:iam::%s:role/%s-%s\"", var.allow_assume_prefixed_roles_in_accounts, var.group_name, var.role_name))}"
  }
}

resource "aws_iam_role_policy" "managed_role_policy_association" {
  provider = "aws.module_local"

  name   = "${var.group_name}-${var.role_name}-policy"
  role   = "${aws_iam_role.managed_role.id}"
  policy = "${data.template_file.managed_policy.rendered}"
}
