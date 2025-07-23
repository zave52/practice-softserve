data "aws_caller_identity" "current" {}

resource "aws_secretsmanager_secret" "secret_manager" {
  name       = "${var.tag_name}-secret"
  kms_key_id = aws_kms_key.kms_key.id

  tags = {
    Name = var.tag_name
  }
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  secret_id     = aws_secretsmanager_secret.secret_manager.id
  secret_string = jsonencode(var.secret_version)
}

resource "aws_kms_key" "kms_key" {
  description             = "Kms key for encryption secret"
  enable_key_rotation     = true
  rotation_period_in_days = 365
  deletion_window_in_days = 7

  tags = {
    Name = var.tag_name
  }
}

resource "aws_kms_key_policy" "kms_key_policy" {
  key_id = aws_kms_key.kms_key.id

  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "kms_key",
    Statement = [
      {
        Sid    = "Enable IAM user permissions",
        Effect = "Allow",
        Principal = {
          "AWS" = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action   = "kms:*",
        Resource = "*"
      }
    ]
  })
}
