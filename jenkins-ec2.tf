resource "aws_instance" "jenkins" {
    ami = "ami-05a36e1502605b4aa"
    instance_type = "t2.2xlarge"
    iam_instance_profile = aws_iam_instance_profile.jenkins6.name
    subnet_id = "${aws_subnet.jenkins.id}"
    key_name = "${aws_key_pair.anael.key_name}"
    vpc_security_group_ids = ["${aws_security_group.jenkins.id}"]
    tags = {
        Name = "jenkins"
        sshUser = "ubuntu"
    }
}