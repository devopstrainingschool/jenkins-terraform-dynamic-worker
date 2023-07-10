resource "aws_security_group" "lb" {
    name = "SG-loadbalancer"
    vpc_id = "${aws_vpc.jenkins.id}"
    description = "Security group for the load-balancer"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow incoming HTTP traffic from anywhere"
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow incoming HTTPS traffic from anywhere"
    }

    egress {
        from_port = 8080
        to_port = 8080
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        
    }

    tags = {
        Name = "SG-loadbalancers"
    }
}


resource "aws_security_group" "jenkins-slave" {
    name = "slave"
    vpc_id = aws_vpc.jenkins.id
    description = "Security group for jenkins-slave"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "TCP"
        security_groups = ["${aws_security_group.jenkins.id}"]
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
        Name = "slave"
    }
    
}

resource "aws_security_group" "bastion" {
  name = "SG-bastionhosts"
  vpc_id = aws_vpc.jenkins.id
  description = "Security group for bastion hosts"
  ingress {
      from_port = 22
      to_port = 22
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow incoming SSH from management IPs"
  }

 
  egress {
      from_port = 22
      to_port = 22
      cidr_blocks = ["0.0.0.0/0"]
      protocol = "TCP"
      description = "Allow ssh outgoing traffic to jenkins"
  }
  tags = {
      Name = "SG-bastionhosts"
  }
}

resource "aws_security_group" "jenkins" {
    name = "SG-web"
    vpc_id = aws_vpc.jenkins.id
    description = "Security group for jenkins"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "TCP"
        security_groups = ["${aws_security_group.bastion.id}"]
        description = "Allow incoming SSH traffic from bastion hosts"
    }
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "TCP"
       # cidr_blocks = ["0.0.0.0/0"]
        security_groups = ["${aws_security_group.lb.id}"]
        description = "Allow incoming tcp from LB"
    }
    
    egress {
      from_port = 0
      to_port = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol = "-1"
      description = "Allow all outgoing traffic"
  }
    tags = {
        Name = "jenkins-sg"
    }
    
}