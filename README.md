# Go Auth Service

**Live Demo**: [https://go-project-7qny.onrender.com](https://go-project-7qny.onrender.com)

A lightweight Golang backend service with JWT authentication and role-based access control (RBAC).

## Features

- **Authentication**: Signup and Login APIs.
- **Security**: Password hashing using bcrypt.
- **Authorization**: JWT-based authentication.
- **Roles**: Admin and User roles.
- **Protected Routes**:
  - `/profile`: Accessible by any authenticated user (returns own profile).
  - `/users`: Accessible only by users with the `admin` role.
- **Database**: PostgreSQL (using Neon DB) with GORM ORM.

## Prerequisites

- Go 1.21+
- PostgreSQL database (or use the provided Neon URI)

## Setup

1. Clone the repository.
2. Create a `.env` file in the root directory (one is provided with a sample Neon DB URI).
3. Install dependencies:
   ```bash
   go mod tidy
   ```
4. Run the application:
   ```bash
   go run main.go
   ```

## API Endpoints

**Base URL**: `https://go-project-7qny.onrender.com` (or `http://localhost:8080` for local development)

### Public APIs

- **GET `/`**: Health check. Returns "Golang Auth Service is running!".
- **POST `/signup`**: Create a new user.
  - Body: `{ "username": "...", "email": "...", "password": "...", "role": "user" }`
- **POST `/login`**: Authenticate and get a JWT token.
  - Body: `{ "email": "...", "password": "..." }`

### Protected APIs (Requires Bearer Token)

- **GET `/profile`**: Get current user's profile.
- **GET `/users`** (Admin Only): Get list of all users.

## Testing with Live URL

You can test the live APIs using `curl`:

1. **Signup**:

   ```bash
   curl -X POST https://go-project-7qny.onrender.com/signup \
     -H "Content-Type: application/json" \
     -d '{"username": "testuser", "email": "test@example.com", "password": "password123", "role": "user"}'
   ```

2. **Login**:

   ```bash
   curl -X POST https://go-project-7qny.onrender.com/login \
     -H "Content-Type: application/json" \
     -d '{"email": "test@example.com", "password": "password123"}'
   ```

   _(Copy the token from the response)_

3. **Get Profile**:

   ```bash
   curl -X GET https://go-project-7qny.onrender.com/profile \
     -H "Authorization: Bearer YOUR_TOKEN_HERE"
   ```

4. **Get All Users** (Requires Admin role):
   ```bash
   curl -X GET https://go-project-7qny.onrender.com/users \
     -H "Authorization: Bearer YOUR_ADMIN_TOKEN_HERE"
   ```

## Project Structure

- `main.go`: Application entry point and router configuration.
- `config/`: Database connection setup.
- `controllers/`: Request handlers for auth and users.
- `middleware/`: JWT and Role-based access control middleware.
- `models/`: GORM database models.
- `utils/`: Helper functions (JWT generation).
- `go.mod`: Go module dependencies.
- `.env`: Environment configuration.
