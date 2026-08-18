resource "random_id" "oac_id" {
  keepers = {
    domain_name = var.domain_name
  }

  byte_length = 16
}

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = random_id.oac_id.b64_url
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name              = var.backend_fqdn
    origin_id                = var.backend_fqdn
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  default_cache_behavior {
    compress = true
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = [ "GET", "HEAD" ]
    cached_methods         = [ "GET", "HEAD" ]
    target_origin_id       = var.backend_fqdn
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

    forwarded_values {
      query_string = false
      cookies {
        forward    = "all"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = var.certificate_arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2021"
    cloudfront_default_certificate = false
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.default_root_object
  aliases             = [var.domain_name, "www.${var.domain_name}"]
}
