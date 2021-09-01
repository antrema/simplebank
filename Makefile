postgres:
	docker run --name postgres10 -p 5432:5432 -e POSTGRES_USER=golang -e POSTGRES_PASSWORD=golang -d postgres\:10-alpine

createdb:
	docker exec -it postgres10 createdb --username=golang --owner=golang golang_testing

dropdb:
	docker exec -it postgres10 dropdb golang_testing

migrateup:
	migrate -path db/migration -database "postgresql://golang:golang@localhost:5432/golang_testing?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://golang:golang@localhost:5432/golang_testing?sslmode=disable" -verbose down

test:
	go test -v -cover ./...

server:
	go run main.go

.PHONY: postgres createdb dropdb migrateup migratedown test
