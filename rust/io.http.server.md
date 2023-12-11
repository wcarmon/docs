# Overview
1. Evaluation of popular RESTful HTTP Server libs


# Requirements
1. Library, not framework
    1. Minimal/No magic
    1. Easy to reason about control flow
    1. Easy to debug
1. Easy to get down the HTTP protocol's domain
    1. Easy to respond with a byte array/string body and an HTTP status code
    1. Easy to read request headers
    1. Easy to read raw HTTP request body
1. Easy to use request scoped data (Eg. authenticated user token/id)
1. Support for middleware (filters)
1. Flexible options for defining routes
    1. with and without attributes/decorators/annotations
1. Global error handling
1. Flexible QueryString parsing
1. Easy to add tracing/spans
1. Easy to add metrics
1. Easy to add application scoped references (eg. DB connection pool)
1. Some control over how requests are multiplexed across OS threads


# Candidates
1. Best: [**Rocket**](https://rocket.rs/)
1. [Actix](https://actix.rs/)
1. [Warp](https://github.com/seanmonstar/warp)
1. [Axum](TODO)


# [Rocket](TODO) (best)
1. `Pro`:
1. `Pro`:
1. `Pro`:
1. `Con`:
1. `Con`:
1. `Con`:

# [Rocket](https://rocket.rs/)
1. `Con`: no async support (important for IO heavy cases like servers)  <--- still true?


# [Actix](https://actix.rs/)
1. `Con`:
1. `Con`:
1. `Con`:
1. `Con`:
1. `Con`:
1. `Con`:
1. `Pro`:
1. `Pro`:
1. `Pro`:
1. `Pro`:
1. `Pro`:
1. `Pro`:
1. `Pro`: multiple recent books are based on this


# [Warp](https://github.com/seanmonstar/warp)
1. `Pro`:
1. `Pro`:
1. `Pro`:
1. `Con`:
1. `Con`:
1. `Con`:


# [~~Axum~~](https://docs.rs/axum/latest/axum/)
1. `Con`: No appreciation for simplicity
1. `Con`: `Infallible` is complex to use with other features
1. `Con`: `IntoResponse` is complex to use
1. `Con`: Custom middleware is VERY complex
1. `Con`: Custom request parsing is very complicated (compared to alternatives above)
1. `Con`: Deep Integration with [tower](TODO) increases complexity (learning curve)
1. `Con`: Request scoped data is more complex (and magical) than alternatives above
1. `Pro`: Actively maintained
1. `Pro`: Global error handling is not too bad, but less intuitive than alternatives above
1. `Pro`: Maintained by tokio team
1. `Pro`: Tracing is a first class use case


# [Tide](https://github.com/http-rs/tide)
1. TODO


# [Hyper](https://hyper.rs/)
1. Don't use directly
1. Very Low-level, most high-level libs are based on this
    1. Warp
    1. Rocket


# Other Resources
1. TODO