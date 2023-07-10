resource "aws_instance" "FRONTEND_A" {
    ami = "${lookup(var.aws_ubuntu_amis,var.region)}"
    subnet_id = "${aws_subnet.public-frontend_az-a.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.SG-frontendservers.id}"]
    instance_type = "t2.medium"
    tags = {
        Name = "${var.environment}-FRONTEND001"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
}