output "vpcs_ids" {
  value = {
    sec = "${module.sec_vpc_layout.vpc_id}"
    dev = "${module.dev_vpc_layout.vpc_id}"
    rec = "${module.rec_vpc_layout.vpc_id}"
    pil = "${module.pil_vpc_layout.vpc_id}"
    prd = "${module.prd_vpc_layout.vpc_id}"
  }
}

output "vpcs_cidrs" {
  value = {
    sec = "${module.sec_vpc_layout.vpc_cidr}"
    dev = "${module.dev_vpc_layout.vpc_cidr}"
    rec = "${module.rec_vpc_layout.vpc_cidr}"
    pil = "${module.pil_vpc_layout.vpc_cidr}"
    prd = "${module.prd_vpc_layout.vpc_cidr}"
  }
}

# ------------------------------------------------------------------------------

output "public_subnets_ids_a" {
  value = {
    sec = "${module.sec_vpc_layout.public_subnet_id_a}"
    dev = "${module.dev_vpc_layout.public_subnet_id_a}"
    rec = "${module.rec_vpc_layout.public_subnet_id_a}"
    pil = "${module.pil_vpc_layout.public_subnet_id_a}"
    prd = "${module.prd_vpc_layout.public_subnet_id_a}"
  }
}

output "public_subnets_ids_b" {
  value = {
    sec = "${module.sec_vpc_layout.public_subnet_id_b}"
    dev = "${module.dev_vpc_layout.public_subnet_id_b}"
    rec = "${module.rec_vpc_layout.public_subnet_id_b}"
    pil = "${module.pil_vpc_layout.public_subnet_id_b}"
    prd = "${module.prd_vpc_layout.public_subnet_id_b}"
  }
}

output "public_subnets_ids_c" {
  value = {
    sec = "${module.sec_vpc_layout.public_subnet_id_c}"
    dev = "${module.dev_vpc_layout.public_subnet_id_c}"
    rec = "${module.rec_vpc_layout.public_subnet_id_c}"
    pil = "${module.pil_vpc_layout.public_subnet_id_c}"
    prd = "${module.prd_vpc_layout.public_subnet_id_c}"
  }
}

# ------------------------------------------------------------------------------

output "public_subnets_cidrs_a" {
  value = {
    sec = "${module.sec_vpc_layout.public_subnet_cidr_a}"
    dev = "${module.dev_vpc_layout.public_subnet_cidr_a}"
    rec = "${module.rec_vpc_layout.public_subnet_cidr_a}"
    pil = "${module.pil_vpc_layout.public_subnet_cidr_a}"
    prd = "${module.prd_vpc_layout.public_subnet_cidr_a}"
  }
}

output "public_subnets_cidrs_b" {
  value = {
    sec = "${module.sec_vpc_layout.public_subnet_cidr_b}"
    dev = "${module.dev_vpc_layout.public_subnet_cidr_b}"
    rec = "${module.rec_vpc_layout.public_subnet_cidr_b}"
    pil = "${module.pil_vpc_layout.public_subnet_cidr_b}"
    prd = "${module.prd_vpc_layout.public_subnet_cidr_b}"
  }
}

output "public_subnets_cidrs_c" {
  value = {
    sec = "${module.sec_vpc_layout.public_subnet_cidr_c}"
    dev = "${module.dev_vpc_layout.public_subnet_cidr_c}"
    rec = "${module.rec_vpc_layout.public_subnet_cidr_c}"
    pil = "${module.pil_vpc_layout.public_subnet_cidr_c}"
    prd = "${module.prd_vpc_layout.public_subnet_cidr_c}"
  }
}

# ------------------------------------------------------------------------------

output "private_subnets_ids_a" {
  value = {
    sec = "${module.sec_vpc_layout.private_subnet_id_a}"
    dev = "${module.dev_vpc_layout.private_subnet_id_a}"
    rec = "${module.rec_vpc_layout.private_subnet_id_a}"
    pil = "${module.pil_vpc_layout.private_subnet_id_a}"
    prd = "${module.prd_vpc_layout.private_subnet_id_a}"
  }
}

