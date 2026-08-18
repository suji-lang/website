module "backend" {
  source = "./modules/backend"
  domain_name = var.domain_name
  web_assets_path = var.web_assets_path
}

module "x509" {
  source = "./modules/x509"
  domain_name = var.domain_name
  subject_alternative_names  = ["www.${var.domain_name}"]
}

module "x509_validator" {
  source = "./modules/x509_validator"
  domain_name = var.domain_name
  domain_validation_options = module.x509.domain_validation_options
  certificate_arn = module.x509.cert_arn
}

module "cdn" {
  source = "./modules/cdn"
  domain_name = var.domain_name
  backend_fqdn = module.backend.backend_fqdn
  certificate_arn = module.x509.cert_arn
  depends_on = [ module.x509_validator ]
}

module "dns" {
  source = "./modules/dns"
  domain_name = var.domain_name
  cdn_domain_name = module.cdn.cdn_domain_name
  cdn_zone_id = module.cdn.cdn_hosted_zone_id
  depends_on = [ module.cdn ]
}
