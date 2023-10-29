# Overview
1. TODO


# Java 21 changes

## Virtual Threads
1. Use simple "blocking" style IO with Virtual Thread
1. Alternative to CompletableFuture style development
    1. Choose either [`CompletableFuture`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/CompletableFuture.html) or Virtual Threads, not both
    1. There's no point to use with [`CompletableFuture`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/CompletableFuture.html)
1. Alternative to [`ExecutorService`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/Executors.html) style development
    1. Don't use with thread pools (there's no point)
1. Meant for IO (like [tokio](https://tokio.rs/tokio/tutorial)) and [Java NIO](https://docs.oracle.com/javase/8/docs/api/java/nio/package-summary.html)
    1. **NOT** meant CPU bound parallelism (like [rayon](https://docs.rs/rayon/latest/rayon/)) or [Parallel streams](https://docs.oracle.com/javase/tutorial/collections/streams/parallelism.html)
1. See https://openjdk.org/jeps/444
1. Performance: Usually need > 10K virtual threads to benefit


## Structured concurrency
1. [`StructuredTaskScope`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/StructuredTaskScope.html)
    1. Feels like `ExecutorService` with a better API
    1. Simpler cancellation
    1. Simpler waiting
    1. See https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/StructuredTaskScope.html
    1. See https://docs.oracle.com/en/java/javase/21/core/structured-concurrency.html
    1. [`fork`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/StructuredTaskScope.html#fork(java.util.concurrent.Callable)) subtasks, then [`join`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/StructuredTaskScope.html#join())
    1. See https://openjdk.org/jeps/453


## [Scoped Values](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/ScopedValue.html)
1. TODO:


# Other resources


