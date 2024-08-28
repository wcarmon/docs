# Overview
1. Evaluation of popular RESTful HTTP Server libs


# Requirements
1. [Library, not framework](../common/libraries.md)
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


# High-level Candidates
1. Best: [**Actix**](https://actix.rs/)
1. next best: [**Rocket**](https://rocket.rs/)
1. [Tide](https://github.com/http-rs/tide)
1. [Warp](https://github.com/seanmonstar/warp)
1. ~~Axum~~


## [Actix](https://actix.rs/) (2nd best)
1. `Con`: Documentation doesn't highlight how good the library is.  Docs focus too much on "magic" features.
1. `Con`: Naturally more framework than library (like spring-web), but unlike spring, Actix allows lower level access
1. `Con`: [extractors api](https://actix.rs/docs/extractors/) is overly complex
1. `Con`: Complexity on [middleware factory](https://docs.rs/actix-web/latest/actix_web/middleware/index.html#example), although [`wrap_fn`](https://docs.rs/actix-web/4.4.0/actix_web/struct.App.html#method.wrap_fn) should mitigate
1. `Con`: Global error handling more complex than Rocket
1. `Pro`: actively maintained
1. `Pro`: Extremely well designed
1. `Pro`: Flexible [routing options](https://actix.rs/docs/url-dispatch/)
1. `Pro`: low level control when you need it
1. `Pro`: multiple recent books are based on this
1. `Pro`: Relatively simple global error handling (see [`wrap_fn`](https://docs.rs/actix-web/4.4.0/actix_web/struct.App.html#method.wrap_fn))
1. `Pro`: trivial to [normalize trailing slashes](https://docs.rs/actix-web/latest/actix_web/middleware/enum.TrailingSlash.html#variant.Trim)
4. `Pro`: ecosystem is large enough to support things like tracing
1. `Pro`: Relatively simple request scoped data (see [`req.extensions_mut`](https://docs.rs/actix-web/latest/actix_web/struct.HttpRequest.html#method.extensions_mut) to write and [`web::ReqData`](https://docs.rs/actix-web/latest/actix_web/web/struct.ReqData.html) to read)
1. `Pro`: Simple [response building](https://docs.rs/actix-web/4.4.0/actix_web/struct.HttpResponseBuilder.html), even with [json](https://docs.rs/actix-web/4.4.0/actix_web/struct.HttpResponseBuilder.html#method.json)
1. `Pro`: Simple query string parsing (see [this](https://actix.rs/docs/extractors/#query) and [this](https://docs.rs/actix-web/latest/actix_web/web/struct.Query.html#method.from_query))


## [Rocket](https://rocket.rs/v0.5/guide/overview/) (best)
1. At the level of Spring Web
1. More declarative than imperative, but so feature rich it rarely matters
1. `Con`: Seems abandoned
1. `Con`: Faring setup doesn't play well with DI
1. `Con`: Farings (middleware) are exhausting and framework heavy (too far abstracted from actual behavior)
1. `Con`: Route annotations only work on functions not on methods (not impl)
1. `Pro`: [async support](https://rocket.rs/v0.5/guide/overview/#futures-and-async) (as of 0.5)
1. `Pro`: Books written about Rocket
1. `Pro`: Custom middleware is intuitive (See [Fairing](https://api.rocket.rs/v0.4/rocket/fairing/trait.Fairing.html) info)
1. `Pro`: Custom request parsing is intuitive
1. `Pro`: Excellent documentation
1. `Pro`: Flexible [query string parsing](https://docs.rs/rocket/latest/rocket/http/uri/struct.Query.html)
1. `Pro`: Flexible [Responders](https://docs.rs/rocket/latest/rocket/response/struct.Builder.html)
1. `Pro`: Flexible [routing options](https://api.rocket.rs/v0.4/rocket/macro.routes.html)
1. `Pro`: Global error handling via [Catchers](https://rocket.rs/v0.5/guide/requests/#error-catchers)
1. `Pro`: Request scoped data is easy to read & write (see [`req.local_cache`](https://api.rocket.rs/v0.4/rocket/request/struct.Request.html#method.local_cache))
1. `Pro`: Simplicity is a virtue


## [Tide](https://github.com/http-rs/tide)
1. `Con`: Not as mature as alternatives above


## [Warp](https://github.com/seanmonstar/warp)
1. `Con`: Complexity on custom query string parsing (compare to Rocket & Actix)
1. `Con`: Overly complex code for custom middleware (compare to Rocket & Actix)
1. `Con`: routing is a messy nested DSL, especially for websockets
1. `Con`: Some magic required for request scoped data (makes debugging, reasoning harder)
1. `Pro`: Global error handling not too complex
1. `Pro`: Recent book written about warp


## [~~poem~~]
1. `Con`: `poem::middleware::Middleware` is just as painful as hyper (`BoxFuture`, `pin`, `async move`, ...)


## [~~Axum~~](https://docs.rs/axum/latest/axum/)
1. `Con`: No appreciation for simplicity
1. `Con`: `Infallible` is complex to use with other features
1. `Con`: `IntoResponse` is complex to use
1. `Con`: Custom middleware is VERY complex
1. `Con`: Custom request parsing is very complicated (compared to alternatives above)
1. `Con`: Deep Integration with [tower](https://docs.rs/tower/latest/tower/) increases complexity (learning curve)
1. `Con`: Request scoped data is more complex (and magical) than alternatives above
1. `Pro`: Actively maintained
1. `Pro`: Global error handling is not too bad, but less intuitive than alternatives above
1. `Pro`: Maintained by tokio team
1. `Pro`: Tracing is a first class use case


# Low level
## [Hyper](https://hyper.rs/)
1. Very Low-level, most high-level libs are based on this
    1. Warp
    1. Rocket
1. At the same level as [Go http](https://pkg.go.dev/net/http)
1. Slightly below the level of [Javalin](https://javalin.io/)
1. `Pro`: Gives you granular control over routing, state injection (like a db connection pool, request validation, headers, authentication, lifetimes, ...)
1. `Con`: Managing ownership is hard
1. `Con`: `impl Service<Request<...>>` approach makes it hard to invoke async tasks in handlers
1. `Con`: `Pin<Box<dyn Future<...>>>`
1. `Con`: error handling is very hard & complex (even with anyhow)
1. `Con`: websockets are VERY hard
1. `Pro`: close to the metal

