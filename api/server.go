package api

import (
	db "github.com/brunoFgR/simplebank/db/sqlc"
	"github.com/gin-gonic/gin"
)

// Server side HTTP requests for our banking service.
type Server struct {
	store  *db.Store
	router *gin.Engine
}

// NewServer creates a new HTTP server and setup routing.
func NewServer(store *db.Store) *Server {
	server := &Server{store: store}
	router := gin.Default()

	router.SetTrustedProxies([]string{"10.42.0.71"})

	router.POST("/accounts", server.createAccount)

	server.router = router

	return server
}

// Start runs the HTTP server on a specific address.
func (server *Server) Start(address string) error {
	return server.router.Run(address)
}

func errorResponse(err error) gin.H {
	return gin.H{"error": err.Error()}
}
