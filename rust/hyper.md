# Overview

1. Major concepts in [hyper](https://hyper.rs/)

# Concepts

## [hyper::Request](https://docs.rs/hyper/latest/hyper/struct.Request.html) struct

1. Head and (optional) Body
1. Head is of type [`Parts`](https://docs.rs/http/1.1.0/http/request/struct.Parts.html)
    1. [`url`](https://docs.rs/http/1.1.0/http/uri/struct.Uri.html)
    1. [`method`](https://docs.rs/http/1.1.0/http/method/struct.Method.html)
    1. [`headerMap`](https://docs.rs/http/1.1.0/http/header/struct.HeaderMap.html)
    1. [HTTP `version` (`1`, `1.1`, `2`, `3`)](https://docs.rs/http/1.1.0/http/version/struct.Version.html)
    1. [`Extensions`](https://docs.rs/http/1.1.0/http/struct.Extensions.html) for arbitrary key-value pairs
        1. Similar to java [ServletRequest::attributes](https://javaee.github.io/javaee-spec/javadocs/javax/servlet/ServletRequest.html#getAttribute-java.lang.String-)
1. Body can be a Stream or bytes in memory, etc

## [hyper::Response](https://docs.rs/hyper/latest/hyper/struct.Response.html) struct

1. Head and (optional) Body
1. Head is of type [`Parts`](https://docs.rs/http/1.1.0/http/response/struct.Parts.html)
    1. [`status` code](https://docs.rs/http/1.1.0/http/status/struct.StatusCode.html)
    1. [`headerMap`](https://docs.rs/http/1.1.0/http/header/struct.HeaderMap.html)
    1. [HTTP `version` (`1`, `1.1`, `2`, `3`)](https://docs.rs/http/1.1.0/http/version/struct.Version.html)
    1. [`Extensions`](https://docs.rs/http/1.1.0/http/struct.Extensions.html) for arbitrary key-value pairs
        1. Similar to java [ServletRequest::attributes](https://javaee.github.io/javaee-spec/javadocs/javax/servlet/ServletRequest.html#getAttribute-java.lang.String-)
1. Body can be a Stream or bytes in memory, etc (same as `Request`.`body`)

## Body [module](https://docs.rs/hyper/latest/hyper/body/index.html) & [trait](https://docs.rs/hyper/latest/hyper/body/trait.Body.html)

- For **Streaming** request body or response body
- Minimizes memory footprint
- [`Body` Trait](https://docs.rs/hyper/latest/hyper/body/trait.Body.html) has [`poll_frame`](https://docs.rs/hyper/latest/hyper/body/trait.Body.html#tymethod.poll_frame) method which synchronously yields a [Frame](https://docs.rs/hyper/latest/hyper/body/struct.Frame.html)

- TODO: Buf: https://docs.rs/hyper/latest/hyper/body/trait.Buf.html

### [Full](TODO)

### [BoxBody](TODO)

### [Incomming](https://docs.rs/hyper/latest/hyper/body/struct.Incoming.html)

- For receiving (input for http server, response for http client)
- hyper builds and provides

### [StreamBody](TODO)

### [Frame](https://docs.rs/hyper/latest/hyper/body/struct.Frame.html)

1. TODO

## [ReaderStream](TODO)

## [Bytes](TODO)

1. TODO: https://docs.rs/hyper/latest/hyper/body/struct.Bytes.html
1. TODO: Bytes crate

TODO: http_body_util::BodyStream

- TODO: https://docs.rs/http-body-util/0.1.1/http_body_util/combinators/struct.BoxBody.html
- TODO: https://docs.rs/http-body-util/0.1.1/http_body_util/struct.Limited.html
- TODO: https://docs.rs/http-body-util/0.1.1/http_body_util/struct.Full.html (single chunk)
    - NOTE: http2 uses alternative chunking methods

# Other Resources

1. TODO
