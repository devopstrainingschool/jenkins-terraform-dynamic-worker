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