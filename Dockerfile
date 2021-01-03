############################
# STEP 1 build executable binary
############################
FROM golang:1.15.5-buster AS builder

COPY ./main.go /go/src/github.com/diazdavid-info/github-ci-golang/main.go
WORKDIR /go/src/github.com/diazdavid-info/github-ci-golang

RUN go get -d -v ./...
RUN go build \
    -o /go/bin/github-ci-golang main.go

############################
# STEP 2 build a small image
############################
FROM alpine:3.11

COPY --from=builder /go/bin/github-ci-golang ./

ENTRYPOINT ["/github-ci-golang"]
