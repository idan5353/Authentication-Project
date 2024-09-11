output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.my_lambda_function.arn
}

output "api_gateway_url" {
  description = "URL of the API Gateway"
  value       = "https://${aws_api_gateway_rest_api.auth_api.id}.execute-api.${var.region}.amazonaws.com/v1"
}

output "s3_website_url" {
  description = "URL of the S3 static website"
  value       = "http://${aws_s3_bucket.website.bucket}.s3-website-${var.region}.amazonaws.com"
}
