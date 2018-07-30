variable "allow_access_to_billing" {
  default = false
}

variable "organization_role_name" {
  type    = "string"
  default = "OrganizationAdmin"
}

variable "basename" {
  type = "string"
}

variable "subname" {
  type = "string"
}

variable "root_email" {
  type = "string"
}
