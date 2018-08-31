output "bastion-private" {
  value = "${aws_instance.ephemeral-bastion.private_ip}"
}
