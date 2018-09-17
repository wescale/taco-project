first_admin:
	ansible-playbook taco.yml -e tflayer=00-first-admin -e deploy_env=root -e deploy_region=eu-west-1 -e tfaction=apply

append_first_admin_name_to_taco_vars:
	terraform output -state=target/taco/00-first-admin/root.eu-west-1.tfstate for_taco >> taco.vars.yml


organization:
	ansible-playbook taco.yml -e tflayer=00-organization -e deploy_env=root -e deploy_region=eu-west-1 -e tfaction=apply

append_organization_to_taco_vars:
	terraform output -state=target/taco/00-organization/root.eu-west-1.tfstate accounts_id_for_taco >> taco.vars.yml


tfbackend:
	ansible-playbook taco.yml -e tflayer=00-tfbackend -e deploy_env=sec -e deploy_region=eu-west-1 -e tfaction=apply

append_backend_conf_to_taco_vars:
	terraform output -state=target/taco/00-tfbackend/sec.eu-west-1.tfstate backend_config_map >> taco.vars.yml


move_first_admin_backend:
	ansible-playbook taco.yml -e tflayer=00-first-admin -e deploy_env=root -e deploy_region=eu-west-1 -e tfaction=plan -e local_state_to_s3=true

move_organization_backend:
	ansible-playbook taco.yml -e tflayer=00-organization -e deploy_env=root -e deploy_region=eu-west-1 -e tfaction=plan -e local_state_to_s3=true

move_tfbackend_backend:
	ansible-playbook taco.yml -e tflayer=00-tfbackend -e deploy_env=sec -e deploy_region=eu-west-1 -e tfaction=plan -e local_state_to_s3=true


config:
	ansible-playbook taco.yml -e tflayer=00-config -e deploy_env=sec -e deploy_region=eu-west-1 -e tfaction=apply
