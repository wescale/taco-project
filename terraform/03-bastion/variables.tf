# -----------------------------------------------------------------------------

provider "aws" {
  assume_role {
    session_name = "settlers-base"
    role_arn     = "arn:aws:iam::${var.account_id_list[var.deploy_env]}:role/settlers-base"
  }
}

# -----------------------------------------------------------------------------
data "aws_ami" "debian_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-stretch-hvm-x86_64-gp2-*"]
  }

  filter {
    name   = "owner-id"
    values = ["379101102735"]
  }
}

# -----------------------------------------------------------------------------

variable "public_key_path" {
  type = "string"
}

data "terraform_remote_state" "landscape" {
  backend = "s3"

  config {
    bucket     = "${var.tfstate_bucket_name}"
    key        = "tflayers/03-network-landscape/root.${var.deploy_region}.tfstate"
    region     = "${var.deploy_region}"
    kms_key_id = "${var.tfstate_kms_key_arn}"
  }
}

variable "account_id_list" {
  type = "map"
}

variable "deploy_env" {
  type = "string"
}

variable "deploy_region" {
  type = "string"
}

variable "tfstate_bucket_name" {
  type = "string"
}

variable "tfstate_kms_key_arn" {
  type = "string"
}
