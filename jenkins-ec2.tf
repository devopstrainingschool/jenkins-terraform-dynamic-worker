resource "aws_instance" "SQL_A" {
    ami = "${lookup(var.aws_ubuntu_amis,var.region)}"
    instance_type = "t2.large"
    subnet_id = "${aws_subnet.public-backend-az-a.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.SG-backendservers.id}"]
    tags = {
        Name = "${var.environment}-SQL001"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
}