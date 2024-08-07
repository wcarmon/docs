# Overview
1. Info on Concurrent [Data Structures](https://en.wikipedia.org/wiki/Abstract_data_type)
1. See also: [Data structures doc](./data-structures.md)


# Thread Safety Approaches
1. `Wait-free`
    - Uses Atomics: [Java](https://docs.oracle.com/javase/tutorial/essential/concurrency/atomicvars.html), [Rust](https://doc.rust-lang.org/std/sync/atomic/index.html)
    - `Pro`: Generally the simplest
    - `Pro`: Non-blocking
    - `Pro`: No spin-loops, no CAS, just CPU instructions
1. `Lock-free`
    - Uses [compare-and-swap CPU instructions](https://en.wikipedia.org/wiki/Compare-and-swap) in spin **loop** (maybe with backoff)
        - Also known as a `CAS` loop (compare-and-swap)
    - `Pro`: Non-blocking
    - `Con`: **Very hard** to implement correctly
        - Generally requires deferred `free` (eg. [`Rc`](https://doc.rust-lang.org/std/rc/struct.Rc.html) or [Garbage collection](https://en.wikipedia.org/wiki/Garbage_collection_(computer_science)))
        - Generally only works with simple API (eg. FIFO or LIFO)
    - `Con`: Memory management is hard in non-GC languages
    - Risks:
        - [ABA problem](https://en.wikipedia.org/wiki/ABA_problem)
            - Summary: Assume if value is `A`, it hasn't changed
        - Too much Retry/throw-away work
1. `Lock-based`
    - Uses mutex or Lock
    - `Pro`: Easy to reason about
    - `Con`: Blocking
    - `Con`: Generally slower than other options above
    - Risks:
        - [Priority Inversion](https://en.wikipedia.org/wiki/Priority_inversion)
        - [deadlock](https://en.wikipedia.org/wiki/Deadlock)

# Implementation Idioms
1. Partition the data structure into independent parts, handle them single threaded
    1. Atomically reserve parts of the structure, using AtomicRef or CAS
    1. eg. Multiple `Map<K, V>`s, Keys for one region are independent of other regions
1. Minimize the API (since each method must be protected)
1. Exploit some application specific feature
    1. eg. Some parts of the data don't change, others do
1. Test, Benchmark, keep the API simple


# Threadsafe Map (Lock/Mutex based)

## Java
- Use [`ConcurrentHashMap`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ConcurrentHashMap.html) (unordered)
    - Uses granular `ReentrantLock`s (enclosed class `Segment` extends `ReentrantLock`)


## Rust
- TODO: evaluate https://docs.rs/dashmap/latest/dashmap/struct.DashMap.html (uses RwLock & Cache padding to avoid false sharing)
- TODO: evaluate https://docs.rs/chashmap/latest/chashmap/ (granular Locks)

## Go
- TODO


# Threadsafe Map (Lock-free)

## Java: Use [`ConcurrentSkipListMap`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ConcurrentSkipListMap.html) (ordered)

## Rust:
- [crossbeam `SkipMap`](https://docs.rs/crossbeam-skiplist/latest/crossbeam_skiplist/struct.SkipMap.html) (ordered)
- TODO: evaluate https://github.com/komora-io/concurrent-map (lock free, unordered)
- TODO: evaluate https://github.com/wvwwvwwv/scalable-concurrent-containers?tab=readme-ov-file#hashmap

## Go: TODO


# Threadsafe Set
- Usually just the keys of a Threadsafe Map (Value is `bool` or empty `struct`)

- TODO: Java
- TODO: Rust
- TODO: Go


# Queue: SPSC
- TODO: Java
- TODO: Rust
- TODO: Go


# Queue: MPSC

## Java
- TODO:

## Rust
- TODO: https://docs.rs/crossbeam/latest/crossbeam/queue/struct.ArrayQueue.html
- TODO: https://doc.rust-lang.org/nightly/std/sync/mpsc/index.html (backed by crossbeam mpmc)

## Go
- TODO: ...


# Queue: MPMC

## Java
- [`ArrayBlockingQueue`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ArrayBlockingQueue.html)
- [`ConcurrentLinkedDeque`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ConcurrentLinkedDeque.html)
    - TODO: how different from one below?
- [`LinkedBlockingQueue`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/LinkedBlockingQueue.html)

## Rust
- TODO:

## Go
- TODO


# Lock-free Queue (MPMC)
- TODO: Java
- TODO: Rust
- TODO: Go


# Lock-free Stack (MPMC)
- TODO: Java
- TODO: Rust
- TODO: Go


# Lock-free, [Non-sequentially-consistency](./diagrams/sequential_consistency.png)
- (See books by Fedor Pikus)
1. Array of atomic references to single threaded structure (like `vec` or `vecdeque` or a `stack` or a `queue` or `tree`)
1. Algorithm
    1. Each thread atomically `compareAndExchange` a sub-structure with `null` or [`None`](https://doc.rust-lang.org/std/option/enum.Option.html#variant.None)
    1. If successfully acquired ...
        1. Mutate the sub-structure in single threaded mode
        1. When done, atomically `compareAndExchange` the mutated sub-structure back to the array
    1. If failed to acquired ...
        1. Try to acquire the next sub-structure, up `maxAttemptsLimit`
1. Tradeoff: processing order is not as strict since each "partition" is independent
1. [Kafka works this way](../kafka/architecture.md)

## Java: Use [`AtomicReference`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/atomic/AtomicReference.html#compareAndExchange(V,V))

## Rust: Use [crossbeam `AtomicCell`](https://docs.rs/crossbeam/latest/crossbeam/atomic/struct.AtomicCell.html#method.compare_exchange) or [std `AtomicPtr`](https://doc.rust-lang.org/nightly/std/sync/atomic/struct.AtomicPtr.html#method.compare_exchange)
