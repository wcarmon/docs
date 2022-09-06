# syntax=docker/dockerfile:1

# Assumption:
# 1. Prior to this, Run scripts/build.via-docker.sh to build the binary
# 2. Copy the binary to the container in Deploy stage

# ---------------------------------------------
# -- Deploy stage
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
COPY --from=builder /app/app.bin /app/app.bin
COPY --from=builder /app/src/app.config.toml /app/app.config.toml

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

CMD ["/app/app.bin", "app.config.toml"]
