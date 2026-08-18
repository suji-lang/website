output "backend_fqdn" {
  value = aws_s3_bucket.backend.bucket_regional_domain_name
}

output "backend_bucket_id" {
  value = aws_s3_bucket.backend.id
}

output "backend_bucket_arn" {
  value = aws_s3_bucket.backend.arn
}
