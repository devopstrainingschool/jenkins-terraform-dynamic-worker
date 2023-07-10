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


# Web sg 
resource "aws_security_group" "SG-frontendservers" {
    name = "SG-web"
    vpc_id = "${aws_vpc.main.id}"
    description = "Security group for web"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "TCP"
        security_groups = ["${aws_security_group.SG-bastionhosts.id}"]
        description = "Allow incoming SSH traffic from bastion hosts"
    }
    ingress {
        from_port = 80
        to_port = 80
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
        Name = "SG-web"
    }
}

# DB sg 
resource "aws_security_group" "SG-backendservers" {
    name = "SG-backendservers"
    vpc_id = "${aws_vpc.main.id}"
    description = "Security group for backend servers"
    ingress {
        from_port = 6432
        to_port = 6432
        protocol = "TCP"
        security_groups = ["${aws_security_group.SG-frontendservers.id}"]
        description = "Allow incoming PostgreSQL traffic from web servers"
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
        Name = "SG-db"
    }
}


# NAT SG
