# Create the S3 bucket
resource "aws_s3_bucket" "website" {
  bucket = "my-signup-login-website"
  # Other bucket configurations here, if needed
}

# Configure public access block settings for the S3 bucket
resource "aws_s3_bucket_public_access_block" "website_public_access_block" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = false
  ignore_public_acls       = false
  block_public_policy      = false
  restrict_public_buckets  = false
}

# Configure website settings for the S3 bucket
resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "signup.html"
  }

  error_document {
    key = "signup.html"
  }
}

# Upload the signup page to S3
resource "aws_s3_object" "signup_page" {
  bucket = aws_s3_bucket.website.bucket
  key    = "signup.html"
  source = "C:/Users/Idan Uziel/Desktop/s3dynamodb/signup.html"  # Ensure this path is correct
  content_type = "text/html"
}

# Upload the login page to S3
resource "aws_s3_object" "login_page" {
  bucket = aws_s3_bucket.website.bucket
  key    = "login.html"
  source = "C:/Users/Idan Uziel/Desktop/s3dynamodb/login.html"  # Ensure this path is correct
  content_type = "text/html"
}

# Define the S3 bucket policy
resource "aws_s3_bucket_policy" "website_policy" {
  bucket = aws_s3_bucket.website.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.website.arn}/*"
      }
    ]
  })
}
