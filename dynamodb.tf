resource "aws_dynamodb_table" "dynamodb_table" {
  name           = "visitor-count"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "Primary Key"

  attribute {
    name = "Primary Key"
    type = "N"
  }

  tags = {
    Name        = var.tag_name
    Environment = "production"
  }
}