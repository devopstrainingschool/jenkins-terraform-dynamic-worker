# PUBLIC ROUTE 
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.jenkins.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
      Name = "Public route table"
  }
}

