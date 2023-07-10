resource "aws_acm_certificate" "api" {
  domain_name       = "jenkins.anaeleboo.com"
  validation_method = "DNS"
  
}