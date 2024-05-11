# Overview

1. Request & Response concepts in [hyper](https://hyper.rs/)
1. See the [hyper Overview doc](./hyper.md)
1. See the [hyper Body doc](./hyper.body.md)


# [bytes::buf::`Buf`](https://docs.rs/bytes/latest/bytes/buf/trait.Buf.html) trait

1. part of [tokio `bytes` crate](https://github.com/tokio-rs/bytes)
1. Think: cursor over contiguous bytes
1. Efficient iterator over bytes (`u8`)
1. Convenient for parsing
1. Guarantees operations are infallible
    1. Do something reasonable at the edge cases: [Example-1](https://docs.rs/bytes/latest/bytes/buf/trait.Buf.html#implementer-notes-1)
    1. Simplifies edge cases detection: [Example-1](https://docs.rs/bytes/latest/bytes/buf/trait.Buf.html#method.has_remaining))
1. [Reading advances the cursor](https://docs.rs/bytes/latest/bytes/buf/trait.Buf.html#method.get_u8)
1. Implemented by ...
    1. [`&[u8]`](https://docs.rs/bytes/latest/bytes/buf/trait.Buf.html#impl-Buf-for-%26%5Bu8%5D)  <-- **meaning** byte [slice](https://doc.rust-lang.org/std/primitive.slice.html)
    1. [`VecDeque<u8>`](https://docs.rs/bytes/latest/bytes/buf/trait.Buf.html#impl-Buf-for-VecDeque%3Cu8%3E)
    1. [`std::io::Cursor`](https://doc.rust-lang.org/nightly/std/io/struct.Cursor.html)
    1. `Bytes` (see below)
1. Java equivalents: 
    1. [`io.netty.buffer.ByteBuf`](https://netty.io/4.1/api/io/netty/buffer/ByteBuf.html) - Closest comparable, equally convenient
    1. [`java.nio.ByteBuffer`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/nio/ByteBuffer.html) - Core, inconvenient 


# [bytes::`Bytes`](https://docs.rs/bytes/latest/bytes/struct.Bytes.html) struct

1. Implements `bytes::buf::Buf` (see above)
1. contiguous memory
1. Convenient for networking programming
    1. [sliceable](https://docs.rs/bytes/latest/bytes/struct.Bytes.html#method.slice)
1. Multiple `Bytes` objects can safely point to the same memory
    1. Avoids copying
    1. Implemented via reference counting
1. Can easily convert from ...
    1. [`Box<[u8]>`](https://docs.rs/hyper/latest/hyper/body/struct.Bytes.html#impl-From%3CBox%3C%5Bu8%5D%3E%3E-for-Bytes)
    1. [`String`](https://docs.rs/hyper/latest/hyper/body/struct.Bytes.html#impl-From%3CString%3E-for-Bytes)
    1. [`Vec<u8>]`](https://docs.rs/hyper/latest/hyper/body/struct.Bytes.html#impl-From%3CVec%3Cu8%3E%3E-for-Bytes)
    1. [byte string literal](https://docs.rs/hyper/latest/hyper/body/struct.Bytes.html#impl-From%3C%26%5Bu8%5D%3E-for-Bytes) like [`b"foobar"`](https://doc.rust-lang.org/reference/tokens.html#byte-literals)    
    1. [string literal](https://docs.rs/hyper/latest/hyper/body/struct.Bytes.html#impl-From%3C%26str%3E-for-Bytes) like [`"foobar"`](https://doc.rust-lang.org/reference/tokens.html#string-literals)
1. [Hyper version is almost identical](https://docs.rs/hyper/latest/hyper/body/struct.Bytes.html)
1. Internal details
    1. Underlying implementation is dynamic (uses vtable)
    1. might not be contiguous, affects [chunking](https://docs.rs/bytes/latest/bytes/buf/trait.Buf.html#tymethod.chunk)    
1. TODO: comparison to `std::io::Cursor<&[u8]>`

