resource "aws_instance" "bastion" {
    ami = "ami-05a36e1502605b4aa"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.public-bastion.id}"
    key_name = aws_key_pair.anael.key_name
    #key_name = "anael1"
    associate_public_ip_address = "true"
    vpc_security_group_ids = ["${aws_security_group.bastion.id}"]
    tags = {
        Name = "Batsion-ec2"
       
    }
}