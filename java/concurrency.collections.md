# Overview
1. Typically used thread-safe collections


# [`BlockingQueue`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/BlockingQueue.html) interface (for Sequences)
1. All implementations are thread-safe
1. Allows developer to choose blocking or non-blocking for each operation
1. Useful for multiple-producer multiple-consumer (mpmc) cases


## [`ArrayBlockingQueue`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/ArrayBlockingQueue.html)
1. Thread-safe version of `array` (**NOT** `ArrayList` which grows)
1. `Impl`: Backed by array (`Object[]`) & two index pointers
1. `Order`: FIFO
1. `Size`: Bounded-buffer (fixed-size, fixed-capacity)
1. `Locking`: Uses one `ReentrantLock`
1. [C++ Equivalent](TODO)
1. [Rust Equivalent](TODO)
1. [Golang Equivalent: `channel`](../golang/concurrency.channels.md)


## [`LinkedBlockingQueue`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/LinkedBlockingQueue.html)
1. Thread-safe version of [`LinkedList`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/LinkedList.html)
1. `Order`: FIFO
1. `Size`: Optionally bounded size (defaults to [`Integer.MAX_VALUE`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Integer.html#MAX_VALUE))
1. `Locking`: Uses two `ReentrantLock`s
1. [C++ Equivalent](TODO)
1. [Rust Equivalent](TODO)


## [`PriorityBlockingQueue`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/PriorityBlockingQueue.html)
1. Thread-safe version of [`PriorityQueue`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/PriorityQueue.html)
1. `Impl`: array-based binary heap, so O(log n) for add (`add`/`offer`/`put`) and removal (`remove`/`poll`/`take`)
1. `Order`: internally unordered, but `remove`/`poll`/`take` returns smallest
1. `Size`: Unbounded
1. `Locking`: `ReentrantLock` and also some spin locking
1. [C++ Equivalent](TODO)
1. [Rust Equivalent](TODO)


# Stack ([`ConcurrentLinkedDeque`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/ConcurrentLinkedDeque.html))
1. Thread-safe [`Stack`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Stack.html)
1. `Impl`: doubly-linked nodes
1. `Order`: LIFO
1. `Size`: Unbounded
1. `Locking`: **lock-free**
1. [C++ Equivalent](TODO)
1. [Rust Equivalent](TODO)


## [`LinkedBlockingDeque`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/LinkedBlockingDeque.html)
1. Thread-safe [Double-linked list](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/LinkedList.html)
1. Can treat like thread-safe [`Stack`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Stack.html) or [`Queue`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Queue.html) (since double ended)
1. `Order`: FIFO or LIFO
1. `Size`: Optionally bounded size (defaults to [`Integer.MAX_VALUE`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Integer.html#MAX_VALUE))
1. [C++ Equivalent](TODO)
1. [Rust Equivalent](TODO)


--------

# Maps

## [`ConcurrentHashMap`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/ConcurrentHashMap.html)
1. Thread-safe
1. `Impl`:
    1. Dynamically expands when there are too many collisions
    1. Breaks underlying table into segments, each segment has a `ReentrantLock`
        1. Segmentation reduces lock contention
    1. Separates reads & writes
    1. Implementation is 6,500+ lines
1. `Order`: unordered
1. [C++ Equivalent](TODO)
1. [Rust Equivalent](TODO)
1. [Golang Equivalent: `sync.Map`](https://pkg.go.dev/sync#Map)


## [`ConcurrentSkipListMap`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/ConcurrentSkipListMap.html)
1. Thread-safe
1. `Order`: Sorted like [`TreeMap`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/TreeMap.html)
1. [C++ Equivalent](TODO)
1. [Rust Equivalent](TODO)


--------

# Sets

## HashSet (Keys of a `ConcurrentHashMap`)
1. Thread-safe
1. `Building`: [`ConcurrentHashMap::newKeySet`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/ConcurrentHashMap.html#newKeySet())
1. `Order`: Unordered
1. [C++ Equivalent](TODO)
1. [Rust Equivalent](TODO)


## [`ConcurrentSkipListSet`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/ConcurrentSkipListSet.html)
1. Thread-safe
1. `Impl`: TODO
1. `Order`: Sorted
1. `Locking`: TODO
1. [C++ Equivalent](TODO)
1. [Rust Equivalent](TODO)


# Other resources
1. TODO
