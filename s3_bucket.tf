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

# This was suppose to upload the website into the S3 bucket after it is made. I think we can use GitHub Actions to do that for us.
# resource "aws_s3_object" "uploadwebsite" {
#     bucket = aws_s3_bucket.website_bucket.id
#     for_each = fileset(path.module, "website/*")
#     key = each.value
#     source = "website/${each.value}"
#     etag = filemd5("website/${each.value}")
# }