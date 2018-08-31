variable "group_name" {}

variable "members" {
  type    = "list"
  default = []
}

variable "allow_assume_prefixed_roles_in_accounts" {
  type    = "list"
  default = []
}
