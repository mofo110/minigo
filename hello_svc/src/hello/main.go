package main

import (
	"encoding/json"
	"net/http"
	"log"
)
func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		username := r.URL.Path
		data := map[string]interface{}{
			"greeting": "Hello "+username,
		}

		e := json.NewEncoder(w)
		e.SetIndent("", "  ")
		e.Encode(data)
	})

	log.Println("Server is running at 8080 port.")
	log.Fatal(http.ListenAndServe(":8080", nil))
}