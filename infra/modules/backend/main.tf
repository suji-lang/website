resource "random_id" "bucket_id" {
  keepers = {
    domain_name = var.domain_name
  }

  byte_length = 8
}

resource "aws_s3_bucket" "backend" {
  bucket = lower(replace("${var.domain_name}-${random_id.bucket_id.b64_url}", "_", "-"))
  force_destroy = true
}

resource "aws_s3_object" "upload_assets" {
  for_each = fileset("${var.web_assets_path}", "**/*")
  bucket = aws_s3_bucket.backend.bucket
  key = each.value
  source = "${var.web_assets_path}/${each.value}"
  content_type = lookup(var.mime_types, regex("\\.[^.]+$", each.value), "application/octet-stream")
}

resource "aws_s3_bucket_policy" "cloudfront_oac_policy" {
  bucket = aws_s3_bucket.backend.bucket
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "AllowCloudFrontServicePrincipal",
        Effect = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action = "s3:GetObject",
        Resource = "${aws_s3_bucket.backend.arn}/*",
        Condition = {
          StringLike = {
            "aws:UserAgent" = "Amazon CloudFront"
          }
        }
      }
    ]
  })
}
