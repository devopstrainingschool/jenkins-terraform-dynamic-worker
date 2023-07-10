terraform {
  required_providers {
     ansible = {
      source = "nbering/ansible"
    }
    
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.54.0"
    }
  }
}
provider "aws" {
    region  = "us-east-2"
}