FROM golang:alpine

WORKDIR /gateway
COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o ./bin/api ./cmd/api \
    && go build -o ./bin/migrate ./cmd/migrate

CMD ["/gateway/bin/api"]
EXPOSE 8080