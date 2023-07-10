resource "ansible_host" "BASTIONHOST_A" {
  inventory_hostname = "${aws_instance.bastion.public_dns}"
  groups = ["security"]
  vars = {
      ansible_user = "ubuntu"
      ansible_ssh_private_key_file="anael.pem"
      ansible_python_interpreter="/usr/bin/python3"
  }
}


resource "ansible_host" "REDIS001" {
  inventory_hostname = "${aws_instance.jenkins.private_dns}"
  groups = ["frontend"]
  vars = {
      ansible_user = "centos"
      role = "master"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i anael.pem -W %h:%p -q ubuntu@${aws_instance.bastion.public_dns}\""
      ansible_ssh_private_key_file="anael.pem"
      ansible_python_interpreter="/usr/bin/python3"
      proxy = "${aws_instance.bastion.private_ip}"
  }
}