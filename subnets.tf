resource "aws_subnet" "public-bastion" {
  availability_zone = "us-east-2a"
  cidr_block = "192.168.1.0/24"
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.jenkins.id
  tags = {
      Name = "bastion-subnet"
  }
}
  resource "aws_subnet" "public-lb" {
  availability_zone = "us-east-2b"
  cidr_block = "192.168.2.0/24"
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.jenkins.id
  tags = {
      Name = "lb-subnet"
  }
  }

  resource "aws_subnet" "nat" {
  availability_zone = "us-east-2c"
  cidr_block = "192.168.3.0/24"
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.jenkins.id
  tags = {
      Name = "nat-subnet"
  }
  }
  resource "aws_subnet" "jenkins" {
  availability_zone = "us-east-2b"
  cidr_block = "192.168.4.0/24"
  map_public_ip_on_launch = false
  vpc_id = aws_vpc.jenkins.id
  tags = {
      Name = "jenkins-subnet"
  }
  }