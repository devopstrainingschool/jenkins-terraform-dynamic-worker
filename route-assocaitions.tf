# ROUTE ASSOCIATION FOR IGW
resource "aws_route_table_association" "bastion" {
  subnet_id = aws_subnet.public-bastion.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "nat" {
  subnet_id = aws_subnet.nat.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "lb" {
  subnet_id = aws_subnet.public-lb.id
  route_table_id = "${aws_route_table.public.id}"
}

# ROUTE ASSOCIATION FOR NAT
resource "aws_route_table_association" "jenkins" {
  subnet_id = "${aws_subnet.jenkins.id}"
  route_table_id = "${aws_route_table.nat.id}"
}