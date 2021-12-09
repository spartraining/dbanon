VERSION := $(shell git describe --tags 2>/dev/null)
LDFLAGS = -X main.version=$(VERSION)

build:
	test -z $(shell gofmt -l ./)
	go get ./...
	go test -coverprofile=coverage.txt -covermode=atomic ./src
	go build -ldflags "$(LDFLAGS)" -o dbanon main.go
	go test ./integration

bench:
	go test -run=XXX -bench=. -benchtime=20s ./src
