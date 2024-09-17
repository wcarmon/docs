# syntax=docker/dockerfile:1

# If you have dependency crates in the same git-repo ...
# move this file to a common ancestor directory, (so cargo build can reach the dep crates)


# Assumptions
# 1. tests already pass
# 1. clippy already passes "enough"
# 2. Cross-compiling is hard (Builds with debian, executes with debian)


# ---------------------------------------------
# -- Build stage (Debian)
# ---------------------------------------------
# -- NOTE: container version not so imporant since rustup can update itself
#
# -- See https://hub.docker.com/_/rust
# -- Debug: docker run --rm -it rust:1.81-bookworm /bin/bash
FROM rust:1.81-bookworm AS builder

WORKDIR /usr/src/myapp

# TODO: copy & install required certs here

RUN apt-get update -qq && \
    apt-get install -q -y curl unzip tree zip && \
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

RUN cargo build \
    --release \
    --quiet

# See Artifacts:
# - /usr/src/myapp/target/x86_64-unknown-linux-gnu/release/binary1
# - /usr/src/myapp/target/x86_64-unknown-linux-gnu/release/binary2


# ---------------------------------------------
# -- Deploy stage
# ---------------------------------------------
FROM debian:bookworm

WORKDIR /app
EXPOSE 8080

## (Optional) add extra certs here
#COPY --from=builder /usr/sbin/update-ca-certificates /usr/sbin/update-ca-certificates

# -- Copy artifacts
COPY --from=builder /usr/src/myapp/target/x86_64-unknown-linux-gnu/release/binary1 /app/app-server

# TODO: fix this block
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
# docker run --rm -it foobar:latest-debian /bin/bash
