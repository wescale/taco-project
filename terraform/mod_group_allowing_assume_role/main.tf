resource "aws_iam_group" "managed_group" {
  name = "${var.group_name}"
  path = "/${var.group_name}/"
}

data "template_file" "assume_prefixed_role_with_mfa" {
  template = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect":   "Allow",
    "Action":   "sts:AssumeRole",
    "Resource": [
      ${join(",",formatlist("\"arn:aws:iam::%s:role/%s-*\"", var.allow_assume_prefixed_roles_in_accounts, var.group_name))}
    ],
    "Condition": {
      "Bool": {
        "aws:MultiFactorAuthPresent": "true"
      }
    }
  }
}
EOF
}

resource "aws_iam_group_policy" "managed_group_policy" {
  name   = "${var.group_name}_group_policy"
  group  = "${aws_iam_group.managed_group.id}"
  policy = "${data.template_file.assume_prefixed_role_with_mfa.rendered}"
}

resource "aws_iam_group_membership" "team" {
  name  = "${var.group_name}_group_membership"
  group = "${aws_iam_group.managed_group.name}"
  users = "${var.members}"
}
