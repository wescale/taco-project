output "eips_ips" {
  value = {
    az_b = "${aws_eip.nat_b.public_ip}"
  }
}
