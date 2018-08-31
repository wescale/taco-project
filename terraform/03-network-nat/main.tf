# -----------------------------------------------------------------------------
module "sec_nat_layout" {
  source            = "../mod_nat"
  deploy_env        = "sec"
  subnet_id_a       = "${data.terraform_remote_state.landscape.public_subnets_ids_a["sec"]}"
  subnet_id_b       = "${data.terraform_remote_state.landscape.public_subnets_ids_b["sec"]}"
  subnet_id_c       = "${data.terraform_remote_state.landscape.public_subnets_ids_c["sec"]}"
  route_table_id_a  = "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_a["sec"]}"
  route_table_id_b  = "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_b["sec"]}"
  route_table_id_c  = "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_c["sec"]}"
  deploy_region     = "${var.deploy_region}"
  deploy_account_id = "${var.account_id_list["sec"]}"
}

module "dev_nat_layout" {
  source            = "../mod_nat"
  deploy_env        = "dev"
  subnet_id_a       = "${data.terraform_remote_state.landscape.public_subnets_ids_a["dev"]}"
  subnet_id_b       = "${data.terraform_remote_state.landscape.public_subnets_ids_b["dev"]}"
  subnet_id_c       = "${data.terraform_remote_state.landscape.public_subnets_ids_c["dev"]}"
  route_table_id_a  = "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_a["dev"]}"
  route_table_id_b  = "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_b["dev"]}"
  route_table_id_c  = "${data.terraform_remote_state.landscape.private_subnets_route_table_ids_c["dev"]}"
  deploy_region     = "${var.deploy_region}"
  deploy_account_id = "${var.account_id_list["dev"]}"
}
