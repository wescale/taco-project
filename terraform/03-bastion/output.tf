output "bastion" {
  value = "${aws_instance.ephemeral-bastion.public_ip}"
}

output "bastion_sg_id" {
  value = "${aws_security_group.bastion.id}"
}

output "bastion_realm_sg_id" {
  value = "${aws_security_group.bastion_realm.id}"
}
