output "devbox-ip" {
  value = "${aws_instance.devbox.private_ip}"
}
