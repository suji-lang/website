resource "random_id" "bucket_id" {
  keepers = {
    domain_name = var.domain_name
  }

  byte_length = 8
}

resource "aws_s3_bucket" "backend" {
  bucket        = lower(replace("${var.domain_name}-${random_id.bucket_id.b64_url}", "_", "-"))
  force_destroy = true
}

locals {
  web_assets = toset([
    for f in fileset("${var.web_assets_path}", "**/*") : f
    if !endswith(f, ".swp") && !endswith(f, ".DS_Store") && !endswith(f, ".nojekyll") && !endswith(f, "SOURCE.txt")
  ])
}

resource "aws_s3_object" "upload_assets" {
  for_each     = local.web_assets
  bucket       = aws_s3_bucket.backend.bucket
  key          = each.value
  source       = "${var.web_assets_path}/${each.value}"
  etag         = filemd5("${var.web_assets_path}/${each.value}")
  content_type = lookup(var.mime_types, regex("\\.[^.]+$", each.value), "application/octet-stream")
}
