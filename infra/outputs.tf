output "cdn_id" {
  value = module.cdn.cdn_id
}

output "cdn_domain_name" {
  value = module.cdn.cdn_domain_name
}

output "website_urls" {
  value = [
    "https://${var.domain_name}",
    "https://www.${var.domain_name}",
  ]
}
