#!/bin/bash

# Configuration
BASE_URL="http://localhost:8080"

echo "--- 1. Testing Admin Signup ---"
curl -s -X POST $BASE_URL/signup \
  -H "Content-Type: application/json" \
  -d '{"username": "admin_user", "email": "admin@example.com", "password": "password123", "role": "admin"}' | jq .

echo -e "\n--- 2. Testing Regular User Signup ---"
curl -s -X POST $BASE_URL/signup \
  -H "Content-Type: application/json" \
  -d '{"username": "regular_user", "email": "user@example.com", "password": "password123", "role": "user"}' | jq .

echo -e "\n--- 3. Testing Login (Regular User) ---"
USER_TOKEN=$(curl -s -X POST $BASE_URL/login \
  -H "Content-Type: application/json" \
  -d '{"email": "user@example.com", "password": "password123"}' | jq -r .token)
echo "User Token: ${USER_TOKEN:0:20}..."

echo -e "\n--- 4. Testing Login (Admin) ---"
ADMIN_TOKEN=$(curl -s -X POST $BASE_URL/login \
  -H "Content-Type: application/json" \
  -d '{"email": "admin@example.com", "password": "password123"}' | jq -r .token)
echo "Admin Token: ${ADMIN_TOKEN:0:20}..."

echo -e "\n--- 5. Testing Protected Profile API (Regular User) ---"
curl -s -X GET $BASE_URL/profile \
  -H "Authorization: Bearer $USER_TOKEN" | jq .

echo -e "\n--- 6. Testing Admin-Only API (Admin User) ---"
curl -s -X GET $BASE_URL/users \
  -H "Authorization: Bearer $ADMIN_TOKEN" | jq .

echo -e "\n--- 7. Testing Admin-Only API with Regular User (Should Fail) ---"
curl -s -X GET $BASE_URL/users \
  -H "Authorization: Bearer $USER_TOKEN" | jq .
