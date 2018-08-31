# Terrabot

## What you will find here

* An Ansible toolkit aimed at making a standardized use of Terraform.
* Terraform code for setting up an opiniated multi-account AWS organizations.

## Procedure to land on the AWS planet

* Create an account and connect a the root user.
* Create a support ticket with these values:
    Limit increase request 1
    Service: Organizations
    Limit name: Number of Accounts
    New limit value: 10
    
Do not forget to put a kind message for support team in your ticket, they do a great job.

Create access key secret key
source it to terminal and run first stack

00-first-admin

add first-admin name to terrabot.vars.yml
add root_email to terrabot.vars

switch to first_admin credentials
Wait for the support ticket to complete.

make organization

make append_organization_to_terrabot_vars
check terrabot.vars.yml to ensure syntax

