# Go Auth Service

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

### Public APIs

- **POST `/signup`**: Create a new user.
  - Body: `{ "username": "...", "email": "...", "password": "...", "role": "user" }`
- **POST `/login`**: Authenticate and get a JWT token.
  - Body: `{ "email": "...", "password": "..." }`

### Protected APIs (Requires Bearer Token)

- **GET `/profile`**: Get current user's profile.
- **GET `/users`** (Admin Only): Get list of all users.

## Project Structure

- `main.go`: Application entry point and router configuration.
- `config/`: Database connection setup.
- `controllers/`: Request handlers for auth and users.
- `middleware/`: JWT and Role-based access control middleware.
- `models/`: GORM database models.
- `utils/`: Helper functions (JWT generation).
- `go.mod`: Go module dependencies.
- `.env`: Environment configuration.
