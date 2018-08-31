# Terrabot

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

```

* Create an access key and a secret key
* Source them in a terminal and run:

```
make 00-first-admin
```

add first-admin name to terrabot.vars.yml
add root_email to terrabot.vars

switch to first_admin credentials

* Wait for the support ticket to complete.
* 

make organization

make append_organization_to_terrabot_vars
check terrabot.vars.yml to ensure syntax

