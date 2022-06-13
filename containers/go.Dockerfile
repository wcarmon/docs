# syntax=docker/dockerfile:1

# ---------------------------------------------
# -- Build Stage
# ---------------------------------------------
FROM golang:1.18-alpine AS builder
WORKDIR /app/src

## If you need extra certs, do that here
## - Alpine: /usr/local/share/ca-certificates/
## - Debian: /usr/lib/ssl/certs
# COPY ./the.crt /usr/local/share/ca-certificates/

RUN update-ca-certificates && \
    apk update && \
    apk upgrade && \
    apk add --no-cache ca-certificates && \
    update-ca-certificates

# -- Copy sources (see also: .dockerignore
COPY . .

# -- Get dependencies via go.mod & go.sum
RUN go mod download

# -- Build binary
#TODO: replace with your cmd package
RUN go build -o /app/app.binary -v /app/src/cmd/run-service/...


# ---------------------------------------------
# -- Deploy Stage
# ---------------------------------------------
FROM alpine:latest
#LABEL Foo=bar Version=1.0.0

WORKDIR /app
EXPOSE 3000

## If you need extra certs, do that here
#COPY --from=builder /usr/sbin/update-ca-certificates /usr/sbin/update-ca-certificates

RUN update-ca-certificates && \
    apk --no-cache add ca-certificates

# -- Copy binary & config
COPY --from=builder /app/app.binary /app/app.binary
COPY --from=builder /app/src/app.config.yaml /app/app.config.yaml

# -- Make non-root user
RUN addgroup -g 1001 gopher && \
    adduser \
    -D \
    -G gopher \
    -h /app \
    -H \
    -u 1001 \
    gopher

RUN chmod 0755 /app/app.binary && \
    chown -R gopher:gopher /app

USER gopher:gopher

CMD ["/app/app.binary", "app.config.yaml"]
