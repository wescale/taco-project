# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------

variable "memberlist_all" {
  type    = "list"
  default = []
}

variable "deploy_region" {
  type = "string"
}

variable "account_id_list" {
  type = "map"
}

variable "memberlist_keepers_base" {
  type    = "list"
  default = []
}

variable "run_as" {
  type = "string"
}

variable "organization_role_name" {
  type = "string"
}

variable "tfstate_bucket_name" {
  type = "string"
}

variable "tfstate_kms_key_arn" {
  type = "string"
}
