# Overview

1. `Service` and `service_fn` concepts in [hyper](https://hyper.rs/)
1. See [hyper Overview doc](./hyper.md) also
1. See [hyper Request & Response doc](./hyper.req-res.md) also
1. See [hyper Body doc](./hyper.body.md) also
1. See [Bytes doc](./hyper.bytes.md) also


# [hyper::service::`Service`](https://docs.rs/hyper/latest/hyper/service/trait.Service.html) trait
1. Connects app server logic to protocol
    1. eg. [`http1.serve_connection(...)`](https://docs.rs/hyper/latest/hyper/server/conn/http1/struct.Builder.html#method.serve_connection)
1. Decouples service & routing logic from the protocol
1. Useful for "passing state" into your handlers
    1. eg. Database connection pool
1. A `Service` basically wraps one asynchronous function
1. Service has one required method, [`call`](https://docs.rs/hyper/latest/hyper/service/trait.Service.html#tymethod.call) (RPC)
1. `Service` trait has 3 associated types
    1. `Response`: output of service (eg. `Response<BoxBody<Bytes, Self::Error>>`)
    1. `Error`: Errors this service produces (eg. `anyhow::Error`)
    1. `Future`: `Pin<Box<dyn Future<Output=Result<Self::Response, Self::Error>> + Send>>;`
        1. `Pin`: don't move in memory
        1. `Box`: on heap
        1. `dyn Future`: TODO 

# TODO: example

```rust
TODO
```


# [hyper::service::`service_fn`](https://docs.rs/hyper/latest/hyper/service/fn.service_fn.html) function

1. Convenience utility to build a `Service` from a function

1. Java equivalents
    1. [`Servlet::service`](https://javaee.github.io/javaee-spec/javadocs/javax/servlet/Servlet.html#service-javax.servlet.ServletRequest-javax.servlet.ServletResponse-)
1. Golang equivalent
    1. [`Handler`](https://pkg.go.dev/net/http#Handler)    


# Other resources
1. TODO
