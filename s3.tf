resource "aws_s3_bucket" "developer-api-dr" {
  bucket = "developer-api-dr"
  acl    = "private"

  tags = {
    Name        = "developer-api-dr"
    Environment = "Prod-dr"
  }
}
resource "aws_s3_bucket_policy" "developer-api-dr-policy" {
  bucket = aws_s3_bucket.developer-api-dr.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression's result to valid JSON syntax.
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Id": "AWSConsole-AccessLogs-Policy-1493628798357",
    "Statement": [
        {
            "Sid": "AWSConsoleStmt-1493628798357",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::127311923021:root"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::developer-api-dr/AWSLogs/445819549122/*"
        }
    ]
}
EOF  
}