output "first_admin" {
  value = "${aws_iam_user.first.name}"
}

output "for_taco" {
  value = <<EOF

first_admin_name: "${aws_iam_user.first.name}"
EOF
}