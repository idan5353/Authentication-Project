from flask import Flask, request, jsonify
import boto3
from botocore.exceptions import ClientError

app = Flask(__name__)
dynamodb = boto3.resource('dynamodb', region_name='us-west-2')  # Update region as needed
table = dynamodb.Table('example-table')

@app.route('/signup', methods=['POST'])
def signup():
    data = request.get_json()
    username = data['username']
    password = data['password']  # In a real-world scenario, ensure passwords are hashed and secured

    try:
        table.put_item(Item={'username': username, 'password': password})
        return jsonify({'message': 'Signup successful!'}), 200
    except ClientError as e:
        return jsonify({'error': str(e)}), 500

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data['username']
    password = data['password']

    try:
        response = table.get_item(Key={'username': username})
        item = response.get('Item')

        if item and item['password'] == password:
            return jsonify({'message': 'Login successful!'}), 200
        else:
            return jsonify({'message': 'Invalid username or password!'}), 401
    except ClientError as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
