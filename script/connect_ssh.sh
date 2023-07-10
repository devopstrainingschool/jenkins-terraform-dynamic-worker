#!/usr/local/bin/bash  

# Script to connect to one or all amazon ec2 hosts in this play
# This only works on Mac currently!

# Source the code that generates seperate terminal windows
. scripts/new_window.sh

# Define the hosts
declare -A cluster_hosts

inventory=`/usr/local/bin/terraform.py`
cluster_hosts=( ["bastion0"]=`echo $inventory | jq '.security.hosts[0]'` \
["bastion1"]=`echo $inventory | jq '.security.hosts[1]'` \
["frontend0"]=`echo $inventory | jq '.frontend.hosts[0]'` \
["frontend1"]=`echo $inventory | jq '.frontend.hosts[1]'`) 

function connect_to_host  {

    host_code=$1
    ssh_host=$2
    platform=$3

    echo "Connecting to $host_code - $ssh_host  "

    if [[ $platform == "linux" ]]
    then
          #If host is a bastion host we use a different connection method 
        if [[ $host_code =~ ^bastion[0-9]+$ ]]
        then
            screen ssh -o StrictHostKeyChecking=no -i anael.pem ubuntu@$ssh_host -t "echo "PS1=$host_code"$"">>~/.bashrc;bash" 
        else
            screen ssh -i anael.pem ubuntu@"$ssh_host" -o StrictHostKeyChecking=no -o ProxyCommand="ssh -o StrictHostKeyChecking=no -i anael.pem   -W %h:%p -q ubuntu@"${cluster_hosts['bastion1']}"" -t "echo "PS1=$host_code"$"">>~/.bashrc;bash"
        fi
    else

        #If host is a bastion host we use a different connection method 
        if [[ $host_code =~ ^bastion[0-9]+$ ]]
        then

            new_window "ssh -o StrictHostKeyChecking=no -i anael.pem ubuntu@$ssh_host -t \"echo \"PS1=$host_code\"$\"\">>~/.bashrc;bash\" "

        else

            new_window "ssh -i anael.pem ubuntu@$ssh_host -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i anael.pem   -W %h:%p -q ubuntu@${cluster_hosts['bastion1']}\" -t \"echo \"PS1=$\"$host_code\"\">>~/.bashrc;bash\""

        fi

    fi

}

# Main 

# Usage if no args
if [[ $# -eq 0 ]] ; then
    echo 'Usage: connect_ssh all OR connect_ssh [hostcode] OR connect_ssh show_host_codes'
    exit 0
fi

# Iterate input args
case "$1" in

    "all") for host in "${!cluster_hosts[@]}"; do connect_to_host $host ${cluster_hosts[$host]} mac; done;;
    "linux-all") connect_to_host $host ${cluster_hosts[$host]} linux;;
    "show_host_codes") for host in "${!cluster_hosts[@]}"; do echo "hostcode: $host -- hostname: ${cluster_hosts[$host]}"; done;;
    *) connect_to_host $1 ${cluster_hosts[$1]} linux;;

esac