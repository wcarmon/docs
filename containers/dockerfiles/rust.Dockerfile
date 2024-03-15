# syntax=docker/dockerfile:1

# Assumptions
# 1. tests already pass

# ---------------------------------------------
# -- Build stage (Debian)
# ---------------------------------------------
# -- See https://hub.docker.com/_/rust
# -- Debug: docker run --rm -it rust:1.76-bookworm /bin/bash
FROM rust:1.76-bookworm AS builder
#FROM rust:1.76-alpine AS builder

WORKDIR /usr/src/myapp

# TODO: copy & install required certs

RUN apt-get update -qq && \
    apt-get install -q -y curl unzip tree zip && \
    apt-get install -q -y mingw-w64 && \
    update-ca-certificates

RUN rustup target add x86_64-unknown-linux-musl
RUN rustup target add x86_64-pc-windows-gnu

# -- Copy sources (see also: .dockerignore)
COPY . .

# -- Print available targets
# RUN rustup target list

# -- Current target
# RUN rustc -vV

RUN cargo build \
    --release \
    --target=x86_64-unknown-linux-gnu \
    --quiet

RUN cargo build \
    --release \
    --target=x86_64-unknown-linux-musl \
    --quiet

RUN cargo build \
    --release \
    --target=x86_64-pc-windows-gnu \
    --quiet

# See Artifacts:
# - /usr/src/myapp/target/x86_64-pc-windows-gnu/release/binary1.exe
# - /usr/src/myapp/target/x86_64-pc-windows-gnu/release/binary2.exe
# - /usr/src/myapp/target/x86_64-unknown-linux-gnu/release/binary1
# - /usr/src/myapp/target/x86_64-unknown-linux-gnu/release/binary2
# - /usr/src/myapp/target/x86_64-unknown-linux-musl/release/binary1
# - /usr/src/myapp/target/x86_64-unknown-linux-musl/release/binary2


# ---------------------------------------------
# -- Deploy stage
# ---------------------------------------------
FROM alpine:3

WORKDIR /app
EXPOSE 8080

## If you need extra certs, do that here
#COPY --from=builder /usr/sbin/update-ca-certificates /usr/sbin/update-ca-certificates

# -- copy artifacts
#COPY --from=builder /usr/src/myapp/target/x86_64-pc-windows-gnu/release/binary1.exe /app/binary1-x86_64-pc-windows-gnu.exe
#COPY --from=builder /usr/src/myapp/target/x86_64-unknown-linux-gnu/release/binary1 /app/binary1-x86_64-unknown-linux-gnu
COPY --from=builder /usr/src/myapp/target/x86_64-unknown-linux-musl/release/binary1 /app/binary1-x86_64-unknown-linux-musl

RUN addgroup -g 1001 appuser && \
    adduser \
    -D \
    -G appuser \
    -h /app  \
    -u 1001 \
    appuser

RUN chmod 0755 /app/binary1-x86_64-unknown-linux-musl && \
    chown -R appuser:appuser /app

USER appuser:appuser

CMD ["/app/binary1-x86_64-unknown-linux-musl"]

# DEBUGGING:
# docker run --rm -it todo-a:latest-debian /bin/bash
# docker run --rm -it todo-a:latest-debian /bin/ash