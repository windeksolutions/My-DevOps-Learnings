package main

import (
	"encoding/json"
	"log"
	"net/http"
)

// HealthCheck represents the response for health check endpoint
type HealthCheck struct {
	Status    string `json:"status"`
	Service   string `json:"service"`
	Version   string `json:"version"`
}

// AnalyticsHandler handles analytics requests
type AnalyticsHandler struct{}

// GET /api/analytics handler
func (h *AnalyticsHandler) GetAnalytics(w http.ResponseWriter, r *http.Request) {
	response := map[string]interface{}{
		"requests_total": 12345,
		"active_users":   987,
		"cache_hits":     456,
	}
	json.NewEncoder(w).Encode(response)
}

// GET /health handler
func (h *AnalyticsHandler) GetHealth(w http.ResponseWriter, r *http.Request) {
	response := HealthCheck{
		Status: "healthy",
		Service: "analytics-service",
		Version: "1.0.0",
	}
	json.NewEncoder(w).Encode(response)
}

func main() {
	mux := http.NewServeMux()
	handler := &AnalyticsHandler{}
	
	mux.HandleFunc("/api/analytics", handler.GetAnalytics)
	mux.HandleFunc("/health", handler.GetHealth)
	
	log.Println("Starting analytics service on port 8080")
	log.Fatal(http.ListenAndServe(":8080", mux))
}