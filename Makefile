first_admin:
	ansible-playbook terrabot.yml -e tflayer=00-first-admin -e deploy_env=root -e deploy_region=eu-west-1 -e tfaction=apply

append_first_admin_name_to_terrabot_vars:
	terraform output -state=target/terrabot/00-first-admin/root.eu-west-1.tfstate for_terrabot >> terrabot.vars.yml


organization:
	ansible-playbook terrabot.yml -e tflayer=00-organization -e deploy_env=root -e deploy_region=eu-west-1 -e tfaction=apply

append_organization_to_terrabot_vars:
	terraform output -state=target/terrabot/00-organization/root.eu-west-1.tfstate accounts_id_for_terrabot >> terrabot.vars.yml


tfbackend:
	ansible-playbook terrabot.yml -e auto_apply=true -e tflayer=00-tfbackend -e deploy_env=sec -e deploy_region=eu-west-1 -e tfaction=apply

append_backend_conf_to_terrabot_vars:
	terraform output -state=target/terrabot/00-tfbackend/sec.eu-west-1.tfstate backend_config_map >> terrabot.vars.yml


move_first_admin_backend:
	ansible-playbook terrabot.yml -e tflayer=00-first-admin -e deploy_env=root -e deploy_region=eu-west-1 -e tfaction=plan -e local_state_to_s3=true

move_organization_backend:
	ansible-playbook terrabot.yml -e tflayer=00-organization -e deploy_env=root -e deploy_region=eu-west-1 -e tfaction=plan -e local_state_to_s3=true

move_tfbackend_backend:
	ansible-playbook terrabot.yml -e tflayer=00-tfbackend -e deploy_env=sec -e deploy_region=eu-west-1 -e tfaction=plan -e local_state_to_s3=true


config:
	ansible-playbook terrabot.yml -e tflayer=00-config -e deploy_env=sec -e deploy_region=eu-west-1 -e tfaction=apply -e auto_apply=true
