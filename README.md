# The TACO Project
#### Terraform & Ansible, Combined & Organized

## Where am I ?

This is the homepage of the TACO project obviously... TACO is a thin ansible wrapper for Terraform that provides extra features and conventions for keeping your Terraform configurations DRY.

## Features

TACO brings you key features to gain time in your every day work around Terraform:
* a smart way of managing variables in a DRY way
* an awesome way of managing dynamic backend configurations
* the fantabulous capacity of deploying remote Terraform stack from their git repository url

## Prerequisites

* [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) (tested with Ansible 2.9.x)
* [Install Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) (tested on 0.12.x)
* Have a `terraform` directory, in which you will group several directories containing Terraform code.
These sub-directories `terraform/*` will be our *layers* directories.

## Installation

* Get the project code, either by:
  * [Downloading it](https://github.com/WeScale/taco-project/releases)
  * or `git clone` the project
* Export a `TACO_HOME` environment variable to point to the root of the TACO project on your machine

## Usage

Run `ansible-playbook ${TACO_HOME}/taco.yml` from the root of a compliant Terraform project.
  * You will have to supply some variables to the ansible run :
    * `tflayer`        : the name of the Terraform layer you want to target. Can be any subdirectory of the `terraform/` directory
    * `deploy_env`     : a label that should be used to differenciate you several tfstates
    * `deploy_region`  : the region you intend to apply your Terraform layer.
    * `tfaction`       : the desired Terraform workflow phase you want. Can be one of `[ init | plan | apply | refresh | import | state | output | destroy ]`  
* For some Terraform workflow phases, you will need to supply additionally variables to the ansible run
    * Mandatory variables when running `import` terraform workflow phase :
        * `tf_addr` : specify the address to import the resource to
        * `tf_id`   : specify the resource-specific ID to identify that resource being imported
    * Mandatory variables when running `state` terraform workflow phase :
        * `tf_state_action` : specify the state action wanted. Supported actions : `list`, `show`, `pull`, `rm`.
        * Semi-mandatory `tf_addr` (can be left to an empty string) : specify the address targeted by the state action  
          * e.g. for a `terraform state rm ADRESS`, you need to give the targeted resource adress : `tf_addr="aws_iam_user.targeted_user"`
          * e.g. for a `terraform state [list,pull]`, you need to set `tf_addr=""`.
     * Optional variables when running `output` terraform workflow phase :
        * `tf_name`        : specify the name of the resource to output
        * `tf_output_file` : specify the name of the output file where the `output` result command will be redirect (file will be available on taco layer target directory)

## Smartly managing variables

The main feature of TACO is to deport variables in YAML files and rely on Ansible variable and templating
feature instead of passing `tfvars` files by hand to Terraform.

If multiple variables of the same name are defined in different places, they get overwritten in a certain order. In the list below, the `{{ tflayer }}`, `{{ deploy_env }}` and `{{ deploy_region }}` placeholders refers to the value passed to the `taco.yml` playbook. Here is the order of precedence from least to greatest (the last listed variables winning prioritization):

* `terraform/all-layers.taco.yml`
* `terraform/{{ tflayer }}/all-env.all-region.taco.yml`
* `terraform/{{ tflayer }}/all-env.{{ deploy_region }}.taco.yml`
* `terraform/{{ tflayer }}/{{ deploy_env }}.all-region.taco.yml`
* `terraform/{{ tflayer }}/{{ deploy_env }}.{{ deploy_region }}.taco.yml`

Avoid defining the variable `x` in many places and then ask the question "which x gets used". There is only one Empire State Building. One Mona Lisa, etc. Figure out where to define a variable, and don’t make it complicated.

When running Terraform CLI, TACO will:

* read all these files and gather every variable defined there
* scan Terraform code and find every `variable "xxx"` definition
* generate a JSON file with every values needed by the Terraform code
* pass it to the Terraform CLI via a `-var-file=...` option

## Awesomely managing dynamic backend configuration

Among the several ways of defining Terraform backend configuration, we chose to pass them via CLI options
supplied to `terraform init -backend-config=...`.

It is based on the presence of a special variable named `tflayer_backend_config` in the YAML variables files. It should be a map and every key-value in it will become option for the init phase.

For example, if you have this in your YAML variable files:
```
tflayer_backend_config:
  bucket: "project-tfstates"
  region: "eu-west-1"
  encrypt: "true"
  kms_key_id: "arn:aws:kms:eu-west-1:000666000666:key/0dd666ee-25aa-a2a2-8888-042042042fff"
  key: "tflayers/{{ tflayer }}/{{ deploy_env }}.{{ deploy_region }}.tfstate"
  dynamodb_table: "project-tfstates-lock"
```

And you run this from the root of your Terraform project:
```
ansible-playbook ${TACO_HOME}/taco.yml \
  -e tflayer=network                   \
  -e tfaction=init                     \
  -e deploy_env=dev                    \
  -e deploy_region=eu-west-3
```

Then this will add init option like:
```
terraform init [...]
-backend-config="bucket=project-tfstates"
-backend-config="region=eu-west-1"
-backend-config="encrypt=true"
-backend-config="kms_key_id=arn:aws:kms:eu-west-1:000666000666:key/0dd666ee-25aa-a2a2-8888-042042042fff"
-backend-config="key=tflayers/network/dev.eu-west-3.tfstate"
-backend-config="dynamodb_table=project-tfstates-lock"
```

## Fantabulously deploying remote Terraform project



## Frequently Asked Questions
### Why use Ansible instead of `$MY_PREFERED_TOOL` ?

For three simple reasons:

* Ansible makes it easy to open and hack the project if you want/need to.
* Ansible is great at mixing variables files and templating.
* On the project founder's workstation: `[ "$MY_PREFERED_TOOL" = "ansible" ]` returns `0`
