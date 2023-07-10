# bastion host sg
resource "aws_security_group" "SG-bastionhosts" {
  name = "SG-bastionhosts"
  vpc_id = "${aws_vpc.main.id}"
  description = "Security group for bastion hosts"
  ingress {
      from_port = 22
      to_port = 22
      protocol = "TCP"
      cidr_blocks = "${var.mgmt_ips}"
      description = "Allow incoming SSH from management IPs"
  }

  ingress {
      from_port = -1
      to_port = -1
      protocol = "ICMP"
      cidr_blocks = "${var.mgmt_ips}"
      description = "Allow incoming ICMP from management IPs"
  }
  egress {
      from_port = 0
      to_port = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol = "-1"
      description = "Allow all outgoing traffic"
  }
  tags = {
      Name = "SG-bastionhosts"
  }
}



# DB sg 
resource "aws_security_group" "SG-jenkins" {
    name = "SG-jenkins"
    vpc_id = "${aws_vpc.main.id}"
    description = "Security group for backend servers"
    ingress {
        description      = "Jenkins port"
        from_port        = 8080
        to_port          = 8080
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"] # from anywhere
        #cidr_blocks      = [aws_vpc.terra-vpc.cidr_block] this is local to the vpc
         # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "TCP"
        security_groups = ["${aws_security_group.SG-bastionhosts.id}"]
        description = "Allow incoming SSH traffic from bastion hosts"
    }
    egress {
      from_port = 0
      to_port = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol = "-1"
      description = "Allow all outgoing traffic"
  }
    tags = {
        Name = "SG-Jenkins"
    }
}



