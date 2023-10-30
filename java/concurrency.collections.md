# Overview
1. Typically used thread-safe collections


# [`BlockingQueue`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/BlockingQueue.html) (Sequence)
1. All implementations are thread-safe
1. Allows developer to choose blocking or non-blocking for each operation
1. Useful for multiple-producer multiple-consumer (mpmc) cases


## [`ArrayBlockingQueue`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/ArrayBlockingQueue.html)
1. Thread-safe
1. `Impl`: Backed by array (`Object[]`) & two index pointers
1. `Order`: FIFO
1. `Size`: Bounded-buffer (Fixed-size, fixed-capacity)
1. `Locking`: Uses one `ReentrantLock`


## [`LinkedBlockingQueue`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/LinkedBlockingQueue.html)
1. Thread-safe version of [`LinkedList`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/LinkedList.html)
1. `Order`: FIFO
1. `Size`: Optionally bounded size (defaults to [`Integer.MAX_VALUE`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Integer.html#MAX_VALUE))
1. `Locking`: Uses two `ReentrantLock`s


## [`LinkedBlockingDeque`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/LinkedBlockingDeque.html)
1. Thread-safe Double-linked list
1. Can treat like Stack or Queue (since double ended)


## [`PriorityBlockingQueue`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/PriorityBlockingQueue.html)
1. Thread-safe version of [`PriorityQueue`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/PriorityQueue.html)
1. `Order`: TODO
1. `Size`: Unbounded


# Maps

## [`ConcurrentHashMap`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/ConcurrentHashMap.html)
1. Thread-safe
1. Implementation:
    1. Dynamically expands when there are too many collisions
    1. Breaks underlying table into segments, each segment has a `ReentrantLock`
        1. Segmentation reduces lock contention
    1. Separates reads & writes
    1. Implementation is 6,500+ lines


## [`ConcurrentSkipListMap`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/ConcurrentSkipListMap.html)
1. Thread-safe
1. Sorted like [`TreeMap`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/TreeMap.html)


# Sets
1. TODO: set projection of ConcurrentHashMap: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/ConcurrentHashMap.html#newKeySet()
1. TODO: Concurrent Set: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/ConcurrentSkipListSet.html



# Other resources
1. TODO
