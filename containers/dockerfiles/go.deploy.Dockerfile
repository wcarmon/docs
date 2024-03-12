# syntax=docker/dockerfile:1

# Assumptions:
# 1. Prior to this, Run ./scripts/build.via_docker.sh to build the binary
# 2. Copy the binary to the container in Deploy stage

# ---------------------------------------------
# -- Deploy stage
# ---------------------------------------------
FROM alpine:3

WORKDIR /app
EXPOSE 3000

## If you need extra certs, do that here
#COPY foo.crt /usr/local/share/ca-certificates/z.crt

RUN cat /usr/local/share/ca-certificates/z.crt >> /etc/ssl/certs/ca-certificates.crt && \
    apk --no-cache add curl

# -- Copy binary & config
# TODO: replace "foo" with your binary name
COPY bin/foo.amd64.alpine.bin /app/app.bin
COPY app.conf.toml /app/app.conf.toml

# -- Make non-root user
RUN addgroup -g 1001 gopher && \
    adduser \
    -D \
    -G gopher \
    -h /app \
    -H \
    -u 1001 \
    gopher

RUN chmod 0755 /app/app.bin && \
    chown -R gopher:gopher /app

USER gopher:gopher

CMD ["/app/app.bin", "app.conf.toml"]
