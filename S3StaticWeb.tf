resource "aws_s3_bucket" "Static_website" {
  bucket = "faizulstaticwebsit"
}

output "s3bucket" {
  value = aws_s3_bucket.Static_website.id
}

resource "aws_s3_bucket_public_access_block" "PublicAccess" {
  bucket = aws_s3_bucket.Static_website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

}

resource "aws_s3_bucket_policy" "Staticweb" {
  bucket = aws_s3_bucket.Static_website.id

  policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Sid       = "PublicRead"
          Effect    = "Allow"
          Principal = "*"
          Action    = ["s3:GetObject"]
          Resource  = "${aws_s3_bucket.Static_website.arn}/*"
        }
      ]
  })
}

resource "aws_s3_bucket_website_configuration" "Static_website" {
  bucket = aws_s3_bucket.Static_website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.Static_website.id
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "error_html" {
  bucket       = aws_s3_bucket.Static_website.id
  key          = "error.html"
  source       = "error.html"
  content_type = "text/html"
}