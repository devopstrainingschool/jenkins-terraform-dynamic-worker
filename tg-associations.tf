resource "aws_lb_target_group_attachment" "tg" {
 
  depends_on = [aws_instance.jenkins]
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.jenkins.id
  port             = 8080
}