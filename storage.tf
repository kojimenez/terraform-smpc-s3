# S3 Bucket
resource "aws_s3_bucket" "input" {
  bucket = "smpc-${var.environment}-bucket"

  tags = {
    Name        = "smpc-${var.environment}-bucket"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "input" {
  bucket = aws_s3_bucket.input.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "input" {
  bucket = aws_s3_bucket.input.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}