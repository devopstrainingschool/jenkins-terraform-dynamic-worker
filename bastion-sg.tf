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