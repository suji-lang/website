variable "domain_name" {
  type = string
}

variable "web_assets_path" {
  type = string
}

variable "mime_types" {
  description = "Map of file extensions to MIME types"
  type        = map(string)
  default = {
    ".html" = "text/html"
    ".css"  = "text/css"
    ".txt"  = "text/plain"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".pdf"  = "application/pdf"
    ".json" = "application/json"
    ".js"   = "application/javascript"
    ".gif"  = "image/gif"
  }
}
