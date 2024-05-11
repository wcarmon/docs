# Overview

1. Major concepts in [hyper](https://hyper.rs/)

# Concepts

## [hyper::`Request`](https://docs.rs/hyper/latest/hyper/struct.Request.html) struct

1. Head and (optional) Body
1. Head is of type [`Parts`](https://docs.rs/http/1.1.0/http/request/struct.Parts.html)
    1. [`url`](https://docs.rs/http/1.1.0/http/uri/struct.Uri.html)
    1. [`method`](https://docs.rs/http/1.1.0/http/method/struct.Method.html)
    1. [`headerMap`](https://docs.rs/http/1.1.0/http/header/struct.HeaderMap.html)
    1. [HTTP `version`](https://docs.rs/http/1.1.0/http/version/struct.Version.html) (`1`, `1.1`, `2`, `3`)
    1. [`Extensions`](https://docs.rs/http/1.1.0/http/struct.Extensions.html) for arbitrary key-value pairs
        1. Similar to java [ServletRequest::attributes](https://javaee.github.io/javaee-spec/javadocs/javax/servlet/ServletRequest.html#getAttribute-java.lang.String-)
1. Body can be a stream, bytes in memory, etc

## [hyper::`Response`](https://docs.rs/hyper/latest/hyper/struct.Response.html) struct

1. Head and (optional) Body
1. Head is of type [`Parts`](https://docs.rs/http/1.1.0/http/response/struct.Parts.html)
    1. [`status` code](https://docs.rs/http/1.1.0/http/status/struct.StatusCode.html)
    1. [`headerMap`](https://docs.rs/http/1.1.0/http/header/struct.HeaderMap.html)
    1. [HTTP `version`](https://docs.rs/http/1.1.0/http/version/struct.Version.html) (`1`, `1.1`, `2`, `3`)
    1. [`Extensions`](https://docs.rs/http/1.1.0/http/struct.Extensions.html) for arbitrary key-value pairs
        1. Similar to java [ServletRequest::attributes](https://javaee.github.io/javaee-spec/javadocs/javax/servlet/ServletRequest.html#getAttribute-java.lang.String-)
1. Body can be a stream, bytes in memory, etc (same as `Request`.`body`)

## Body [module](https://docs.rs/hyper/latest/hyper/body/index.html) & [trait](https://docs.rs/hyper/latest/hyper/body/trait.Body.html)

- For **streaming** request/response body
- Minimizes memory footprint
- Supports backpressure
- [`Body` Trait](https://docs.rs/hyper/latest/hyper/body/trait.Body.html) has [`poll_frame`](https://docs.rs/hyper/latest/hyper/body/trait.Body.html#tymethod.poll_frame) method which asynchronously yields a [Frame](https://docs.rs/hyper/latest/hyper/body/struct.Frame.html)
- [http_body_util](https://docs.rs/http-body-util/latest/http_body_util/) crate has utils for building `Body` implementations


### [`String`](https://doc.rust-lang.org/nightly/alloc/string/struct.String.html)

1. standard String [impl Body](https://docs.rs/hyper/latest/hyper/body/trait.Body.html#impl-Body-for-String)


### [`Incomming`](https://docs.rs/hyper/latest/hyper/body/struct.Incoming.html)

1. a [`Body`](https://docs.rs/hyper/latest/hyper/body/struct.Incoming.html#impl-Body-for-Incoming)
1. For receiving ...
    1. input for an http server
    1. response for an http client
1. hyper builds and provides these (users should not build `Incomming`)

### [http_body_util::`Empty`](https://docs.rs/http-body-util/latest/http_body_util/struct.Empty.html)

1. a `Body` with no data

### [http_body_util::`Full`](https://docs.rs/http-body-util/latest/http_body_util/struct.Full.html)

1. a `Body` with one single chunk
    1. What is a chunk? [answer-1](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Transfer-Encoding), [answer-2](https://en.wikipedia.org/wiki/Chunked_transfer_encoding), [answer-3](https://bunny.net/academy/http/what-is-chunked-encoding/) 

### [http_body_util::`StreamBody`](TODO)

1. a `Body` created from a (futures) [`Stream`](https://docs.rs/futures-core/0.3.30/futures_core/stream/trait.Stream.html)
1. connects [`futures_core`](https://docs.rs/futures-core/0.3.30/futures_core/index.html) crate to hyper crate

### [http_body_util::`BoxBody`](https://docs.rs/http-body-util/latest/http_body_util/combinators/struct.BoxBody.html)

1. a `Body` ... TODO
1. TODO: when useful?
1. Puts on the heap (using [`Box`](https://doc.rust-lang.org/std/boxed/struct.Box.html))
1. [Pins](https://doc.rust-lang.org/std/boxed/struct.Box.html#method.pin) (cannot move in memory)


### [http_body_util::`Limited`](https://docs.rs/http-body-util/0.1.1/http_body_util/struct.Limited.html)

1. TODO

### [Frame](https://docs.rs/hyper/latest/hyper/body/struct.Frame.html)

1. See https://developer.mozilla.org/en-US/docs/Web/HTTP/Messages#http2_frames
1. See https://datatracker.ietf.org/doc/html/rfc7540#section-4

1. TODO: https://tokio.rs/tokio/tutorial/framing


## [bytes::buf::`Buf`](https://docs.rs/bytes/latest/bytes/buf/trait.Buf.html) trait

1. part of [tokio `bytes` crate](https://github.com/tokio-rs/bytes)
1. Think: cursor over contiguous bytes
1. Efficient iterator over bytes (`u8`)
1. Convenient for parsing
1. Guarantees operations are infallible
    1. do something reasonable at the edge cases: [Example-1](https://docs.rs/bytes/latest/bytes/buf/trait.Buf.html#implementer-notes-1)
    1. makes it easy to detect edge cases: [Example-1](https://docs.rs/bytes/latest/bytes/buf/trait.Buf.html#method.has_remaining))
1. [Reading advances the cursor](https://docs.rs/bytes/latest/bytes/buf/trait.Buf.html#method.get_u8)
1. Implemented by ...
    1. [`&[u8]`](https://docs.rs/bytes/latest/bytes/buf/trait.Buf.html#impl-Buf-for-%26%5Bu8%5D)  <-- byte [slice](https://doc.rust-lang.org/std/primitive.slice.html)
    1. [`VecDeque<u8>`](https://docs.rs/bytes/latest/bytes/buf/trait.Buf.html#impl-Buf-for-VecDeque%3Cu8%3E)
    1. [`std::io::Cursor`](https://doc.rust-lang.org/nightly/std/io/struct.Cursor.html)
    1. `Bytes` (see below)
1. Java equivalent: 
    1. [`io.netty.buffer.ByteBuf`](https://netty.io/4.1/api/io/netty/buffer/ByteBuf.html) - Closest comparable, equally convenient
    1. [`java.nio.ByteBuffer`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/nio/ByteBuffer.html) - Core, inconvenient 


## [bytes::`Bytes`](https://docs.rs/bytes/latest/bytes/struct.Bytes.html) struct

1. Implements `bytes::buf::Buf` (see above)
1. contiguous memory
1. [sliceable](https://docs.rs/bytes/latest/bytes/struct.Bytes.html#method.slice)
1. Convenient for networking programming
1. Multiple `Bytes` objects can safely point to the same memory
    1. Avoids copying
    1. Implemented via reference counting
1. Can easily convert from ...
    1. [`Box<[u8]>`](https://docs.rs/hyper/latest/hyper/body/struct.Bytes.html#impl-From%3CBox%3C%5Bu8%5D%3E%3E-for-Bytes)
    1. [`String`](https://docs.rs/hyper/latest/hyper/body/struct.Bytes.html#impl-From%3CString%3E-for-Bytes)
    1. [`Vec<u8>]`](https://docs.rs/hyper/latest/hyper/body/struct.Bytes.html#impl-From%3CVec%3Cu8%3E%3E-for-Bytes)
    1. [byte literal](https://docs.rs/hyper/latest/hyper/body/struct.Bytes.html#impl-From%3C%26%5Bu8%5D%3E-for-Bytes)    
    1. [string literal](https://docs.rs/hyper/latest/hyper/body/struct.Bytes.html#impl-From%3C%26str%3E-for-Bytes)
1. [Hyper version is almost identical](https://docs.rs/hyper/latest/hyper/body/struct.Bytes.html)
1. Internal details
    1. Underlying implementation is dynamic (uses vtable)
    1. might not be contiguous, affects [chunking](https://docs.rs/bytes/latest/bytes/buf/trait.Buf.html#tymethod.chunk)    


# TODO

- TODO: http_body_util::BodyStream
    - NOTE: http2 uses alternative chunking methods
- TODO: Buf: https://docs.rs/hyper/latest/hyper/body/trait.Buf.html
- TODO: [tokio::ReaderStream](TODO)

# Other Resources

1. TODO
