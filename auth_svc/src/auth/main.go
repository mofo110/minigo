package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"log"
	"strings"

	"github.com/dgrijalva/jwt-go"
	"gopkg.in/oauth2.v3/generates"
)
func main() {
	http.HandleFunc("/", handler)
	log.Println("Server is running at 3000 port.")
	log.Fatal(http.ListenAndServe(":3000", nil))
}

func handler(w http.ResponseWriter, r *http.Request) {
	// Extract access_token from header
	reqToken := r.Header.Get("Authorization")
	if reqToken == "" {
		http.Error(w, "Authorization header is missing", http.StatusUnauthorized)
		return
	}
	splitToken := strings.Split(reqToken, " ")
	access := splitToken[1]

	// Start: Verify jwt access token
	token, err := jwt.ParseWithClaims(access, &generates.JWTAccessClaims{}, func(t *jwt.Token) (interface{}, error) {
		if _, ok := t.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, fmt.Errorf("Parse JWT error")
		}
		return []byte("00000000"), nil
	})
	if err != nil {
		http.Error(w, err.Error(), http.StatusUnauthorized)
		return
	}

	_, ok := token.Claims.(*generates.JWTAccessClaims)
	if !ok || !token.Valid {
		http.Error(w, "Invalid token", http.StatusUnauthorized)
		return
	}
	// End: Verify jwt access token

	data := map[string]interface{}{
		"message": "success",
	}

	e := json.NewEncoder(w)
	e.SetIndent("", "  ")
	e.Encode(data)
}