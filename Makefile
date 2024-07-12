setup:
	docker-compose up -d
run: build
	./todoapp start
down: 
	docker-compose down
build:
	go build -o todoapp main.go
migrate: build
	./todoapp migrate up