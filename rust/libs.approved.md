# Overview

1. How to select good rust libraries
1. Good libraries

# Criteria

1. Well documented
1. Friendly license
1. Idiomatic/Ergonomic Rust
1. Minimal dependencies
1. "Simple enough"
1. Do one thing, do it well
1. "Enough" Tests
1. Alive/Active (unless mature and feature complete)
1. Recent Rust edition or newer (eg. 2021)

# DateTime

1. [chrono](https://docs.rs/chrono/latest/chrono/)

# Error handling

1. [thiserror](https://docs.rs/thiserror/latest/thiserror/) - Use: mature, robust, production-ready code
1. [anyhow](https://docs.rs/anyhow/latest/anyhow/) - Use: quick & dirty, rapid prototype, created by the same author/team as `thiserror`

# Async IO

1. [tokio](https://github.com/tokio-rs/tokio)

# Concurrency (CPU, Data parallelism)

1. High-level: [rayon](https://github.com/rayon-rs/rayon)
1. Low-level: [crossbeam](https://github.com/crossbeam-rs/crossbeam)

# DI

1. TODO

# Random

1. https://github.com/rust-random/rand

# Hashing

1. TODO

# HTTP Client

1. [reqwest](https://docs.rs/reqwest/latest/reqwest/)

# HTTP Server

1. [actix-web](https://actix.rs/)
    1. [Why?](./io.http.server.md)

# IDE

1. CLion
2. VSCode

# JWT

1. [jsonwebtoken](https://docs.rs/jsonwebtoken/latest/jsonwebtoken/)

# Macro dev

1. (read) https://github.com/dtolnay/syn
1. (write) https://github.com/dtolnay/quote
1. https://github.com/dtolnay/proc-macro2

# Observability / Metrics

1. TODO

# Observability / Structured Logging

1. [tracing](https://github.com/tokio-rs/tracing)

# Observability / Tracing

1. [tracing](https://github.com/tokio-rs/tracing)

# Postgres

1. TODO

# Protocol buffers

1. [prost](https://github.com/tokio-rs/prost)

# gRPC

1. TODO

# Kafka

1. TODO

# Retry

1. TODO

# Serde / JSON

1. https://serde.rs

# Serde / JSON5

1. https://serde.rs

# Serde / Toml

1. https://serde.rs

# Serde / URL encoding/decoding

1. https://serde.rs

# Serde / Yaml

1. not well supported

# String / Case conversion

1. TODO: https://github.com/cmoncrief/rust-morph
1. TODO: https://github.com/withoutboats/heck


# Big
1. [`num_bigfloat`](https://docs.rs/num-bigfloat/latest/num_bigfloat/index.html)
    1. ergonomic, well documented, tests, ...
- TODO: evaluate https://docs.rs/rust_decimal/latest/rust_decimal/  (probably good enough)
- TODO: evaluate https://github.com/akubera/bigdecimal-rs
- Rejected: ~~`num-rational`~~


# Test / Assertions

1. [`assert2`](https://docs.rs/assert2/latest/assert2/)
1. [`speculoos`](https://github.com/oknozor/speculoos) like hamcrest

# Test / Fake data

1. [`fake`](https://docs.rs/fake/latest/fake/)
