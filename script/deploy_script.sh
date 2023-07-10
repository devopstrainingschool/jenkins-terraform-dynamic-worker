#!/bin/bash
terraform init
terraform apply --auto-approve

sleep 120

terraform output  -json|jq .mykey.value -r >anael.pem && chmod 600 anael.pem

export ANSIBLE_HOST_KEY_CHECKING=false

ansible-playbook -i /usr/local/bin/terraform.py deploy/jenkins.yml
