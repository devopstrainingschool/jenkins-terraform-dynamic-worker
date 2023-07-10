resource "aws_lb" "lb" {
  name               = "my-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]

  # access_logs {
  #   bucket  = "my-logs"
  #   prefix  = "my-app-lb"
  #   enabled = true
  # }
  # adding the next line only for scalling or autoscalling
  
  subnets = [
    aws_subnet.public-bastion.id,
    aws_subnet.public-lb.id,
    aws_subnet.nat.id
  ]
  depends_on = [aws_instance.jenkins]
}