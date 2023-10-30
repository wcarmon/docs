# Overview
1. Info on Latch


# Classes
## [`CountDownLatch`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/CountDownLatch.html)
1. Not-reusable, Single-use barrier (once count reaches zero, the value never changes, no reset)
1. Useful for coordinating 2+ threads
    1. 1+ waiters invoking [`await`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/CountDownLatch.html#await())
    1. 1+ "signalers" invoking [`countDown`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/CountDownLatch.html#countDown())
1. Useful for fan-out, fan-in pattern
1. Useful for waiting for events (eg. test assertions waiting for code to finish)
1. [C++ equivalent: `latch`](https://en.cppreference.com/w/cpp/thread/latch)
1. [Golang equivalent: `WaitGroup`](https://pkg.go.dev/sync#WaitGroup)
1. Rust doesn't seem to have an equivalent (you can roll your own with [`std::sync::Mutex`](https://doc.rust-lang.org/std/sync/struct.Mutex.html) and [`std::sync::Condvar`](https://doc.rust-lang.org/std/sync/struct.Condvar.html))


# Other resources
1. https://howtodoinjava.com/java/multi-threading/when-to-use-countdownlatch-java-concurrency-example-tutorial/
1. https://www.javatpoint.com/countdownlatch-in-java
