# syntax=docker/dockerfile:1

# If you have dependency crates in the same git-repo ...
# move this file to a common ancestor directory, (so cargo build can reach the dep crates)


# Assumptions
# 1. tests already pass
# 1. clippy already passes "enough"
# 2. Cross-compiling is hard (Builds with alpine, executes with alpine)


# ---------------------------------------------
# -- Build stage (Alpine)
# ---------------------------------------------
# -- NOTE: container version not so imporant since rustup can update itself
#
# -- See https://hub.docker.com/_/rust
# -- Debug: docker run --rm -it rust:1.81-alpine /bin/ash
FROM rust:1.81-alpine3.20 AS builder

WORKDIR /usr/src/myapp

# TODO: copy & install required certs here

RUN apk update -qq && \
    apk add curl musl-dev openssl-dev tree unzip wget zip && \
    update-ca-certificates


# -- Print available targets
# RUN rustup target list
# RUN rustup target list | grep linux | grep -v android

# -- Current target
# RUN rustc -vV

# -- Installed components
# RUN rustup component list --installed

# -- Switch to nightly toolchain
RUN rustup toolchain install nightly && \
    rustup default nightly


# -- Copy local dependencies (same git repo)
COPY commons/my-local-dep1 build/commons/my-local-dep1
COPY commons/my-local-dep2 build/commons/my-local-dep2


# -- Copy sources (see also: ./.dockerignore in same dir as Dockerfile)
# COPY <relative-to-docker-file> <relative-to-WORKDIR>
COPY path/to/Cargo.lock build/project-root/
COPY path/to/Cargo.toml build/project-root/
COPY path/to/src        build/project-root/src

WORKDIR build/project-root/

#ENV OPENSSL_DIR=/usr
RUN RUSTFLAGS="-Ctarget-feature=-crt-static" cargo build \
    --release \
    --quiet

# See Artifacts:
# - /usr/src/myapp/build/project-root/target/release/<binary>


# ---------------------------------------------
# -- Deploy stage
# ---------------------------------------------
FROM alpine:3

WORKDIR /app
EXPOSE 8080

RUN apk update -qq && \
    apk add libgcc


## (Optional) add extra certs here
#COPY --from=builder /usr/sbin/update-ca-certificates /usr/sbin/update-ca-certificates

# -- Copy artifacts
COPY --from=builder /usr/src/myapp/build/project-root/target/release/the-server-binary /app/app-server

RUN addgroup -g 1001 appuser && \
    adduser \
    -D \
    -G appuser \
    -h /app  \
    -u 1001 \
    appuser


RUN chmod 0755 /app/app-server && \
    chown -R appuser:appuser /app

USER appuser:appuser

CMD ["/app/app-server"]

# DEBUGGING:
# docker run --rm -it foobar:latest-alpine /bin/ash
