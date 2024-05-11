# Overview

1. Body concept in [hyper](https://hyper.rs/)


# Body [module](https://docs.rs/hyper/latest/hyper/body/index.html) & [trait](https://docs.rs/hyper/latest/hyper/body/trait.Body.html)

- For **streaming** request/response body
- Minimizes memory footprint
- Supports backpressure
- [`Body` Trait](https://docs.rs/hyper/latest/hyper/body/trait.Body.html) has [`poll_frame`](https://docs.rs/hyper/latest/hyper/body/trait.Body.html#tymethod.poll_frame) method which asynchronously yields a [Frame](https://docs.rs/hyper/latest/hyper/body/struct.Frame.html)
- [http_body_util](https://docs.rs/http-body-util/latest/http_body_util/) crate has utils for building `Body` implementations

# [http_body_util::combinators::`BoxBody`](https://docs.rs/http-body-util/0.1.1/http_body_util/combinators/struct.BoxBody.html)

1. a `Body` backed by a [bytes::buf::`Buf`](https://docs.rs/bytes/latest/bytes/buf/trait.Buf.html)
1. Useful for large files, [WebSockets](https://www.pubnub.com/guides/websockets/), long-lived web connections, etc
1. Threadsafe
1. Asynchronous (non-blocking)
1. Memory efficient
1. Can represent infinite data since it's streaming
1. Internals:
    1. inner data is [pinned](https://rust-lang.github.io/async-book/04_pinning/01_chapter.html) (so it works with futures)


## [`std::String`](https://doc.rust-lang.org/nightly/alloc/string/struct.String.html) Body

1. standard String [impl Body](https://docs.rs/hyper/latest/hyper/body/trait.Body.html#impl-Body-for-String)


## [`Incomming`](https://docs.rs/hyper/latest/hyper/body/struct.Incoming.html)

1. a [`Body`](https://docs.rs/hyper/latest/hyper/body/struct.Incoming.html#impl-Body-for-Incoming)
1. For receiving ...
    1. input for an http server
    1. response for an http client
1. hyper builds and provides these (users should not build `Incomming`)

## [http_body_util::`Empty`](https://docs.rs/http-body-util/latest/http_body_util/struct.Empty.html)

1. a `Body` with no data

## [http_body_util::`Full`](https://docs.rs/http-body-util/latest/http_body_util/struct.Full.html)

1. a `Body` with one single chunk
    1. What is a chunk? [answer-1](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Transfer-Encoding), [answer-2](https://en.wikipedia.org/wiki/Chunked_transfer_encoding), [answer-3](https://bunny.net/academy/http/what-is-chunked-encoding/) 

## [http_body_util::`StreamBody`](TODO)

1. a `Body` created from a (futures) [`Stream`](https://docs.rs/futures-core/0.3.30/futures_core/stream/trait.Stream.html)
1. connects [`futures_core`](https://docs.rs/futures-core/0.3.30/futures_core/index.html) crate to hyper crate

## [http_body_util::`BoxBody`](https://docs.rs/http-body-util/latest/http_body_util/combinators/struct.BoxBody.html)

1. a `Body` ... TODO
1. TODO: when useful?
1. Puts on the heap (using [`Box`](https://doc.rust-lang.org/std/boxed/struct.Box.html))
1. [Pins](https://doc.rust-lang.org/std/boxed/struct.Box.html#method.pin) (cannot move in memory)


## [http_body_util::`Limited`](https://docs.rs/http-body-util/0.1.1/http_body_util/struct.Limited.html)

1. TODO

## [Frame](https://docs.rs/hyper/latest/hyper/body/struct.Frame.html)

1. See https://developer.mozilla.org/en-US/docs/Web/HTTP/Messages#http2_frames
1. See https://datatracker.ietf.org/doc/html/rfc7540#section-4

1. TODO: https://tokio.rs/tokio/tutorial/framing
