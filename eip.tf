resource "aws_eip" "example" {
 #instance = aws_instance.web.id
  vpc      = true
}