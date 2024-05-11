# Overview

1. Body concept in [hyper](https://hyper.rs/)
1. See the [hyper overview doc](./hyper.md)
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


# Body [Trait](https://docs.rs/hyper/latest/hyper/body/trait.Body.html) (parent [module](https://docs.rs/hyper/latest/hyper/body/index.html))

1. For **streaming** Request/Response body
1. Minimizes memory footprint
1. Supports [backpressure](https://medium.com/@jayphelps/backpressure-explained-the-flow-of-data-through-software-2350b3e77ce7), ([another nice article](https://github.com/ReactiveX/RxJava/wiki/Backpressure))
1. [`Body` Trait](https://docs.rs/hyper/latest/hyper/body/trait.Body.html) has [`poll_frame`](https://docs.rs/hyper/latest/hyper/body/trait.Body.html#tymethod.poll_frame) method, which asynchronously yields a [Frame](https://docs.rs/hyper/latest/hyper/body/struct.Frame.html)
    1. See above for `Frame`
1. [http_body_util](https://docs.rs/http-body-util/latest/http_body_util/) crate has utils for building `Body` implementations


# [http_body_util::combinators::`BoxBody`](https://docs.rs/http-body-util/latest/http_body_util/combinators/struct.BoxBody.html)

1. a `Body` type
1. Backed by a [bytes::buf::`Buf`](https://docs.rs/bytes/latest/bytes/buf/trait.Buf.html)
1. Useful for large files, [WebSockets](https://www.pubnub.com/guides/websockets/), long-lived web connections, etc
1. [Threadsafe](https://docs.rs/http-body-util/0.1.1/http_body_util/combinators/struct.BoxBody.html#impl-Send-for-BoxBody%3CD,+E%3E)
1. Asynchronous (non-blocking)
1. Memory efficient
1. Can represent infinite data since it's streaming
    1. Puts on the heap (using [`Box`](https://doc.rust-lang.org/std/boxed/struct.Box.html))
1. `BoxBody` has [two generics](https://docs.rs/http-body-util/0.1.1/http_body_util/combinators/struct.BoxBody.html#method.new) to set associated types on [`Body` trait](https://docs.rs/http-body/latest/http_body/trait.Body.html)
1. Internals:
    1. inner data is [pinned](https://rust-lang.github.io/async-book/04_pinning/01_chapter.html) (so it works with [futures](https://tokio.rs/tokio/tutorial/async))
    1. [Pins](https://doc.rust-lang.org/std/boxed/struct.Box.html#method.pin) (cannot move in memory)


## [hyper::body::`Incomming`](https://docs.rs/hyper/latest/hyper/body/struct.Incoming.html)

1. a [`Body`](https://docs.rs/hyper/latest/hyper/body/struct.Incoming.html#impl-Body-for-Incoming) type
1. For receiving ...
    1. input for an http server
    1. response for an http client
1. hyper builds and provides these (users should not build `Incomming`)

## [http_body_util::`Empty`](https://docs.rs/http-body-util/latest/http_body_util/struct.Empty.html)

1. a `Body` type with no data

## [http_body_util::`Full`](https://docs.rs/http-body-util/latest/http_body_util/struct.Full.html)

1. a `Body` type with one single chunk
    1. What is a chunk? [answer-1](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Transfer-Encoding), [answer-2](https://en.wikipedia.org/wiki/Chunked_transfer_encoding), [answer-3](https://bunny.net/academy/http/what-is-chunked-encoding/) 

## [`std::String`](https://doc.rust-lang.org/nightly/alloc/string/struct.String.html) Body

1. standard String [impl Body](https://docs.rs/hyper/latest/hyper/body/trait.Body.html#impl-Body-for-String)



## [http_body_util::`StreamBody`](TODO)

1. a `Body` created from a (futures) [`Stream`](https://docs.rs/futures-core/0.3.30/futures_core/stream/trait.Stream.html)
1. connects [`futures_core`](https://docs.rs/futures-core/0.3.30/futures_core/index.html) crate to hyper crate


## [http_body_util::`Limited`](https://docs.rs/http-body-util/0.1.1/http_body_util/struct.Limited.html)

1. TODO
