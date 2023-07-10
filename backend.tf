terraform {
  backend "s3" {
    bucket  = "devopsschool"
    key     = "jenkins/terraform.tfstate"
    region  = "us-east-2"
   
  }
}