first-admin:
ansible-playbook terrabot.yml -e tflayer=00-first-admin -e deploy_env=root -e deploy_region=eu-west-1 -e tfaction=apply
