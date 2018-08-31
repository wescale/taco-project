# -----------------------------------------------------------------------------
module "dev_vpc_peering" {
  source = "../mod_vpc_peering"

  deploy_region = "${var.deploy_region}"

  requester_account_id = "${var.account_id_list[var.deploy_env]}"
  requester_vpc_id     = "${data.terraform_remote_state.landscape.vpcs_ids[var.deploy_env]}"
  requester_env        = "${var.deploy_env}"
  requester_cidr_block = "${data.terraform_remote_state.landscape.vpcs_cidrs[var.deploy_env]}"

  requester_private_route_table_list = [
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_a[var.deploy_env]}",
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_b[var.deploy_env]}",
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_c[var.deploy_env]}",
  ]

  accepter_private_route_table_list = [
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_a["dev"]}",
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_b["dev"]}",
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_c["dev"]}",
  ]

  accepter_account_id       = "${var.account_id_list["dev"]}"
  accepter_vpc_id           = "${data.terraform_remote_state.landscape.vpcs_ids["dev"]}"
  accepter_main_route_table = "${data.terraform_remote_state.landscape.main_route_table["dev"]}"
  accepter_cidr_block       = "${data.terraform_remote_state.landscape.vpcs_cidrs["dev"]}"
  accepter_env              = "dev"

  run_as = "arn:aws:iam::${var.account_id_list["dev"]}:role/settlers-base"
}

module "rec_vpc_peering" {
  source = "../mod_vpc_peering"

  deploy_region = "${var.deploy_region}"

  requester_account_id = "${var.account_id_list[var.deploy_env]}"
  requester_vpc_id     = "${data.terraform_remote_state.landscape.vpcs_ids[var.deploy_env]}"
  requester_env        = "${var.deploy_env}"
  requester_cidr_block = "${data.terraform_remote_state.landscape.vpcs_cidrs[var.deploy_env]}"

  requester_private_route_table_list = [
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_a[var.deploy_env]}",
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_b[var.deploy_env]}",
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_c[var.deploy_env]}",
  ]

  accepter_private_route_table_list = [
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_a["rec"]}",
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_b["rec"]}",
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_c["rec"]}",
  ]

  accepter_account_id       = "${var.account_id_list["rec"]}"
  accepter_vpc_id           = "${data.terraform_remote_state.landscape.vpcs_ids["rec"]}"
  accepter_main_route_table = "${data.terraform_remote_state.landscape.main_route_table["rec"]}"
  accepter_cidr_block       = "${data.terraform_remote_state.landscape.vpcs_cidrs["rec"]}"
  accepter_env              = "rec"

  run_as = "arn:aws:iam::${var.account_id_list["rec"]}:role/settlers-base"
}

module "pil_vpc_peering" {
  source = "../mod_vpc_peering"

  deploy_region = "${var.deploy_region}"

  requester_account_id = "${var.account_id_list[var.deploy_env]}"
  requester_vpc_id     = "${data.terraform_remote_state.landscape.vpcs_ids[var.deploy_env]}"
  requester_env        = "${var.deploy_env}"
  requester_cidr_block = "${data.terraform_remote_state.landscape.vpcs_cidrs[var.deploy_env]}"

  requester_private_route_table_list = [
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_a[var.deploy_env]}",
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_b[var.deploy_env]}",
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_c[var.deploy_env]}",
  ]

  accepter_private_route_table_list = [
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_a["pil"]}",
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_b["pil"]}",
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_c["pil"]}",
  ]

  accepter_account_id       = "${var.account_id_list["pil"]}"
  accepter_vpc_id           = "${data.terraform_remote_state.landscape.vpcs_ids["pil"]}"
  accepter_main_route_table = "${data.terraform_remote_state.landscape.main_route_table["pil"]}"
  accepter_cidr_block       = "${data.terraform_remote_state.landscape.vpcs_cidrs["pil"]}"
  accepter_env              = "pil"

  run_as = "arn:aws:iam::${var.account_id_list["pil"]}:role/settlers-base"
}

module "prd_vpc_peering" {
  source = "../mod_vpc_peering"

  deploy_region = "${var.deploy_region}"

  requester_account_id = "${var.account_id_list[var.deploy_env]}"
  requester_vpc_id     = "${data.terraform_remote_state.landscape.vpcs_ids[var.deploy_env]}"
  requester_env        = "${var.deploy_env}"
  requester_cidr_block = "${data.terraform_remote_state.landscape.vpcs_cidrs[var.deploy_env]}"

  requester_private_route_table_list = [
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_a[var.deploy_env]}",
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_b[var.deploy_env]}",
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_c[var.deploy_env]}",
  ]

  accepter_private_route_table_list = [
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_a["prd"]}",
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_b["prd"]}",
    "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_c["prd"]}",
  ]

  accepter_account_id       = "${var.account_id_list["prd"]}"
  accepter_vpc_id           = "${data.terraform_remote_state.landscape.vpcs_ids["prd"]}"
  accepter_main_route_table = "${data.terraform_remote_state.landscape.main_route_table["prd"]}"
  accepter_cidr_block       = "${data.terraform_remote_state.landscape.vpcs_cidrs["prd"]}"
  accepter_env              = "prd"

  run_as = "arn:aws:iam::${var.account_id_list["prd"]}:role/settlers-base"
}