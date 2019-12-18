# The TACO Project
#### Terraform & Ansible, Combined & Organized

## Where am I ?

This is the homepage of the TACO project obviously...

TACO is a thin ansible wrapper for Terraform that provides extra features for keeping your Terraform configurations DRY and managing remote state.

## Prerequisites

For you to benefit of TACO, you need to make your terraform projects match some basic requirements.

* Have a `terraform` directory, in which you will group several directories containing Terraform code.
These sub-directories `terraform/*` will be our *layers* directories.

## Usage

* You must have [Ansible installed](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
* Get the project code, either by:
  * [Downloading it](https://github.com/WeScale/taco-project/releases)
  * or `git clone` the project
* For comfort, I recommend to export a `TACO_HOME` environment variable to point to the root of the
TACO project on your machine
* Then simply run `ansible-playbook ${TACO_HOME}/taco.yml` from the root of a compliant Terraform project.
  * You will have to supply 4 variables to the ansible run :
    * `tflayer`: the name of the Terraform layer you want to target
    * `deploy_env`: a label that should be used to differenciate you several tfstates
    * `deploy_region`: the region you will work in
    * `tfaction`: the desired Terraform workflow phase you want

## Managing variables


## Managing backend configuration


## Links

[FAQ](FAQ.md)
