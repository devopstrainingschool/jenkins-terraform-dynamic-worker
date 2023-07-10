resource "ansible_host" "BASTIONHOSTA" {
  inventory_hostname = "${aws_instance.bastion.public_dns}"
  groups = ["bastion"]
  vars = {
      ansible_user = "centos"
      ansible_ssh_private_key_file="anael.pem"
      ansible_python_interpreter="/usr/bin/python3"
  }
}

resource "ansible_host" "FRONTEND001" {
  inventory_hostname = "${aws_instance.jenkins.private_dns}"
  groups = ["Frontend"]
  vars = {
      ansible_user = "centos"
      role = "slave"
      ansible_ssh_private_key_file="anael.pem"
      ansible_python_interpreter="/usr/bin/python3"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i anael.pem -W %h:%p -q centos@${aws_instance.bastion.public_dns}\""
      proxy = "${aws_instance.bastion.private_ip}"
      subnet = "${aws_subnet.public-bastion.cidr_block}"
  }
}