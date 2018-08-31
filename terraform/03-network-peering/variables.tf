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
