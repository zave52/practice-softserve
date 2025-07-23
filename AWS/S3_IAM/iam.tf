resource "aws_iam_role" "iam_s3_replica_role" {
  name        = "${var.tag_name}-iam-s3-replica-role"
  description = "S3 replication role"

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
            "s3.amazonaws.com"
          ]
        }
      }
    ]
  })

  tags = {
    Name = "${var.tag_name}-replica"
  }
}

resource "aws_iam_policy" "iam_s3_replica_policy" {
  name        = "${var.tag_name}-iam-s3-replica-policy"
  description = "S3 replication policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObjectVersion",
          "s3:GetObjectVersionAcl",
          "s3:GetObjectVersionForReplication",
          "s3:GetObjectLegalHold",
          "s3:GetObjectVersionTagging",
          "s3:GetObjectRetention"
        ],
        Resource = [
          "${aws_s3_bucket.s3_bucket_main.arn}/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "s3:ReplicateObject",
          "s3:ReplicateDelete",
          "s3:ReplicateTags"
        ],
        Resource = [
          "${aws_s3_bucket.s3_bucket_replica.arn}/*"
        ]
      }
    ]
  })

  tags = {
    Name = "${var.tag_name}-replica"
  }
}

resource "aws_iam_role_policy_attachment" "replication_attachemt" {
  role       = aws_iam_role.iam_s3_replica_role.name
  policy_arn = aws_iam_policy.iam_s3_replica_policy.arn
}

resource "aws_iam_role" "iam_s3_role" {
  name        = "${var.tag_name}-iam-s3-ec2-role"
  description = "Allow EC2 instances to call S3 bucket"

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
    Name = "${var.tag_name}-ec2"
  }
}

resource "aws_iam_policy" "iam_s3_policy" {
  name        = "${var.tag_name}-iam-s3-ec2-policy"
  description = "Allow EC2 instances to call S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:Get*",
          "s3:List*",
        ],
        Resource = [
          aws_s3_bucket.s3_bucket_main.arn,
          "${aws_s3_bucket.s3_bucket_main.arn}/*",
          aws_s3_bucket.s3_bucket_replica.arn,
          "${aws_s3_bucket.s3_bucket_replica.arn}/*"
        ]
      }
    ]
  })

  tags = {
    Name = "${var.tag_name}-ec2"
  }
}

resource "aws_iam_role_policy_attachment" "s3_policy_attachment" {
  role       = aws_iam_role.iam_s3_role.name
  policy_arn = aws_iam_policy.iam_s3_policy.arn
}
