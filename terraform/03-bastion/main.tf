resource "aws_key_pair" "nat_instance" {
  key_name_prefix = "bastion"
  public_key      = "${file(var.public_key_path)}"
}

resource "aws_instance" "ephemeral-bastion" {
  ami           = "${data.aws_ami.debian_ami.id}"
  instance_type = "t2.medium"

  key_name = "${aws_key_pair.nat_instance.key_name}"

  subnet_id = "${data.terraform_remote_state.landscape.public_subnets_ids_b[var.deploy_env]}"

  associate_public_ip_address = true

  vpc_security_group_ids = ["${aws_security_group.bastion.id}"]

  tags {
    Name        = "bastion"
    Environment = "${var.deploy_env}"
    Owner       = "settlers"
    Stack       = "network-landscape"
    Cost        = "global"
  }
}

##
# BASTION REALM - Every server should be part of this security group.
##
resource "aws_security_group" "bastion" {
  name_prefix = "bastion"
  vpc_id      = "${lookup(data.terraform_remote_state.landscape.vpcs_ids, var.deploy_env)}"

  tags {
    Name        = "bastion-instances-${var.deploy_env}"
    Environment = "${var.deploy_env}"
    Owner       = "settlers"
    Stack       = "network-landscape"
    Cost        = "global"
  }
}

resource "aws_security_group_rule" "sgri_bastion_ssh_10_80_10" {
  security_group_id = "${aws_security_group.bastion.id}"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "sgro_bastion_ssh" {
  security_group_id = "${aws_security_group.bastion.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "bastion_realm" {
  name_prefix = "bastion-realm"
  vpc_id      = "${lookup(data.terraform_remote_state.landscape.vpcs_ids, var.deploy_env)}"
}

resource "aws_security_group_rule" "sgri_bastion_realm_ssh" {
  security_group_id        = "${aws_security_group.bastion_realm.id}"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion.id}"
}
