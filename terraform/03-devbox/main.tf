resource "aws_key_pair" "devbox" {
  key_name_prefix = "devbox"
  public_key      = "${file(var.public_key_path)}"
}

resource "aws_instance" "devbox" {
  ami           = "${data.aws_ami.debian_ami.id}"
  instance_type = "t2.medium"

  key_name = "${aws_key_pair.devbox.key_name}"

  subnet_id = "${data.terraform_remote_state.landscape.private_subnets_ids_b[var.deploy_env]}"

  vpc_security_group_ids = ["${aws_security_group.devbox.id}"]

  tags {
    Name        = "bastion"
    Environment = "${var.deploy_env}"
    Owner       = "settlers"
    Stack       = "network-landscape"
    Cost        = "global"
  }
}

resource "aws_instance" "devbox2" {
  ami           = "${data.aws_ami.debian_ami.id}"
  instance_type = "t2.medium"

  key_name = "${aws_key_pair.devbox.key_name}"

  subnet_id = "${data.terraform_remote_state.landscape.public_subnets_ids_b[var.deploy_env]}"

  vpc_security_group_ids = ["${aws_security_group.devbox.id}"]

  tags {
    Name        = "bastion"
    Environment = "${var.deploy_env}"
    Owner       = "settlers"
    Stack       = "network-landscape"
    Cost        = "global"
  }
}

resource "aws_security_group" "devbox" {
  name_prefix = "bastion"
  vpc_id      = "${data.terraform_remote_state.landscape.vpcs_ids[var.deploy_env]}"
}

resource "aws_security_group_rule" "devbox_inbound" {
  security_group_id = "${aws_security_group.devbox.id}"
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_security_group_rule" "devbox_outbound" {
  security_group_id = "${aws_security_group.devbox.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
}
