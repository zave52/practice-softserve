resource "aws_iam_role" "iam_secretmanager_role" {
  name        = "${var.tag_name}-iam-secretmanager-role"
  description = "Allow EC2 instances to call Secret Manager"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "sts:AssumeRole"
        ],
        Principal = {
          Service = [
            "ec2.amazonaws.com"
          ]
        }
      }
    ]
  })

  tags = {
    Name = var.tag_name
  }
}

resource "aws_iam_policy" "iam_secretmanager_policy" {
  name        = "${var.tag_name}-iam-secretmanager-policy"
  description = "Allow EC2 instances to call Secret Manager"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds"
        ],
        Resource = [
          aws_secretsmanager_secret.secret_manager.arn,
          "${aws_secretsmanager_secret.secret_manager.arn}/*",
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "kms:Decrypt",
          "kms:GenerateDataKey"
        ],
        Resource = [
          aws_kms_key.kms_key.arn,
          "${aws_kms_key.kms_key.arn}/*",
        ]
      }
    ]
  })

  tags = {
    Name = var.tag_name
  }
}

resource "aws_iam_role_policy_attachment" "secretmanager_policy_attachment" {
  role       = aws_iam_role.iam_secretmanager_role.name
  policy_arn = aws_iam_policy.iam_secretmanager_policy.arn
}
