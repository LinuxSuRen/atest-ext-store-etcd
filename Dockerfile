FROM golang:1.22 AS builder

ARG VERSION
ARG GOPROXY
WORKDIR /workspace
COPY cmd/ cmd/
COPY pkg/ pkg/
COPY go.mod go.mod
COPY go.sum go.sum
COPY main.go main.go
COPY README.md README.md

RUN GOPROXY=${GOPROXY} go mod download
RUN GOPROXY=${GOPROXY} CGO_ENABLED=0 go build -ldflags "-w -s" -o atest-store-etcd .

FROM alpine:3.12

LABEL org.opencontainers.image.source=https://github.com/LinuxSuRen/atest-ext-store-git
LABEL org.opencontainers.image.description="Git Store Extension of the API Testing."
LABEL org.opencontainers.image.licenses="Apache-2.0"

COPY --from=builder /workspace/atest-store-etcd /usr/local/bin/atest-store-etcd

CMD [ "atest-store-etcd" ]
