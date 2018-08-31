###############################################################################
# Make request
###############################################################################
resource "aws_vpc_peering_connection" "peer" {
  provider      = "aws.requester"
  vpc_id        = "${var.requester_vpc_id}"
  peer_vpc_id   = "${var.accepter_vpc_id}"
  peer_owner_id = "${var.accepter_account_id}"
  auto_accept   = false

  tags {
    Name = "${var.requester_env} to ${var.accepter_env} Requester"
  }

  lifecycle {
    prevent_destroy = true
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = "aws.accepter"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
  auto_accept               = true

  tags {
    Name = "${var.requester_env} to ${var.accepter_env} Accepter"
  }

  lifecycle {
    prevent_destroy = true
  }
}

# ------------------------------

resource "aws_route" "accepter_global_route_to_requester_private_subnets" {
  provider = "aws.accepter"

  route_table_id            = "${var.accepter_main_route_table}"
  destination_cidr_block    = "${var.requester_cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
}

resource "aws_route" "accepter_private_subnets_to_requester_global" {
  provider = "aws.accepter"

  count = "${length(var.accepter_private_route_table_list)}"

  route_table_id            = "${var.accepter_private_route_table_list[count.index]}"
  destination_cidr_block    = "${var.requester_cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
}

resource "aws_route" "requester_private_subnets_route_to_acceper_global" {
  provider = "aws.requester"

  count = "${length(var.requester_private_route_table_list)}"

  route_table_id            = "${var.requester_private_route_table_list[count.index]}"
  destination_cidr_block    = "${var.accepter_cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
}
