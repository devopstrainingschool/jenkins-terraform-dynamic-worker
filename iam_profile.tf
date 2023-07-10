resource "aws_iam_instance_profile" "jenkins5" {
  name = "profile5"
  role = "jenkins-aws-role"
}