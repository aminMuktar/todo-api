##
##Build
##
FROM golang:1.21.7 AS builder

WORKDIR /todo-api
COPY go.mod ./
COPY go.sum ./

COPY . .

RUN go build -o todoapp main.go

##
##Deploy
##
FROM alpine
COPY --from=builder /todo-api/todoapp .
EXPOSE 8081

ENTRYPOINT ["./todoapp"]