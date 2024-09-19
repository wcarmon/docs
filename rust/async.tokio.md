# Overview

1. TODO

# Tokio

1. [`async fn`](https://doc.rust-lang.org/std/keyword.async.html)
    1. `async fn` defines a fn which operates asynchronously
    1. returns a [Future](https://doc.rust-lang.org/std/future/trait.Future.html)
    1. rust compiler transforms `async fn` into an asynchronous routing (at compile time)
    1. Each call to [`.await`](https://doc.rust-lang.org/std/keyword.await.html) within the `async fn` **yield** control back to the thread
        1. The thread may do other work while the operation processes in the background.

1. [`async` block](TODO)
    1. returns a [`Future`](TODO)


# Sync to async
1. Use existing runtime (eg. either on `#[tokio::main] async fn main` or some `runtime::Builder` on the call stack)
```rust
    let rt = Handle::current(); // use previously configured runtime

    // NOTE: .block_on(...) returns whatever T the Future<T> returns
    // NOTE: notice this is an async block, not an async closure
    let res = rt.block_on(async move {
        do_something().await
    });

    // res is whatever the async block returns
```

1. Build runner based on current thread
```rust
    let rt = runtime::Builder::new_current_thread()
        .enable_all()       // Handle both IO futures and Timer futures
        .build()
        .context("failed to build tokio runtime")?;

    // NOTE: ::block_on returns whatever T the future returns
    let res = rt.block_on(async move {
        do_something_async().await
    });

    // res is whatever the async block returns
```


# Convert [Tokio `File`](https://docs.rs/tokio/latest/tokio/fs/struct.File.html) to [`Stream`](https://docs.rs/futures/latest/futures/stream/trait.Stream.html)

```rust
// Adapter
// Converts a `tokio::fs::File` into a `futures::Stream` of bytes
pub struct TokioFileToStream {
    chunk_size: usize,

    // -- Internal state mutated on each poll
    file_to_read: tokio::fs::File,

    size_hint_upper_bound: Option<usize>,
}

impl TokioFileToStream {
    pub fn from_tokio_file(
        file_to_read: tokio::fs::File,
        chunk_size: usize,
        // Optional optimization for Stream::size_hint
        file_size: Option<u64>,
    ) -> Self {
        let size_hint_upper_bound = file_size.map(|sz| (sz / chunk_size as u64) as usize);

        Self {
            chunk_size,
            size_hint_upper_bound,
            file_to_read,
        }
    }
}

impl Stream for TokioFileToStream {
    type Item = Result<Vec<u8>, anyhow::Error>;

    fn poll_next(
        mut self: Pin<&mut Self>,
        cx: &mut std::task::Context<'_>,
    ) -> Poll<Option<Self::Item>> {
        let mut buf = vec![0u8; self.chunk_size];
        let read_future = self.file_to_read.read(&mut buf[..]);

        let mut pinned = pin!(read_future);
        let poll = pinned.as_mut().poll(cx);

        // -- Chain/Adapt future
        match poll {
            Pending => Pending,

            Ready(read_count_res) => {
                let num_bytes_read = read_count_res.context("read file failed")?;

                if num_bytes_read == 0 {
                    // -- EOF
                    return Ready(None);
                }

                buf.truncate(num_bytes_read);
                Ready(Some(Ok(buf)))
            }
        }
    }

    fn size_hint(&self) -> (usize, Option<usize>) {
        (0, self.size_hint_upper_bound)
    }
}
```


# TODO/Unorganized
- Tokio Streams are like Rx Observables or Reactor Flux, etc
- TODO: AsyncRead
- https://ryhl.io/blog/async-what-is-blocking/
- https://rust-lang.github.io/async-book/01_getting_started/02_why_async.html
- https://rust-lang.github.io/async-book/01_getting_started/04_async_await_primer.html
- https://rust-lang.github.io/async-book/02_execution/02_future.html

# Other Resources

1. https://rust-lang.github.io/async-book/
1. https://rust-lang.github.io/async-book/01_getting_started/04_async_await_primer.html
1. https://blog.logrocket.com/a-practical-guide-to-async-in-rust/
