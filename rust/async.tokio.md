# Overview

1. Examples of how to use async code smoothly with other rust features
1. Key concepts for async with [tokio](https://docs.rs/tokio/latest/tokio/)


# Key Concepts
1. Tokio [Task](TODO)s are "green-threads" managed by the tokio runtime
    1.  Similar to Golang goroutines or Kotlin coroutines
1. Future: TODO


## [`async` block](TODO)
1. Prefer regular functions & async blocks over ~~async functions~~
1. `async` block builds and returns a [`Future`](https://doc.rust-lang.org/nightly/core/future/trait.Future.html)
1. Related tokio functions/methods:
    - [`tokio::runtime::Handle::spawn`](https://docs.rs/tokio/latest/tokio/runtime/struct.Handle.html#method.spawn)
    - [`tokio::runtime::Runtime::spawn`](https://docs.rs/tokio/latest/tokio/runtime/struct.Runtime.html#method.spawn)
    - [`tokio::spawn`](https://docs.rs/tokio/latest/tokio/task/fn.spawn.html)
    - [`tokio::runtime::Handle::block_on`](https://docs.rs/tokio/latest/tokio/runtime/struct.Handle.html#method.block_on)
    - [`tokio::runtime::Runtime::block_on`](https://docs.rs/tokio/latest/tokio/runtime/struct.Runtime.html#method.block_on)
1. `::spawn` calls create a [`tokio::task::JoinHandle`](https://tikv.github.io/doc/tokio/task/struct.JoinHandle.html)


## [`async fn`](https://doc.rust-lang.org/std/keyword.async.html)
1. **Avoid these**
    1. They don't play well with Traits
    1. [They are infectious](https://journal.stuffwithstuff.com/2015/02/01/what-color-is-your-function/)
1. `async fn` defines a fn which operates asynchronously
1. returns a [Future](https://doc.rust-lang.org/std/future/trait.Future.html)
1. rust compiler transforms `async fn` into an asynchronous routing (at compile time)
1. Each call to [`.await`](https://doc.rust-lang.org/std/keyword.await.html) within the `async fn` **yield** control back to the thread
    1. The thread may do other work while the operation processes in the background.
1. Related tokio functions/methods:
    - ~~`tokio::runtime::Handle::enter`~~
    - ~~`tokio::runtime::Runtime::enter`~~
    - ~~`tokio::runtime::Handle::spawn_blocking`~~
    - ~~`tokio::task::spawn_blocking`~~


# Create a new [Runtime](https://tikv.github.io/doc/tokio/runtime/index.html)
```rust
    let max_threads = 4;
    let rt = runtime::Builder::new_multi_thread()
        .worker_threads(max_threads)
        .enable_all()       // Handle both IO futures and Timer futures
        .build()
        .expect("failed to build tokio runtime");
```

- Create a new Runtime based on current thread (not as useful)
```rust
    let rt = runtime::Builder::new_current_thread()
        .enable_all()       // Handle both IO futures and Timer futures
        .build()
        .context("failed to build tokio runtime")?;
```


# Example: Async task in background
- `tokio::task::spawn` may execute on same or different thread (tokio runtime decides)
- [Task](https://docs.rs/tokio/latest/tokio/task/) may not complete (eg. when [Runtime shutdown](https://docs.rs/tokio/latest/tokio/runtime/struct.Runtime.html#method.shutdown_background), [JoinHandle::abort](https://docs.rs/tokio/latest/tokio/task/struct.JoinHandle.html#method.abort), etc.)
- Same for `Runtime::spawn`, `Handle::spawn`, `tokio::spawn`
```rust
    let handle: JoinHandle<Result<u32, anyhow::Error>> = rt.spawn(async move {
        // ... do something here ...

        Ok(3)
    });

    // -- Wait, blocking current thread
    let res = rt.block_on(handle);

    // -- Outer Result jas JoinError
    let res = match res {
        Ok(inner_res) => inner_res,
        Err(source) => {
            return Err(MyError::FailedToJoinTask(source)) // with custom error type
            // return Err(anyhow::Error::from(source)) // with anyhow
        }
    };

    // -- Inner Result has your custom error type (from the async block)
    let value = match res {
        Ok(v) => v,
        Err(source) => return Err(source),
    };

    assert_eq!(value, 3);
```

# Example: Async task in foreground
- Same for `Runtime::block_on`, `Handle::block_on`
```rust

    // NOTE: ::block_on returns whatever future resolves to
    let res: Result<u16, anyhow::Error> = rt.block_on(async move {

        // -- Sleep example
        tokio::time::sleep(
            std::time::Duration::from_secs(1)).await;

        Ok(7)
    });

    let v = match res {
        Ok(v) => v,
        Err(e) => return Err(e),
    };

    assert_eq!(v, 7);
```
- NOTE: `#[tokio::main]` expands to `::block_on`


# Accessing the current Runtime
```rust
// TODO
```



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
- https://docs.rs/tokio/latest/tokio/task/index.html


# Other Resources

1. https://rust-lang.github.io/async-book/
1. https://rust-lang.github.io/async-book/01_getting_started/04_async_await_primer.html
1. https://blog.logrocket.com/a-practical-guide-to-async-in-rust/
