resource "aws_s3_bucket" "remote_state_bucket" {
    bucket = var.s3_remote_state

    lifecycle {
        prevent_destroy = true
    }

}

resource "aws_s3_bucket_server_side_encryption_configuration" "remote_state_bucket" {
  depends_on = [
    aws_s3_bucket.remote_state_bucket
  ]
  bucket = aws_s3_bucket.remote_state_bucket.bucket

  rule {
      apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
      }
  }
}