# bastion host VM
resource "aws_instance" "BASTIONHOST_A" {
    ami = "${lookup(var.aws_ubuntu_amis,var.region)}"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public-bastion.id
    key_name = aws_key_pair.keypair.key_name
    vpc_security_group_ids = ["${aws_security_group.SG-bastionhosts.id}"]
    provisioner "file" {
        source      = "anael_premier.pem"
        destination = "/tmp/anael_premier.pem"
      }
    provisioner "remote-exec"  {
    inline  = [
      "sudo chmod 400 /tmp/anael_premier.pem ",
    
      ]
   }
    connection {
    type         = "ssh"
    host         = self.public_ip
    user         = "ubuntu" # change user"ec2-user" for amz
    timeout = "2m"
    agent = false
    private_key  = tls_private_key.mykey.private_key_pem #"${file("anael.pem")}" 
   }
  depends_on = [
    aws_key_pair.keypair
  ]
    tags = {
        Name = "${var.environment}-BASTION001"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
}

resource "aws_instance" "SQL_A" {
    ami = "${lookup(var.aws_ubuntu_amis,var.region)}"
    instance_type = "t2.large"
    subnet_id = "${aws_subnet.private-db.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.SG-backendservers.id}"]
    tags = {
        Name = "${var.environment}-SQL001"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
}