variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the bucket"
  type        = map(string)
  default     = {}
}

variable "index_document" {
  description = "Name of the index document for the S3 website configuration"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "Name of the error document for the S3 website configuration"
  type        = string
  default     = "error.html"
}

variable "block_public_acls" {
  description = "Block public ACLs on the bucket"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Block public bucket policies"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Ignore public ACLs on the bucket"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Restrict public bucket policies"
  type        = bool
  default     = true
}

variable "index_html_source" {
  description = "Path to the local index.html file to upload to S3"
  type        = string
}

variable "image_jpg_source" {
  description = "Path to the local image.jpg file to upload to S3"
  type        = string
}
