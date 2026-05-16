package main

import (
	"log"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/indiedev/go-auth-service/config"
	"github.com/indiedev/go-auth-service/controllers"
	"github.com/indiedev/go-auth-service/middleware"
	"github.com/joho/godotenv"
)

func main() {
	// Load environment variables
	err := godotenv.Load()
	if err != nil {
		log.Println("Warning: .env file not found")
	}

	// Connect to database
	config.ConnectDatabase()

	// Initialize Gin router
	r := gin.Default()

	// Public routes
	r.GET("/", func(c *gin.Context) {
		c.JSON(200, gin.H{"message": "Golang Auth Service is running!"})
	})
	r.POST("/signup", controllers.Signup)
	r.POST("/login", controllers.Login)

	// Protected routes
	protected := r.Group("/")
	protected.Use(middleware.AuthMiddleware())
	{
		protected.GET("/profile", controllers.GetProfile)
		
		// Admin only routes
		admin := protected.Group("/")
		admin.Use(middleware.AdminMiddleware())
		{
			admin.GET("/users", controllers.GetAllUsers)
		}
	}

	// Start server
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	log.Printf("Server starting on port %s", port)
	if err := r.Run(":" + port); err != nil {
		log.Fatal("Failed to start server:", err)
	}
}
