resource "aws_cloudfront_distribution" "s3_distribution" {
    depends_on = [
        aws_s3_bucket.website_bucket
    ]
    origin {
        domain_name = aws_s3_bucket.website_bucket.bucket_regional_domain_name
        origin_id = aws_s3_bucket.website_bucket.id
    }

    enabled = true
    is_ipv6_enabled = true
    comment = "SSL for the website"
    default_root_object = "index.html"

    aliases = [var.domain_name, "*.${var.domain_name}"]

    default_cache_behavior {
        allowed_methods = ["GET", "HEAD"]
        cached_methods = ["GET", "HEAD"]
        target_origin_id = aws_s3_bucket.website_bucket.id

        forwarded_values {
            query_string = false

            cookies {
                forward = "none"
            }
        }

        viewer_protocol_policy = "redirect-to-https"
        min_ttl = 0
        default_ttl = 3600
        max_ttl = 86400
    }

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }
    viewer_certificate {
        acm_certificate_arn = aws_acm_certificate_validation.cert_validation.certificate_arn
        ssl_support_method = "sni-only"
    }

}