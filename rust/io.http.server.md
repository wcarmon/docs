# Overview
1. Evaluation of popular RESTful HTTP Server libs


# Requirements
1. [Library, not framework](../general/libraries.md)
    1. Minimal/No magic
    1. Easy to reason about control flow
    1. Easy to debug
1. Easy to get down the [HTTP protocol's domain & terminology)](https://en.wikipedia.org/wiki/HTTP)
    1. Easy to respond with a byte array/string body and an HTTP status code
    1. Easy to read request headers
    1. Easy to read raw HTTP request body
1. Easy to use request scoped data (Eg. authenticated user token/id)
1. Support for [middleware (filters)](https://drstearns.github.io/tutorials/gomiddleware/)
1. Flexible options for defining routes
    1. with and without attributes/decorators/annotations
1. Global error handling
1. Flexible [Query String](https://en.wikipedia.org/wiki/Query_string) parsing
1. Easy to add [Tracing/spans](https://opentelemetry.io/docs/concepts/)
    1. See also https://opentelemetry.io/docs/instrumentation/rust/
1. Easy to add metrics
1. Easy to add application scoped references (eg. DB connection pool)
1. Some control over how requests are multiplexed across OS threads


# Candidates
1. Best: [**Rocket**](https://rocket.rs/)
1. Next best: [**Actix**](https://actix.rs/)
1. [Tide](https://github.com/http-rs/tide)
1. [Warp](https://github.com/seanmonstar/warp)
1. ~~Axum~~


# [Rocket](https://rocket.rs/v0.5/guide/overview/) (best)
1. `Pro`: Simplicity is a virtue
1. `Pro`: Books written about Rocket
1. `Pro`: [async support](https://rocket.rs/v0.5/guide/overview/#futures-and-async) (as of 0.5)
1. `Pro`: Custom middleware is intuitive (See [Fairing](https://api.rocket.rs/v0.4/rocket/fairing/trait.Fairing.html) info)
1. `Pro`: Custom request parsing is intuitive
1. `Pro`: Excellent documentation
1. `Pro`: Flexible [query string parsing](https://docs.rs/rocket/latest/rocket/http/uri/struct.Query.html)
1. `Pro`: Flexible [Responders](https://docs.rs/rocket/latest/rocket/response/struct.Builder.html)
1. `Pro`: Flexible [routing options](https://api.rocket.rs/v0.4/rocket/macro.routes.html)
1. `Pro`: Global error handling via [Catchers](https://rocket.rs/v0.5/guide/requests/#error-catchers)
1. `Pro`: Request scoped data is easy to read & write (see [`req.local_cache`](https://api.rocket.rs/v0.4/rocket/request/struct.Request.html#method.local_cache))


# [Actix](https://actix.rs/) (2nd best)
1. `Con`: Documentation doesn't highlight how good the library is.  Docs focus too much on "magic" features.
1. `Con`: Naturally more framework than library (like spring-web), but unlike spring, Actix allows lower level access
1. `Con`: [extractors api](https://actix.rs/docs/extractors/) is overly complex
1. `Con`: Complexity on [middleware factory](https://docs.rs/actix-web/latest/actix_web/middleware/index.html#example), although [`wrap_fn`](https://docs.rs/actix-web/4.4.0/actix_web/struct.App.html#method.wrap_fn) should mitigate
1. `Con`: Global error handling more complex than Rocket
1. `Pro`: Flexible [routing options](https://actix.rs/docs/url-dispatch/)
1. `Pro`: multiple recent books are based on this
1. `Pro`: Relatively simple global error handling (see [`wrap_fn`](https://docs.rs/actix-web/4.4.0/actix_web/struct.App.html#method.wrap_fn))
1. `Pro`: Relatively simple request scoped data (see [`req.extensions_mut`](https://docs.rs/actix-web/latest/actix_web/struct.HttpRequest.html#method.extensions_mut) to write and [`web::ReqData`](https://docs.rs/actix-web/latest/actix_web/web/struct.ReqData.html) to read)
1. `Pro`: Simple [response building](https://docs.rs/actix-web/4.4.0/actix_web/struct.HttpResponseBuilder.html), even with [json](https://docs.rs/actix-web/4.4.0/actix_web/struct.HttpResponseBuilder.html#method.json)
1. `Pro`: Simple query string parsing (see [this](https://actix.rs/docs/extractors/#query) and [this](https://docs.rs/actix-web/latest/actix_web/web/struct.Query.html#method.from_query))


# [Tide](https://github.com/http-rs/tide)
1. `Con`: Not as mature as alternatives above


# [Warp](https://github.com/seanmonstar/warp)
1. `Con`: Complexity on custom query string parsing (compare to Rocket & Actix)
1. `Con`: Overly complex code for custom middleware (compare to Rocket & Actix)
1. `Con`: Some magic required for request scoped data (makes debugging, reasoning harder)
1. `Pro`: Global error handling not too complex
1. `Pro`: Recent book written about warp


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


# [Hyper](https://hyper.rs/)
1. Don't use directly
1. Very Low-level, most high-level libs are based on this
    1. Warp
    1. Rocket


# Other Resources
1. TODO