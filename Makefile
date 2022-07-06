postgres:
	docker run --name project_bank -e POSTGRES_PASSWORD=docker -p 5432:5432 -d postgres:14-alpine

createdb:
	docker exec -it project_bank createdb --username=postgres --owner=postgres simple_bank

dropdb:
	docker exec -it project_bank dropdb --username=postgres simple_bank

migrateup:
	migrate -path db/migration -database 'postgresql://postgres:docker@localhost:5432/simple_bank?sslmode=disable' --verbose up

migratedown:
	migrate -path db/migration -database 'postgresql://postgres:docker@localhost:5432/simple_bank?sslmode=disable' --verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test