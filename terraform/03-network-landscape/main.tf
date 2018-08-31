module "sec_vpc_layout" {
  source = "../mod_multi_az_vpc"

  vpc_cidr = "${var.sec_main_vpc_cidr}"

  region = "${var.deploy_region}"

  environment = "sec"
  owner       = "settlers"
  stack       = "network-landscape"
  cost        = "global"

  run_as = "arn:aws:iam::${var.account_id_list["sec"]}:role/settlers-base"
}

module "dev_vpc_layout" {
  source = "../mod_multi_az_vpc"

  vpc_cidr = "${var.dev_main_vpc_cidr}"

  region = "${var.deploy_region}"

  environment = "dev"
  owner       = "settlers"
  stack       = "network-landscape"
  cost        = "global"

  run_as = "arn:aws:iam::${var.account_id_list["dev"]}:role/settlers-base"
}

module "rec_vpc_layout" {
  source = "../mod_multi_az_vpc"

  vpc_cidr = "${var.rec_main_vpc_cidr}"

  region = "${var.deploy_region}"

  environment = "rec"
  owner       = "settlers"
  stack       = "network-landscape"
  cost        = "global"

  run_as = "arn:aws:iam::${var.account_id_list["rec"]}:role/settlers-base"
}

module "pil_vpc_layout" {
  source = "../mod_multi_az_vpc"

  vpc_cidr = "${var.pil_main_vpc_cidr}"

  region = "${var.deploy_region}"

  environment = "pil"
  owner       = "settlers"
  stack       = "network-landscape"
  cost        = "global"

  run_as = "arn:aws:iam::${var.account_id_list["pil"]}:role/settlers-base"
}

module "prd_vpc_layout" {
  source = "../mod_multi_az_vpc"

  vpc_cidr = "${var.prd_main_vpc_cidr}"

  region = "${var.deploy_region}"

  environment = "prd"
  owner       = "settlers"
  stack       = "network-landscape"
  cost        = "global"

  run_as = "arn:aws:iam::${var.account_id_list["prd"]}:role/settlers-base"
}
