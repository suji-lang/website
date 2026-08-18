variable "default_root_object" {
  type    = string
  default = "index.html"
}

variable "domain_name" {
  type = string
}

variable "backend_fqdn" {
  type = string
}

variable "backend_bucket_id" {
  type = string
}

variable "backend_bucket_arn" {
  type = string
}

variable "certificate_arn" {
  type = string
}
