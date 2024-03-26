# Overview

1. TODO

# Tokio

1. [`async fn`](https://doc.rust-lang.org/std/keyword.async.html)
    1. `async fn` defines a fn which operates asynchronously
    1. returns a [Future](https://doc.rust-lang.org/std/future/trait.Future.html)
    1. rust compiler transforms `async fn` into an asynchronous routing (at compile time)
    1. Each call to [`.await`](https://doc.rust-lang.org/std/keyword.await.html) within the `async fn` **yield** control back to the thread
       . The thread may do other work while the operation processes in the background.

# TODO/Unorganized

- https://rust-lang.github.io/async-book/01_getting_started/02_why_async.html
- https://rust-lang.github.io/async-book/01_getting_started/04_async_await_primer.html
- https://rust-lang.github.io/async-book/02_execution/02_future.html

# Other Resources

1. https://rust-lang.github.io/async-book/
1. https://rust-lang.github.io/async-book/01_getting_started/04_async_await_primer.html
1. https://blog.logrocket.com/a-practical-guide-to-async-in-rust/
