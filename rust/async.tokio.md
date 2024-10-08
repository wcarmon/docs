# Overview

1. Examples of how to use async code smoothly with other rust features
1. Key concepts for async with [tokio](https://docs.rs/tokio/latest/tokio/)


# Key Concepts
1. async is hard
    1. much harder than sync rust
    1. harder than async in other multithreaded languages like Java & Go
1. Tokio [Task](https://docs.rs/tokio/latest/tokio/task/index.html)s are non-blocking "green-threads" managed by the tokio runtime
    1.  Similar to Golang goroutines or Kotlin coroutines
1. [Future](https://doc.rust-lang.org/nightly/core/future/trait.Future.html): TODO
1. [Runtime](https://docs.rs/tokio/latest/tokio/runtime/struct.Runtime.html): TODO
1. [runtime::Handle](https://docs.rs/tokio/latest/tokio/runtime/struct.Handle.html): a threadsafe way to share a Runtime (more idiomatic than `Arc<Runtime>`)
1. Propagate simple types (Threadsafe, `Send + Sync`)


## [`async` block](https://doc.rust-lang.org/nightly/reference/expressions/block-expr.html#async-blocks)
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
    1. [They are infectious](https://journal.stuffwithstuff.com/2015/02/01/what-color-is-your-function/)
    1. Hard to use [standard profilers](https://nnethercote.github.io/perf-book/profiling.html) to find bottlenecks
    1. Hard to use with [`OnceLock::get_or_init`](https://doc.rust-lang.org/stable/std/sync/struct.OnceLock.html#method.get_or_init)
    1. Hard to use with [rayon scopes](https://docs.rs/rayon/latest/rayon/fn.scope.html)
    1. Hard to use with [Traits](TODO)
    1. Call stacks are overly complex & sometimes useless
    1. Still useful in functions with heavy IO (eg. Database DAO, S3, Local File system, actix handlers, etc)
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
1. [async closures]() are also async functions
    1. Good: `async move {...}`
    1. Bad: `async move || {...}`


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


# Idioms for waiting

## Option-A
- [`::spawn`](https://docs.rs/tokio/latest/tokio/runtime/struct.Handle.html#method.spawn) then [`::block_on(spawn_handle)`](https://docs.rs/tokio/latest/tokio/runtime/struct.Handle.html#method.block_on)
- Background task [example below](https://github.com/wcarmon/docs/blob/main/rust/async.tokio.md#example-async-task-in-background)

## Option-B
- [`::block_on(...)`](https://docs.rs/tokio/latest/tokio/runtime/struct.Handle.html#method.block_on)
- Foreground task [example below](https://github.com/wcarmon/docs/blob/main/rust/async.tokio.md#example-async-task-in-foreground)

## Option-C
- Channel pattern
- start a consumer [`loop`](https://doc.rust-lang.org/reference/expressions/loop-expr.html) which waits on a [`tokio::sync::mpsc`](https://docs.rs/tokio/latest/tokio/sync/mpsc/index.html)
- [crossbeam::channel](https://docs.rs/crossbeam/latest/crossbeam/channel/index.html) and [`std::sync::mpsc`](https://doc.rust-lang.org/beta/std/sync/mpsc/index.html) are much easier to use than tokio's channel
- [tokio `mpsc` example](https://docs.rs/tokio/latest/tokio/sync/mpsc/fn.channel.html#examples)
- [tokio `oneshot` example](https://docs.rs/tokio/1.40.0/tokio/sync/oneshot/index.html)


# Example: Async task in background
- Same for `Runtime::spawn`, `Handle::spawn`, `tokio::spawn`
```rust
    let handle: JoinHandle<Result<u32, anyhow::Error>> = rt.spawn(async move {
        // ... do something here ...

        Ok(3)
    });

    // ... do other things

    // -- Wait, block current thread
    let outer_res = rt.block_on(handle);

    // -- Outer Result has JoinError
    let inner_res = match outer_res {
        Ok(inner_res) => inner_res,
        Err(source) => {
            return Err(MyError::FailedToJoinTask(source)) // with custom error type
            // return Err(anyhow::Error::from(source)) // with anyhow
        }
    };

    // -- Inner Result has your custom error type (from the async block)
    let value = match inner_res {
        Ok(v) => v,
        Err(source) => return Err(source),
    };

    assert_eq!(value, 3);
```
- `tokio::task::spawn` may execute on same or different thread (tokio runtime decides)
- [Task](https://docs.rs/tokio/latest/tokio/task/) may not complete (eg. when [Runtime shutdown](https://docs.rs/tokio/latest/tokio/runtime/struct.Runtime.html#method.shutdown_background), [JoinHandle::abort](https://docs.rs/tokio/latest/tokio/task/struct.JoinHandle.html#method.abort), etc.)


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


# Manually propagate `Handle`, callee waits
- Encapsulates async
```rust
// -- Caller invokes like a normal function

fn do_some_work(rt: &Handle) -> Result<u64, anyhow::Error> {

    let h: JoinHandle<Result<u64, Error>> = rt.spawn(async move {
        // .. do something interesting ...

        Err(anyhow!("simulate ajsdlfjaklsjdfla"))
    });

    // -- Callee (this fn) waits
    rt.block_on(h)?
}
```


# Manually propagate `Handle`, caller waits
- Add to `Cargo.toml`
```toml
[dependencies]
futures = "0.3"
```

- Caller code:
```rust
    let rt = ...

    let res: Result<u64, anyhow::Error> = rt.block_on(
        // -- manually propagate the tokio::runtime::Handle
        do_some_work(rt.handle())
    );
```

- Callee code:
```rust
use futures::future::BoxFuture;
use tokio::runtime::Handle;

fn do_some_work(rt: &Handle) -> BoxFuture<'static, Result<u64, anyhow::Error>> {

    let h: JoinHandle<Result<u64, anyhow::Error>> = rt.spawn(async move {
        // .. do something interesting ...

        Err(anyhow!("simulate failure"))
    });

    // -- Return a future so the caller can wait
    Box::pin(async move {
        h.await?
    })
}
```


# Accessing the current Runtime
- Only useful for `async` functions
```rust
    // Access previously configured runtime
    // panics if called outside the tokio runtime
    //
    // propagates automatically (only) thru async functions
    // synchronous functions must pass manually
    let rt = Handle::current();
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
- https://rust-lang.github.io/async-book/04_pinning/01_chapter.html
- https://docs.rs/tokio/latest/tokio/task/index.html
- https://blog.cloudflare.com/pin-and-unpin-in-rust/


# Other Resources

1. https://rust-lang.github.io/async-book/
1. https://rust-lang.github.io/async-book/01_getting_started/04_async_await_primer.html
1. https://blog.logrocket.com/a-practical-guide-to-async-in-rust/
