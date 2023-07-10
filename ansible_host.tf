# This create dynamic ansible inventory using groups as key for ansible hosts
resource "ansible_host" "BASTIONHOST_A" {
  inventory_hostname = "${aws_instance.BASTIONHOST_A.public_dns}"
  groups = ["security"]
  vars = {
      ansible_user = "ubuntu"
      ansible_ssh_private_key_file="/tmp/anael_premier.pem"
      ansible_python_interpreter="/usr/bin/python3"
  }
}

resource "ansible_host" "BASTIONHOST_B" {
  inventory_hostname = "${aws_instance.BASTIONHOST_B.public_dns}"
  groups = ["security"]
  vars = {
      ansible_user = "centos"
      ansible_ssh_private_key_file="/tmp/anael_premier.pem"
      ansible_python_interpreter="/usr/bin/python3"
  }
}

resource "ansible_host" "FRONTEND001" {
  inventory_hostname = "${aws_instance.WEB_A.private_dns}"
  groups = ["frontend"]
  vars = {
      ansible_user = "ubuntu"
      role = "master"
      ansible_ssh_private_key_file="/tmp/anael_premier.pem"
      ansible_python_interpreter="/usr/bin/python3"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/anael_premier.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOST_A.public_dns}\""
      proxy = "${aws_instance.BASTIONHOST_A.private_ip}"
      subnet = "${aws_subnet.private-web.cidr_block}"
  }
}
resource "ansible_host" "FRONTEND002" {
  inventory_hostname = "${aws_instance.WEB_B.private_dns}"
  groups = ["frontend"]
  vars = {
      ansible_user = "centos"
      role = "master"
      ansible_ssh_private_key_file="/tmp/anael_premier.pem"
      ansible_python_interpreter="/usr/bin/python3"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/anael_premier.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOST_B.public_dns}\""
      proxy = "${aws_instance.BASTIONHOST_B.private_ip}"
      subnet = "${aws_subnet.private-web.cidr_block}"
  }
}

resource "ansible_host" "FRONTEND003" {
  inventory_hostname = "${aws_instance.WEB_C.private_dns}"
  groups = ["frontend"]
  vars = {
      ansible_user = "ubuntu"
      role = "master"
      ansible_ssh_private_key_file="/tmp/anael_premier.pem"
      ansible_python_interpreter="/usr/bin/python3"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/anael_premier.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOST_A.public_dns}\""
      proxy = "${aws_instance.BASTIONHOST_A.private_ip}"
      subnet = "${aws_subnet.private-web.cidr_block}"
  }
}

resource "ansible_host" "SQL001" {
  inventory_hostname = "${aws_instance.SQL_A.private_dns}"
  groups = ["db"]
  vars = {
      ansible_user = "ubuntu"
      role = "master"
      ansible_ssh_common_args= " -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i /tmp/anael_premier.pem -W %h:%p -q ubuntu@${aws_instance.BASTIONHOST_B.public_dns}\""
      ansible_ssh_private_key_file="/tmp/anael_premier.pem"
      ansible_python_interpreter="/usr/bin/python3"
      proxy = "${aws_instance.BASTIONHOST_B.private_ip}"
      subnet = "${aws_subnet.private-db.cidr_block}"
  }
}