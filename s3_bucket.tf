resource "aws_s3_bucket" "website_bucket" {
    bucket = var.domain_name
}

resource "aws_s3_bucket_policy" "allow_public_read" {
    bucket = aws_s3_bucket.website_bucket.id
    policy = templatefile("policy/s3-policy.json", {bucket = var.domain_name})
}

resource "aws_s3_bucket_acl" "website_bucket_acl" {
    bucket = aws_s3_bucket.website_bucket.id
    acl = "public-read"
}

resource "aws_s3_bucket_website_configuration" "website_bucket_configuration" {
    bucket = aws_s3_bucket.website_bucket.bucket

    index_document {
        suffix = "index.html"
    }

    error_document {
        key = "error.html"
    }
}