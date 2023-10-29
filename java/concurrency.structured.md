# Overview
1. TODO


# Java 21 changes

## Virtual Threads
- Meant for IO (like [tokio](https://tokio.rs/tokio/tutorial)) and [Java NIO](https://docs.oracle.com/javase/8/docs/api/java/nio/package-summary.html)
- **NOT** meant CPU bound parallelism (like [rayon](https://docs.rs/rayon/latest/rayon/)) or [Parallel streams](https://docs.oracle.com/javase/tutorial/collections/streams/parallelism.html)


## Structured concurrency
1. [`StructuredTaskScope`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/StructuredTaskScope.html)
    1. Feels like `ExecutorService` with a better API
    1. Simpler cancellation
    1. Simpler waiting
    1. See https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/StructuredTaskScope.html
    1. See https://docs.oracle.com/en/java/javase/21/core/structured-concurrency.html


## Scoped Values
1. TODO:


# Other resources
1. https://openjdk.org/jeps/453

