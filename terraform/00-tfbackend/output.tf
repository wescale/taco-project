// Map to add in your backend configuration
output "backend_config_map" {
  value = <<EOF

tflayer_backend_config:
  bucket: "${module.tfbackend.backend_config_map["bucket"]}"
  region: "${module.tfbackend.backend_config_map["region"]}"
  encrypt: ${module.tfbackend.backend_config_map["encrypt"]}
  kms_key_id: "${module.tfbackend.backend_config_map["kms_key_id"]}"
  dynamodb_table: "${module.tfbackend.backend_config_map["dynamodb_table"]}"
EOF
}
