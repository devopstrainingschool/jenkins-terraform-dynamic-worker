resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.jenkins.id
  tags = {
      Name = "igw"
  }
}