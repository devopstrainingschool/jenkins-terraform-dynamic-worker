
resource "aws_acm_certificate_validation" "api" {
  certificate_arn         = aws_acm_certificate.api.arn
 validation_record_fqdns = [for record in aws_route53_record.api_validation : record.fqdn]
}