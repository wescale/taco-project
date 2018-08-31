variable deploy_account_id {
  type = "string"
}

variable deploy_env {
  type = "string"
}

variable deploy_region {
  type = "string"
}

variable subnet_id_a {
  type = "string"
}

variable subnet_id_b {
  type = "string"
}

variable subnet_id_c {
  type = "string"
}

variable route_table_id_a {
  type = "string"
}

variable route_table_id_b {
  type = "string"
}

variable route_table_id_c {
  type = "string"
}

provider "aws" {
  assume_role {
    session_name = "settlers-base"
    role_arn     = "arn:aws:iam::${var.deploy_account_id}:role/settlers-base"
  }
}
