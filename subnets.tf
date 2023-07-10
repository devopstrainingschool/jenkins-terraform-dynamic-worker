# bastion host subnet
resource "aws_subnet" "public-bastion" {
  availability_zone = "us-east-2a"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  vpc_id = "${aws_vpc.main.id}"
  tags = {
      Name = "Subnet-bastion1"
  }
}
# Nat subnet
resource "aws_subnet" "public-nat" {
  availability_zone = "us-east-2c"
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  vpc_id = "${aws_vpc.main.id}"
  tags = {
      Name = "Subnet-nat"
  }


# DB subnet
resource "aws_subnet" "jenkins" {
  availability_zone = "us-east-2b"
  cidr_block = "10.0.11.0/24"
  map_public_ip_on_launch = false
  vpc_id = "${aws_vpc.main.id}"
  tags = {
      Name = "Subnet-db"
  }
}

# LB subnet
resource "aws_subnet" "public-lb" {
  availability_zone = "us-east-2b"
  cidr_block = "10.0.5.0/24"
  map_public_ip_on_launch = true
  vpc_id = "${aws_vpc.main.id}"
  tags = {
      Name = "Subnet-lb"
  }
}