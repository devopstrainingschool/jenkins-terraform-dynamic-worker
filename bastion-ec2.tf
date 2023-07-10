resource "aws_instance" "bastion" {
    ami = "ami-05a36e1502605b4aa"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.public-bastion.id}"
    #key_name = aws_key_pair.anael.key_name
    key_name = "anael1"
    associate_public_ip_address = "true"
    vpc_security_group_ids = ["${aws_security_group.bastion.id}"]
    provisioner "file" {
        source      = "anael.pem"
        destination = "anael.pem"
      }
    provisioner "remote-exec"  {
    inline  = [
      "sudo chmod 400 anael.pem ",
    
      ]
   }
    connection {
    type         = "ssh"
    host         = self.public_ip
    user         = "centos" # change user"ec2-user" for amz
    timeout = "2m"
    agent = false
    private_key  = tls_private_key.anael.private_key_pem #"${file("anael.pem")}" 
   }
  depends_on = [
    aws_key_pair.anael
  ]
    tags = {
        Name = "Batsion-ec2"
       
    }
}