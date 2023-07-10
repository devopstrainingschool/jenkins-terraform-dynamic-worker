resource "aws_route_table" "default" {
  vpc_id = "${aws_vpc.main.id}"

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.internet_gateway.id}"
  }

  tags = {
      Name = "Default route table to internet"
  }
}

# No need to define local route since it is there by default
# Next route through NAT
resource "aws_route_table" "nat" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
   tags = {
      Name = "Default route table to NAT"
  }
}