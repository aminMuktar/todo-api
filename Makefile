setup:
	docker-compose up -d
run: build
	./todoapp start
down: 
	docker-compose down
build:
	go build -o todoapp main.go
migrate-up:
	docker-compose exec -T scylla-todoapp cqlsh -f /migrations/0001_init_schema.up.cql	
	docker-compose exec -T scylla-todoapp cqlsh -f /migrations/0002_init_schema.up.cql

migrate-down:
	docker-compose exec -T scylla-todoapp cqlsh -f /migrations/0001_init_schema.down.cql