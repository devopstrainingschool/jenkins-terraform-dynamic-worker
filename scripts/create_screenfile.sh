#!/bin/bash

rm -f superscreen
bastion0=`/usr/local/bin/terraform.py| jq '.security.hosts[0]'`
bastion1=`/usr/local/bin/terraform.py| jq '.security.hosts[1]'`
frontend0=`/usr/local/bin/terraform.py| jq '.frontend.hosts[0]'`
frontend1=`/usr/local/bin/terraform.py| jq '.frontend.hosts[1]'`
jenkins0=`/usr/local/bin/terraform.py| jq '.jenkins.hosts[0]'`
db1=`/usr/local/bin/terraform.py| jq '.db.hosts[1]'`

echo "screen ssh -o StrictHostKeyChecking=no -i /tmp/anael_premier.pem ubuntu@$bastion0 -t \"echo \"PS1=bastion0\"$\"\">>~/.bashrc;bash\" " >superscreen
echo "screen ssh -o StrictHostKeyChecking=no -i /tmp/anael_premier.pem ubuntu@$bastion1 -t \"echo \"PS1=bastion1\"$\"\">>~/.bashrc;bash\" " >> superscreen
echo "screen ssh -i /tmp/anael_premier.pem ubuntu@$frontend0 -o StrictHostKeyChecking=no -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/anael_premier.pem   -W %h:%p -q ubuntu@$bastion0\" -t \"echo \"PS1=frontend1\"$\"\">>~/.bashrc;bash\"" >>superscreen
echo "screen ssh -i /tmp/anael_premier.pem ubuntu@$frontend1 -o StrictHostKeyChecking=no -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/anael_premier.pem   -W %h:%p -q ubuntu@$bastion1\" -t \"echo \"PS1=frontend2\"$\"\">>~/.bashrc;bash\"" >>superscreen
echo "screen ssh -i /tmp/anael_premier.pem ubuntu@$jenkins0 -o StrictHostKeyChecking=no -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/anael_premier.pem   -W %h:%p -q ubuntu@$bastion0\" -t \"echo \"PS1=db1\"$\"\">>~/.bashrc;bash\"" >>superscreen
   