output "private_subnets_ids_b" {
  value = {
    sec = "${module.sec_vpc_layout.private_subnet_id_b}"
    dev = "${module.dev_vpc_layout.private_subnet_id_b}"
    rec = "${module.rec_vpc_layout.private_subnet_id_b}"
    pil = "${module.pil_vpc_layout.private_subnet_id_b}"
    prd = "${module.prd_vpc_layout.private_subnet_id_b}"
  }
}

output "private_subnets_ids_c" {
  value = {
    sec = "${module.sec_vpc_layout.private_subnet_id_c}"
    dev = "${module.dev_vpc_layout.private_subnet_id_c}"
    rec = "${module.rec_vpc_layout.private_subnet_id_c}"
    pil = "${module.pil_vpc_layout.private_subnet_id_c}"
    prd = "${module.prd_vpc_layout.private_subnet_id_c}"
  }
}

# ------------------------------------------------------------------------------

output "private_subnets_cidrs_a" {
  value = {
    sec = "${module.sec_vpc_layout.private_subnet_cidr_a}"
    dev = "${module.dev_vpc_layout.private_subnet_cidr_a}"
    rec = "${module.rec_vpc_layout.private_subnet_cidr_a}"
    pil = "${module.pil_vpc_layout.private_subnet_cidr_a}"
    prd = "${module.prd_vpc_layout.private_subnet_cidr_a}"
  }
}

output "private_subnets_cidrs_b" {
  value = {
    sec = "${module.sec_vpc_layout.private_subnet_cidr_b}"
    dev = "${module.dev_vpc_layout.private_subnet_cidr_b}"
    rec = "${module.rec_vpc_layout.private_subnet_cidr_b}"
    pil = "${module.pil_vpc_layout.private_subnet_cidr_b}"
    prd = "${module.prd_vpc_layout.private_subnet_cidr_b}"
  }
}

output "private_subnets_cidrs_c" {
  value = {
    sec = "${module.sec_vpc_layout.private_subnet_cidr_c}"
    dev = "${module.dev_vpc_layout.private_subnet_cidr_c}"
    rec = "${module.rec_vpc_layout.private_subnet_cidr_c}"
    pil = "${module.pil_vpc_layout.private_subnet_cidr_c}"
    prd = "${module.prd_vpc_layout.private_subnet_cidr_c}"
  }
}

# ------------------------------------------------------------------------------

output "private_subnets_route_table_ids_a" {
  value = {
    sec = "${module.sec_vpc_layout.private_subnet_route_table_id_a}"
    dev = "${module.dev_vpc_layout.private_subnet_route_table_id_a}"
    rec = "${module.rec_vpc_layout.private_subnet_route_table_id_a}"
    pil = "${module.pil_vpc_layout.private_subnet_route_table_id_a}"
    prd = "${module.prd_vpc_layout.private_subnet_route_table_id_a}"
  }
}

output "private_subnets_route_table_ids_b" {
  value = {
    sec = "${module.sec_vpc_layout.private_subnet_route_table_id_b}"
    dev = "${module.dev_vpc_layout.private_subnet_route_table_id_b}"
    rec = "${module.rec_vpc_layout.private_subnet_route_table_id_b}"
    pil = "${module.pil_vpc_layout.private_subnet_route_table_id_b}"
    prd = "${module.prd_vpc_layout.private_subnet_route_table_id_b}"
  }
}

output "private_subnets_route_table_ids_c" {
  value = {
    sec = "${module.sec_vpc_layout.private_subnet_route_table_id_c}"
    dev = "${module.dev_vpc_layout.private_subnet_route_table_id_c}"
    rec = "${module.rec_vpc_layout.private_subnet_route_table_id_c}"
    pil = "${module.pil_vpc_layout.private_subnet_route_table_id_c}"
    prd = "${module.prd_vpc_layout.private_subnet_route_table_id_c}"
  }
}

# ------------------------------------------------------------------------------

output "main_route_table" {
  value = {
    sec = "${module.sec_vpc_layout.main_route_table_id}"
    dev = "${module.dev_vpc_layout.main_route_table_id}"
    rec = "${module.rec_vpc_layout.main_route_table_id}"
    pil = "${module.pil_vpc_layout.main_route_table_id}"
    prd = "${module.prd_vpc_layout.main_route_table_id}"
  }
}
