variable "account_id_list" {
  type = "map"
}

variable "deploy_env" {
  type = "string"
}

variable "deploy_region" {
  type = "string"
}

variable "sec_main_vpc_cidr" {
  type = "string"
}

variable "dev_main_vpc_cidr" {
  type = "string"
}

variable "rec_main_vpc_cidr" {
  type = "string"
}

variable "pil_main_vpc_cidr" {
  type = "string"
}

variable "prd_main_vpc_cidr" {
  type = "string"
}