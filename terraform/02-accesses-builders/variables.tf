variable "account_id_list" {
  type = "map"
}

variable "organization_role_name" {
  type = "string"
}

variable "deploy_env" {
  type = "string"
}

variable "deploy_region" {
  type = "string"
}

variable "memberlist_builders_base" {
  type    = "list"
  default = []
}

variable "tfstate_bucket_name" {
  type = "string"
}

variable "tfstate_kms_key_arn" {
  type = "string"
}
