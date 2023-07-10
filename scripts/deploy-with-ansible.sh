#!/bin/bash
terraform init
terraform apply --auto-approve

sleep 120

terraform output  -json|jq .mykey.value -r >/tmp/anael_premier.pem && chmod 600 /tmp/anael_premier.pem

export ANSIBLE_HOST_KEY_CHECKING=false

ansible-playbook -i /usr/local/bin/terraform.py deploy/install-bastion-hosts.yml # && sleep 120 &&  \
#ansible-playbook -i /usr/local/bin/terraform.py deploy/install-postgres-core.yml  && \
#ansible-playbook -i /usr/local/bin/terraform.py deploy/install-postgres-slaves.yml  && \
#ansible-playbook -i /usr/local/bin/terraform.py deploy/install-consul.yml  && \
#ansible-playbook -i /usr/local/bin/terraform.py deploy/install-pgbouncer.yml && \
#ansible-playbook -i /usr/local/bin/terraform.py deploy/install-redis.yml && \
#ansible-playbook -i /usr/local/bin/terraform.py deploy/install-nfs.yml && \
#ansible-playbook -i /usr/local/bin/terraform.py deploy/install-gitlab.yml 
