FROM golang:1.14-alpine AS builder
RUN mkdir /build
WORKDIR /build
COPY . /build/
RUN CGO_ENABLED=0 GOOS=linux go build -o kubexit ./cmd/kubexit

FROM alpine
RUN apk --no-cache add ca-certificates tzdata
COPY --from=builder /build/kubexit /bin/
ENTRYPOINT ["kubexit"]
