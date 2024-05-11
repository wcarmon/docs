# Overview

1. `Request` & `Response` concepts in [hyper](https://hyper.rs/)
1. See the [hyper overview doc](./hyper.md)
1. See the [hyper Body doc](./hyper.body.md)

# [http::`Request`](https://docs.rs/hyper/latest/hyper/struct.Request.html) struct

1. `Request` has [Head](https://docs.rs/http/1.1.0/src/http/request.rs.html#159) and (optional) [Body](https://docs.rs/http/1.1.0/src/http/request.rs.html#160)
1. Head is of type [`http::request::Parts`](https://docs.rs/http/1.1.0/http/request/struct.Parts.html)
    1. [`url`](https://docs.rs/http/1.1.0/http/uri/struct.Uri.html)
    1. [`method`](https://docs.rs/http/1.1.0/http/method/struct.Method.html)
    1. [`headerMap`](https://docs.rs/http/1.1.0/http/header/struct.HeaderMap.html)
    1. [HTTP `version`](https://docs.rs/http/1.1.0/http/version/struct.Version.html) (`1`, `1.1`, `2`, `3`)
    1. [`Extensions`](https://docs.rs/http/1.1.0/http/struct.Extensions.html) for arbitrary key-value pairs
        1. Similar to Java [`ServletRequest::attributes`](https://javaee.github.io/javaee-spec/javadocs/javax/servlet/ServletRequest.html#getAttribute-java.lang.String-)
1. Body can be a stream, bytes in memory, etc

# [http::`Response`](https://docs.rs/hyper/latest/hyper/struct.Response.html) struct

1. `Response` has [Head](https://docs.rs/http/1.1.0/src/http/response.rs.html#181) and (optional) [Body](https://docs.rs/http/1.1.0/src/http/response.rs.html#182)
1. Head is of type [`http::response::Parts`](https://docs.rs/http/1.1.0/http/response/struct.Parts.html)
    1. [`status` code](https://docs.rs/http/1.1.0/http/status/struct.StatusCode.html)
    1. [`headerMap`](https://docs.rs/http/1.1.0/http/header/struct.HeaderMap.html)
    1. [HTTP `version`](https://docs.rs/http/1.1.0/http/version/struct.Version.html) (`1`, `1.1`, `2`, `3`)
    1. [`Extensions`](https://docs.rs/http/1.1.0/http/struct.Extensions.html) for arbitrary key-value pairs
        1. Similar to Java [`ServletRequest::attributes`](https://javaee.github.io/javaee-spec/javadocs/javax/servlet/ServletRequest.html#getAttribute-java.lang.String-)
1. Body can be a stream, bytes in memory, etc (same as `Request`.`body`)
1. `Response` has one generic param (for the body)


## Construction
1. Via [builder](https://docs.rs/hyper/latest/hyper/struct.Response.html#method.builder) 
    1. Useful for setting [`status`](https://doc.servo.org/http/response/struct.Builder.html#method.status), [`body`](https://doc.servo.org/http/response/struct.Builder.html#method.body), [`header`](https://doc.servo.org/http/response/struct.Builder.html#method.header), and [`extensions`](https://doc.servo.org/http/response/struct.Builder.html#method.extensions_mut)
1. Via [`::new`](https://docs.rs/hyper/latest/hyper/struct.Response.html#method.new)
    1. Useful for setting just the body


## Understanding Common Examples

### `Response<BoxBody<Bytes, anyhow::Error>>`
1. `Response` struct has a [`Body`](https://docs.rs/http/1.1.0/src/http/response.rs.html#182) 
1. `Response` struct has one generic for the body type, 
    1. ... currently bound to [`http_body_util::combinators::BoxBody`](https://docs.rs/http-body-util/latest/http_body_util/combinators/struct.BoxBody.html) 
1. `BoxBody` struct is a Body type
1. `BoxBody` struct has two generic params 
    1. `Data` type set to `Bytes` struct
    1. `Error` type set to `anyhow::Error`
    1. These align with the two associated types on [`Body` trait](https://docs.rs/http-body/latest/http_body/trait.Body.html)
1. `BoxBody` struct is backed by a [`Buf`](https://docs.rs/bytes/latest/bytes/buf/trait.Buf.html) impl (currently [`bytes::Bytes`](https://docs.rs/bytes/latest/bytes/struct.Bytes.html) struct)    

### `Response<Empty<Bytes>>`
1. `Response` struct has a [`Body`](https://docs.rs/http/1.1.0/src/http/response.rs.html#182)
1. `Response` body type (generic) is ([`Empty`](https://docs.rs/http-body-util/latest/http_body_util/struct.Empty.html))
1. `Empty` struct is a Body type 
1. `Empty` struct has two generics
    1. `Body` is **always** empty
    1. `Error` is [`Infallible`](https://doc.rust-lang.org/nightly/core/convert/enum.Infallible.html)

### `Response<Full<Bytes>>`
1. `Response` struct has a [`Body`](https://docs.rs/http/1.1.0/src/http/response.rs.html#182)
1. TODO
1. `Full` struct is a Body type
1. TODO
1. TODO
1. TODO

