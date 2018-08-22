variable "organization_role_name" {
  type = "string"
}

variable "account_id_list" {
  type = "map"
}

variable "basename" {
  type = "string"
}

variable "first_admin_name" {
  type = "string"
}

variable "main_region" {
  type = "string"
}

provider "aws" {
  alias = "root"
}

provider "aws" {
  alias = "sec"

  assume_role {
    session_name = "${var.organization_role_name}"
    role_arn     = "arn:aws:iam::${var.account_id_list["sec"]}:role/${var.organization_role_name}"
  }
}

provider "aws" {
  alias = "dev"

  assume_role {
    session_name = "${var.organization_role_name}"
    role_arn     = "arn:aws:iam::${var.account_id_list["dev"]}:role/${var.organization_role_name}"
  }
}

provider "aws" {
  alias = "rec"

  assume_role {
    session_name = "${var.organization_role_name}"
    role_arn     = "arn:aws:iam::${var.account_id_list["rec"]}:role/${var.organization_role_name}"
  }
}

provider "aws" {
  alias = "pre"

  assume_role {
    session_name = "${var.organization_role_name}"
    role_arn     = "arn:aws:iam::${var.account_id_list["pre"]}:role/${var.organization_role_name}"
  }
}

provider "aws" {
  alias = "prd"

  assume_role {
    session_name = "${var.organization_role_name}"
    role_arn     = "arn:aws:iam::${var.account_id_list["prd"]}:role/${var.organization_role_name}"
  }
}
