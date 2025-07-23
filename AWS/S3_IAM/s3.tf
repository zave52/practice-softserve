resource "aws_s3_bucket" "s3_bucket_main" {
  bucket        = "${var.s3_bucket_name}-main"
  force_destroy = true

  tags = {
    Name = "${var.tag_name}-main"
  }
}

resource "aws_s3_bucket_versioning" "s3_main_versioning" {
  bucket = aws_s3_bucket.s3_bucket_main.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "s3_bucket_replica" {
  bucket        = "${var.s3_bucket_name}-replica"
  force_destroy = true

  tags = {
    Name = "${var.tag_name}-replica"
  }
}

resource "aws_s3_bucket_versioning" "s3_replica_versioning" {
  bucket = aws_s3_bucket.s3_bucket_replica.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_object" "main_s3_bucket_object" {
  bucket = aws_s3_bucket.s3_bucket_main.bucket
  key    = var.s3_bucket_object_name
  source = var.s3_bucket_object_path
}

resource "aws_s3_bucket_replication_configuration" "replication" {
  bucket = aws_s3_bucket.s3_bucket_main.id
  role   = aws_iam_role.iam_s3_replica_role.arn

  rule {
    id     = "replication-rule"
    status = "Enabled"

    filter {
      prefix = ""
    }

    destination {
      bucket        = aws_s3_bucket.s3_bucket_replica.arn
      storage_class = "STANDARD"
    }

    delete_marker_replication {
      status = "Enabled"
    }
  }
}

resource "aws_s3_bucket" "s3_bucket_website" {
  bucket = "${var.s3_bucket_name}-website"

  tags = {
    Name = "${var.s3_bucket_name}-website"
  }
}

resource "aws_s3_bucket_website_configuration" "s3_website_conguration" {
  bucket = aws_s3_bucket.s3_bucket_website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_public_access" {
  bucket = aws_s3_bucket.s3_bucket_website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "s3_policy" {
  bucket = aws_s3_bucket.s3_bucket_website.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.s3_bucket_website.arn}/*"
      }
    ]
  })
}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.s3_bucket_website.id
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "error_html" {
  bucket       = aws_s3_bucket.s3_bucket_website.id
  key          = "error.html"
  source       = "error.html"
  content_type = "text/html"
}
