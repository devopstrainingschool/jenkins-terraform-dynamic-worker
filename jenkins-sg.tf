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