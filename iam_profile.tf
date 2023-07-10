resource "aws_iam_instance_profile" "jenkins6" {
  name = "profile6"
  role = "jenkins-aws-role"
}