resource "aws_iam_instance_profile" "jenkins" {
  name = "profile"
  role = "jenkins-role"
}