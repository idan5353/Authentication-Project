# Authentication API with AWS Lambda and API Gateway

This project provides a simple authentication API using AWS Lambda and API Gateway. The API supports user signup and login functionalities with integration to Amazon DynamoDB for data storage.

## Project Components

- **AWS Lambda**: Handles the business logic for user signup and login.
- **API Gateway**: Manages API endpoints and routes requests to the Lambda function.
- **DynamoDB**: Stores user credentials (username and password).
- **HTML Frontend**: Provides a basic interface for user signup and login.

## Architecture

1. **API Gateway**:
   - Defines RESTful endpoints for user authentication.
   - Handles CORS configuration to allow requests from any origin.
   - Integrates with the Lambda function to process user requests.

2. **Lambda Function**:
   - Implements `signup` and `login` functionality.
   - Interacts with DynamoDB to store and retrieve user credentials.
   - Returns appropriate responses based on the request outcome.

3. **DynamoDB**:
   - Stores user credentials in a table.

4. **Frontend**:
   - A simple HTML form for user interaction.
   - JavaScript code to send API requests and display results.

## Deployment

1. **Infrastructure**:
   - Use Terraform to define and deploy the AWS infrastructure, including API Gateway, Lambda function, and DynamoDB table.
   - Ensure API Gateway methods are properly set up and integrated with the Lambda function.

2. **API Configuration**:
   - Configure endpoints for signup and login.
   - Set up CORS to handle cross-origin requests from the frontend.

3. **Lambda Permissions**:
   - Grant API Gateway permission to invoke the Lambda function.

## How to Use

1. **Deploy the API**:
   - Apply Terraform configuration to deploy AWS resources.

2. **Access the API**:
   - Use the provided API Gateway URL to interact with the API from the frontend.

3. **Frontend Interaction**:
   - Open the `index.html` file in a browser.
   - Use the forms to signup or login, and see responses displayed on the page.

## Notes

- **Security**: For production use, ensure passwords are securely hashed and not stored in plaintext.
- **CORS**: Make sure CORS settings are correctly configured to match your frontend requirements.
