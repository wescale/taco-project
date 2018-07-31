provider "aws" {}

resource "aws_iam_user" "first" {
  name = "${var.basename}-administrator"
}

resource "aws_iam_user_policy_attachment" "admin" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  user       = "${aws_iam_user.first.name}"
}
