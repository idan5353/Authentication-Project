# S3 Bucket for Lambda Code
resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "my-lambda-bucket-535"
}

# Upload Lambda Deployment Package to S3
resource "aws_s3_object" "lambda_code" {
  bucket = aws_s3_bucket.lambda_bucket.bucket
  key    = "app-py.zip"
  source = "C:/Users/Idan Uziel/Desktop/app-py.zip"  # Ensure this path is correct
}

# IAM Role for Lambda Execution
resource "aws_iam_role" "lambda_execution" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com",
        },
      },
    ],
  })
}

# IAM Policy for Lambda Function (DynamoDB and CloudWatch Logs)
resource "aws_iam_policy" "lambda_full_policy" {
  name        = "lambda_full_policy"
  description = "Policy to allow Lambda function access to DynamoDB and CloudWatch Logs"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:GetItem",
          "dynamodb:Scan",
          "dynamodb:Query"
        ],
        Resource = "arn:aws:dynamodb:us-west-2:851725642392:table/example-table"  # Replace with your actual DynamoDB table ARN
      },
      {
        Effect   = "Allow",
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

# Attach Policy to IAM Role
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_execution.name
  policy_arn  = aws_iam_policy.lambda_full_policy.arn
}

# Lambda Function
resource "aws_lambda_function" "my_lambda_function" {
  function_name = "my_lambda_function"
  s3_bucket     = aws_s3_bucket.lambda_bucket.bucket
  s3_key        = aws_s3_object.lambda_code.key
  handler       = "lambda_function.lambda_handler"  # Update if handler is different
  runtime       = "python3.9"  # Consider using the latest runtime if available
  role          = aws_iam_role.lambda_execution.arn
}
