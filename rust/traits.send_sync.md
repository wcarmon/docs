# Overview
1. Comparison between [`Send`](https://doc.rust-lang.org/std/marker/trait.Send.html) and [`Sync`](https://doc.rust-lang.org/std/marker/trait.Sync.html) Traits


# [Send](https://doc.rust-lang.org/std/marker/trait.Send.html)
1. Think: move & ownership
1. Auto-implemented by the compiler when applicable ([unsafe trait](https://doc.rust-lang.org/book/ch19-01-unsafe-rust.html))
1. [Transferrable (Can **move**)](https://google.github.io/comprehensive-rust/memory-management/move.html) across threads
1. (Mostly) a superset of [`Sync`](https://doc.rust-lang.org/std/marker/trait.Sync.html) Trait (less restrictive than [`Sync`](https://doc.rust-lang.org/std/marker/trait.Sync.html))
1. Implies [destructor](https://doc.rust-lang.org/nomicon/destructors.html) can run in a different thread

## Not `Send`
1. `!Send`: means `T` is locked to the thread which created it (single threaded)
1. Counter examples:
    1. [`Rc`](https://doc.rust-lang.org/std/rc/struct.Rc.html)
    1. [`MutexGuard`](https://doc.rust-lang.org/std/sync/struct.MutexGuard.html)


# [Sync](https://doc.rust-lang.org/std/marker/trait.Sync.html)
1. Think: Shared references
1. Safe to **share** a read-only reference across threads
1. Safe to **move** a read-only reference across threads
1. Means "Threadsafe"
1. Auto-implemented by the compiler when applicable ([unsafe trait](https://doc.rust-lang.org/book/ch19-01-unsafe-rust.html))
1. (Mostly) a subset of `Send` Trait (even more strict than `Send`)
1. Examples
    1. All "primitives"
    1. Most standard types
    1. [`Arc`](https://doc.rust-lang.org/std/sync/struct.Arc.html)
    1. [`Mutex`](https://doc.rust-lang.org/std/sync/struct.Mutex.html) - usually, but depends on what it wraps

## Not `Sync`
1. `!Sync`: means shared references to `T` are locked to the thread
1. Counter examples: (generally because of unsynchronized [Internal Mutability](https://doc.rust-lang.org/reference/interior-mutability.html))
    1. [`Cell`](https://doc.rust-lang.org/std/cell/struct.Cell.html)
    1. [`RefCell`](https://doc.rust-lang.org/std/cell/struct.RefCell.html)
    1. [`Rc`](https://doc.rust-lang.org/std/rc/struct.Rc.html)
    1. [`MutexGuard`](https://doc.rust-lang.org/std/sync/struct.MutexGuard.html)


# `Send` and `!Sync`
1. Generally because of interior mutability
1. Can always wrap these in a [`Mutex`](https://doc.rust-lang.org/std/sync/struct.Mutex.html)
1. Examples
    1. [`Cell`](https://doc.rust-lang.org/std/cell/struct.Cell.html)
    1. [`RefCell`](https://doc.rust-lang.org/std/cell/struct.RefCell.html)
    1. [`mpsc::Receiver`](https://doc.rust-lang.org/std/sync/mpsc/struct.Receiver.html)


# Other Resources
1. https://doc.rust-lang.org/nomicon/send-and-sync.html
1. https://doc.rust-lang.org/book/ch16-04-extensible-concurrency-sync-and-send.html
1. https://google.github.io/comprehensive-rust/concurrency/send-sync.html
1. https://stackoverflow.com/questions/59428096/understanding-the-send-trait
1. http://web.mit.edu/rust-lang_v1.25/arch/amd64_ubuntu1404/share/doc/rust/html/nomicon/send-and-sync.html
1. https://google.github.io/comprehensive-rust/memory-management/move.html

