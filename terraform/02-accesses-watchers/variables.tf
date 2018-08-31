variable "account_id_list" {
  type = "map"
}

variable "memberlist_watchers_base" {
  type    = "list"
  default = []
}

variable "memberlist_watchers_billing" {
  type    = "list"
  default = []
}

variable "memberlist_watchers_audit" {
  type    = "list"
  default = []
}

variable "tfstate_bucket_name" {
  type = "string"
}
