resource "aws_vpc" "jenkins" {
  cidr_block = "192.168.0.0/16" 
  
  tags = {
      Name = "Jenkins-vpc"
  }
}