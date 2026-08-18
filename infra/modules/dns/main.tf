data "aws_route53_zone" "domain_name" {
  name = var.domain_name
}

resource "aws_route53_record" "domain_name" {
  zone_id = data.aws_route53_zone.domain_name.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.cdn_domain_name
    zone_id                = var.cdn_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_domain_name" {
  zone_id = data.aws_route53_zone.domain_name.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.cdn_domain_name
    zone_id                = var.cdn_zone_id
    evaluate_target_health = false
  }
}
