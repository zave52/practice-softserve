data "aws_route53_zone" "route53_zone" {
  name         = "test-domain-for-aws.pp.ua."
  private_zone = false
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.route53_zone.zone_id
  name    = "test-domain-for-aws.pp.ua"
  type    = "A"

  alias {
    name                   = aws_lb.load_balancer.dns_name
    zone_id                = aws_lb.load_balancer.zone_id
    evaluate_target_health = true
  }
}
