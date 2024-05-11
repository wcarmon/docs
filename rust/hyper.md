# Overview

1. Major concepts in [hyper](https://hyper.rs/)

# Concepts

## [http::`Request`](https://docs.rs/hyper/latest/hyper/struct.Request.html) struct

1. Head and (optional) Body
1. Head is of type [`Parts`](https://docs.rs/http/1.1.0/http/request/struct.Parts.html)
    1. [`url`](https://docs.rs/http/1.1.0/http/uri/struct.Uri.html)
    1. [`method`](https://docs.rs/http/1.1.0/http/method/struct.Method.html)
    1. [`headerMap`](https://docs.rs/http/1.1.0/http/header/struct.HeaderMap.html)
    1. [HTTP `version`](https://docs.rs/http/1.1.0/http/version/struct.Version.html) (`1`, `1.1`, `2`, `3`)
    1. [`Extensions`](https://docs.rs/http/1.1.0/http/struct.Extensions.html) for arbitrary key-value pairs
        1. Similar to java [ServletRequest::attributes](https://javaee.github.io/javaee-spec/javadocs/javax/servlet/ServletRequest.html#getAttribute-java.lang.String-)
1. Body can be a stream, bytes in memory, etc

## [http::`Response`](https://docs.rs/hyper/latest/hyper/struct.Response.html) struct

1. Head and (optional) Body
1. Head is of type [`Parts`](https://docs.rs/http/1.1.0/http/response/struct.Parts.html)
    1. [`status` code](https://docs.rs/http/1.1.0/http/status/struct.StatusCode.html)
    1. [`headerMap`](https://docs.rs/http/1.1.0/http/header/struct.HeaderMap.html)
    1. [HTTP `version`](https://docs.rs/http/1.1.0/http/version/struct.Version.html) (`1`, `1.1`, `2`, `3`)
    1. [`Extensions`](https://docs.rs/http/1.1.0/http/struct.Extensions.html) for arbitrary key-value pairs
        1. Similar to java [ServletRequest::attributes](https://javaee.github.io/javaee-spec/javadocs/javax/servlet/ServletRequest.html#getAttribute-java.lang.String-)
1. Body can be a stream, bytes in memory, etc (same as `Request`.`body`)
1. `Response` has one generic param (for the body)


### Construction:
1. Via [builder](https://docs.rs/hyper/latest/hyper/struct.Response.html#method.builder) 
    1. Useful for setting [`status`](https://doc.servo.org/http/response/struct.Builder.html#method.status), [`body`](https://doc.servo.org/http/response/struct.Builder.html#method.body), [`header`](https://doc.servo.org/http/response/struct.Builder.html#method.header), and [extensions](https://doc.servo.org/http/response/struct.Builder.html#method.extensions_mut)
1. Via [`::new`](https://docs.rs/hyper/latest/hyper/struct.Response.html#method.new)
    1. Useful for only setting body


### Understanding Common Examples:
1. `Response<BoxBody<Bytes, anyhow::Error>>`
    1. `Response` struct has a `Body` 
    1. `Response` struct has one generic for the body type, (set to [`http_body_util::combinators::BoxBody`](https://docs.rs/http-body-util/latest/http_body_util/combinators/struct.BoxBody.html)) 
    1. `BoxBody` struct is a Body type
    1. `BoxBody` struct has two generic params 
        1. `Data` type set to `Bytes` struct
        1. `Error` type set to `anyhow::Error`
        1. These align with the two associated types on [`Body` trait](https://docs.rs/http-body/latest/http_body/trait.Body.html)
    1. `BoxBody` struct is backed by a [`Buf`](https://docs.rs/bytes/latest/bytes/buf/trait.Buf.html) impl (currently [`bytes::Bytes`](https://docs.rs/bytes/latest/bytes/struct.Bytes.html) struct)    
1. `Response<Empty<Bytes>>`
    1. `Response` struct has a `Body`
    1. `Response` body type (generic) is ([`Empty`](https://docs.rs/http-body-util/latest/http_body_util/struct.Empty.html))
    1. `Empty` struct is a Body type 
    1. `Empty` struct has two generics
        1. `Body` is **always** empty
        1. `Error` is [`Infallible`](https://doc.rust-lang.org/nightly/core/convert/enum.Infallible.html)
1. `Response<Full<Bytes>>`
    1. `Response` struct has a `Body`
    1. TODO
    1. `Full` struct is a Body type
    1. TODO
    1. TODO
    1. TODO


## Body

1. [See doc](./hyper.body.md)

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
1. TODO: comparison to `std::io::Cursor<&[u8]>`


## TODO
- TODO: http_body_util::BodyStream    
- TODO: Buf: https://docs.rs/hyper/latest/hyper/body/trait.Buf.html
- TODO: [tokio::ReaderStream](TODO)
