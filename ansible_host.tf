# This create dynamic ansible inventory using groups as key for ansible hosts
resource "ansible_host" "BASTIONHOST_A" {
  inventory_hostname = "${aws_instance.BASTIONHOST_A.public_dns}"
  groups = ["security"]
  vars = {
      ansible_user = "centos"
      ansible_ssh_private_key_file="/tmp/anael.pem"
      ansible_python_interpreter="/usr/bin/python3"
  }
}

resource "ansible_host" "jenkins" {
  inventory_hostname = "${aws_instance.jenkins.private_dns}"
  groups = ["jenkins"]
  vars = {
      ansible_user = "centos"
      role = "master"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/anael.pem -W %h:%p -q centos@${aws_instance.BASTIONHOST_A.public_dns}\""
      ansible_ssh_private_key_file="/tmp/anael.pem"
      ansible_python_interpreter="/usr/bin/python3"
      proxy = "${aws_instance.BASTIONHOST_A.private_ip}"
      subnet = "${aws_subnet.jenkins.cidr_block}"
  }
}