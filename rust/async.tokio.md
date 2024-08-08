# Overview

1. TODO

# Tokio

1. [`async fn`](https://doc.rust-lang.org/std/keyword.async.html)
    1. `async fn` defines a fn which operates asynchronously
    1. returns a [Future](https://doc.rust-lang.org/std/future/trait.Future.html)
    1. rust compiler transforms `async fn` into an asynchronous routing (at compile time)
    1. Each call to [`.await`](https://doc.rust-lang.org/std/keyword.await.html) within the `async fn` **yield** control back to the thread
       . The thread may do other work while the operation processes in the background.


# Sync to async
1. Use existing runtime (eg. either on `fn main` or some `runtime::Builder` on the call stack)
```rust
    let rt = Handle::current(); // use previously configured runtime

    // NOTE: .block_on(...) returns whatever T the Future<T> returns
    // NOTE: notice this is an async block, not an async closure
    let res = rt.block_on(async move {
        do_something().await
    });

    // here res is whatever the async block returns
```

1. Build runner based on current thread
```rust
    let rt = runtime::Builder::new_current()
        .enable_all()       // Handles both IO futures and Timer futures
        .build()
        .context("failed to build tokio runtime")?;

    // NOTE: ::block_on returns whatever T the future returns
    let res = rt.block_on(async move || {
        do_something().await()
    });

    // res is whatever the async block returns
```

# TODO/Unorganized

- https://rust-lang.github.io/async-book/01_getting_started/02_why_async.html
- https://rust-lang.github.io/async-book/01_getting_started/04_async_await_primer.html
- https://rust-lang.github.io/async-book/02_execution/02_future.html

# Other Resources

1. https://rust-lang.github.io/async-book/
1. https://rust-lang.github.io/async-book/01_getting_started/04_async_await_primer.html
1. https://blog.logrocket.com/a-practical-guide-to-async-in-rust/
