# Overview

1. Body concept in [hyper](https://hyper.rs/)
1. See the [hyper Overview doc](./hyper.md)
1. See [hyper Request & Response doc](./hyper.req-res.md) also
1. See [Bytes doc](./hyper.bytes.md) also


## [Frame](https://docs.rs/hyper/latest/hyper/body/struct.Frame.html)

1. A `Frame` is the smallest unit of communication in http/2
1. A `Frame` is the smallest unit of data transmitted between two peers
1. Each `Frame` can arrive in any order
1. Heavily used in http/2
    1. http/2 frames are binary encoded
    1. http/2 frames from multiple streams can interleave
    1. Each http/2 frame has a header (with streamId)
    1. See https://developer.mozilla.org/en-US/docs/Web/HTTP/Messages#http2_frames
    1. See https://datatracker.ietf.org/doc/html/rfc7540#section-4
    1. http/1 has messages, http/2 breaks messages into frames
1. Concept Relationships:
    1. `Connection` -|---|< `Stream`
    1. `Stream` -|---|< `Message` 
    1. `Message` -|---|< `Frame`
1. Other resources
    1. https://tokio.rs/tokio/tutorial/framing


# [`Body` Trait](https://docs.rs/hyper/latest/hyper/body/trait.Body.html) ([parent module](https://docs.rs/hyper/latest/hyper/body/index.html))

1. For **streaming** Request/Response body
1. Minimizes memory footprint
1. Supports [backpressure](https://medium.com/@jayphelps/backpressure-explained-the-flow-of-data-through-software-2350b3e77ce7), ([another nice article](https://github.com/ReactiveX/RxJava/wiki/Backpressure))
1. [`Body` Trait](https://docs.rs/hyper/latest/hyper/body/trait.Body.html) has [`poll_frame`](https://docs.rs/hyper/latest/hyper/body/trait.Body.html#tymethod.poll_frame) method, which asynchronously yields a [Frame](https://docs.rs/hyper/latest/hyper/body/struct.Frame.html)
    1. See above for `Frame`
1. [http_body_util](https://docs.rs/http-body-util/latest/http_body_util/) crate has util functions for building `Body` implementations


# [http_body_util::combinators::`BoxBody`](https://docs.rs/http-body-util/latest/http_body_util/combinators/struct.BoxBody.html) struct

1. A `Body` type
1. Backed by a [bytes::buf::`Buf`](https://docs.rs/bytes/latest/bytes/buf/trait.Buf.html) impl
1. [Threadsafe](https://docs.rs/http-body-util/0.1.1/http_body_util/combinators/struct.BoxBody.html#impl-Send-for-BoxBody%3CD,+E%3E)
1. Asynchronous (therefore non-blocking)
1. Memory efficient
1. Useful for large files, [WebSockets](https://www.pubnub.com/guides/websockets/), long-lived web connections, etc
1. Can represent infinite data since it's streaming
    1. Puts on the heap (using [`Box`](https://doc.rust-lang.org/std/boxed/struct.Box.html))
1. `BoxBody` has [two generics](https://docs.rs/http-body-util/0.1.1/http_body_util/combinators/struct.BoxBody.html#method.new) 
    1. so it can bind associated types on [`Body` trait](https://docs.rs/http-body/latest/http_body/trait.Body.html)
1. Internals:
    1. inner data is [pinned](https://rust-lang.github.io/async-book/04_pinning/01_chapter.html) (so it works with [futures](https://tokio.rs/tokio/tutorial/async))
    1. [Pins](https://doc.rust-lang.org/std/boxed/struct.Box.html#method.pin) (cannot move in memory)

## Construction
1. Via [`BoxBody::new`](https://docs.rs/http-body-util/latest/http_body_util/combinators/struct.BoxBody.html#method.new)
1. Via `Body.boxed()` 
    1. See [BodyExt::boxed()](https://docs.rs/http-body-util/latest/http_body_util/trait.BodyExt.html#method.boxed)
    1. See [`Body` impl `BodyExt`](https://docs.rs/http-body-util/latest/http_body_util/trait.BodyExt.html#impl-BodyExt-for-T)
    

## Convert error type to anyhow
```rust
    let box_body = BoxBody::new(body)
        .map_err(|err| anyhow!(err))   // or .map_err(anyhow::Error::from)
        .boxed();
```


## [hyper::body::`Incomming`](https://docs.rs/hyper/latest/hyper/body/struct.Incoming.html) struct

1. A [`Body`](https://docs.rs/hyper/latest/hyper/body/struct.Incoming.html#impl-Body-for-Incoming) type for receiving ...
    1. http server: requests
    1. http client: responses
1. hyper builds and provides these 
    1. developers should **NOT** build `Incomming`
1. `Incomming` struct has two generics    
    1. `Data` is [`bytes::Bytes`](https://docs.rs/bytes/latest/bytes/struct.Bytes.html) struct
    1. `Error` is [hyper::Error](https://docs.rs/hyper/latest/hyper/struct.Error.html)


## [http_body_util::`Empty`](https://docs.rs/http-body-util/latest/http_body_util/struct.Empty.html) struct

1. A `Body` type with no data
1. `Empty` struct has two generics
    1. `Body` is **always** empty
    1. `Error` is [`Infallible`](https://doc.rust-lang.org/nightly/core/convert/enum.Infallible.html)


## [http_body_util::`Full`](https://docs.rs/http-body-util/latest/http_body_util/struct.Full.html) struct

1. A `Body` type with one single chunk
    1. What is a chunk? [answer-1](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Transfer-Encoding), [answer-2](https://en.wikipedia.org/wiki/Chunked_transfer_encoding), [answer-3](https://bunny.net/academy/http/what-is-chunked-encoding/)
1. Useful for returning string error messages      
1. `Full` struct has two generics
    1. `Data` is some `Buf` impl          
    1. `Error` is [`Infallible`](https://doc.rust-lang.org/nightly/core/convert/enum.Infallible.html)


## [`std::String`](https://doc.rust-lang.org/nightly/alloc/string/struct.String.html)

1. standard String [impl Body](https://docs.rs/hyper/latest/hyper/body/trait.Body.html#impl-Body-for-String)
    1. `Data` is [`bytes::Bytes`](https://docs.rs/bytes/latest/bytes/struct.Bytes.html) struct
    1. `Error` is [`Infallible`](https://doc.rust-lang.org/nightly/core/convert/enum.Infallible.html)


## [http_body_util::`StreamBody`](TODO)

1. a `Body` created from a (futures) [`Stream`](https://docs.rs/futures-core/0.3.30/futures_core/stream/trait.Stream.html)
1. connects [`futures_core`](https://docs.rs/futures-core/0.3.30/futures_core/index.html) crate to hyper crate


## [http_body_util::`Limited`](https://docs.rs/http-body-util/0.1.1/http_body_util/struct.Limited.html)

1. TODO


------
# Error handling

## Drop Infallible
```rust
    my_body
    .map_err(|never| match never {})
    .boxed()
```
1. See [`BodyExt`](https://docs.rs/http-body-util/latest/http_body_util/trait.BodyExt.html#)
    1. See [BodyExt::map_err(...)](https://docs.rs/http-body-util/latest/http_body_util/trait.BodyExt.html#method.map_err)
    1. See [BodyExt::boxed()](https://docs.rs/http-body-util/latest/http_body_util/trait.BodyExt.html#method.boxed)


## Convert error type to anyhow
```rust
    let box_body = BoxBody::new(body)
        .map_err(|err| anyhow!(err))   // or .map_err(anyhow::Error::from)
        .boxed();
```
