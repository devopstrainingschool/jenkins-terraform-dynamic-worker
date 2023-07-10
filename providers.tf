
provider "aws" {
    region  = "us-east-2"
}
terraform {
  required_providers {
    ansible = {
      source = "nbering/ansible"
      version = "1.0.4"
    }
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0.0"
    }
  }
}

provider "ansible" {}