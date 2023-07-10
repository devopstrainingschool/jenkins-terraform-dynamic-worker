resource "aws_route_table_association" "public-bastion" {
  subnet_id = aws_subnet.public-bastion.id
  route_table_id = aws_route_table.default.id
}

resource "aws_route_table_association" "public-nat" {
  subnet_id = aws_subnet.public-nat.id
  route_table_id = aws_route_table.default.id
}

# No need to define local route since it is there by default

# For NAT association
resource "aws_route_table_association" "nat-web" {
  subnet_id = aws_subnet.private-web.id
  route_table_id = aws_route_table.nat.id
}

resource "aws_route_table_association" "nat-db" {
  subnet_id = aws_subnet.private-db.id
  route_table_id = aws_route_table.nat.id
}