# The T.A.C.O. project
### Terraform and Ansible, Combined & Organized

## What you will find here

* An Ansible toolkit aimed at making a standardized use of Terraform.
* Terraform code for setting up an opiniated multi-account AWS organizations.

## What you will need on your workstation to use it

* A usable installation of Ansible
* A usable installation of Terraform
* The `make` CLI tool

## Procedure to land on the AWS planet


* Create an account and connect a the root user.
* Create a support ticket with these values:
    * _Limit increase request_
    * _Service:_ Organizations
    * _Limit name:_ Number of Accounts
    * _New limit value:_ 10
    
Do not forget to put a kind message for support team in your ticket, they do a great job.

* Create a new file named `terrabot.vars.yml` at the root of the project and fill it like this:

```
---
# This is a short label with only alphanumeric.
# It will be use to prefix every AWS account of your organization.
basename: "terrabot"

# The email you used for creating the account one first step.
root_email: "your_root@email"

# The main region you will be operating from for this deployment.
main_region: "eu-west-1"

```

* Create an access key and a secret key
* Source them in a terminal and run:

```
make first_admin
make append_first_admin_name_to_terrabot_vars
```

* Create an access key and a secret key *for the first admin account*
* Source them in a terminal and run:

```
make organization
make append_organization_to_terrabot_vars
make tfbackend
make append_backend_conf_to_terrabot_vars
make move_first_admin_backend
make move_organization_backend
make move_tfbackend_backend
```

At this point you have setup:

* a whole organization, with a SEC account aimed at hosting common services for the other accounts.
* an S3 bucket in the SEC account for hosting the tfstate files.

## Coming soon in this documentation

* User creation procedure
* The user tribes
* How to work efficiently as a tribe member
* Network landscape
* Nat
* Peering

TODO
* exercice 3 le coup des 10m sur taint