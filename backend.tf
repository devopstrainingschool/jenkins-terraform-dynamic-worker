terraform {
  backend "s3" {
    bucket = "devopstrainingschool"
    key    = "3tier/terraform.tfstate"
    region = "us-east-2"
  }
}
