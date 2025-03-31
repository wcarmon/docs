# Overview
1. TODO


# General
1. Avoid [Locks](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/locks/package-summary.html)
    1. `synchronized` uses an implicit lock/mutex
    1. Locks always have shared data
    1. Locks always require memory barriers
1. [CAS](https://en.wikipedia.org/wiki/Compare-and-swap) or [`compareAndSet`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/atomic/package-summary.html) is the "workhorse" of lock-free programming
    1. atomic hardware instruction
    1. [ABA problem](https://en.wikipedia.org/wiki/ABA_problem)
    1. Much cheaper than a lock
1. `volatile` is the next most important tool for lock-free    
1. Minimize sharing
    1. Use [Thread-Locals](https://docs.oracle.com/en/java/javase/21/core/thread-local-variables.html)
    1. choose different algorithms
1. Just solve your use case, not all use cases
    1. optimize around the problem's constraints    
    1. Relax assumptions & guarantees
        1. optimizations available for Single producer, single consumer, fixed collection size, etc


# volatile
1. Visibility:
    1. writes to a `volatile` are variable **always** visible to **all** threads (as opposed to cached/stale value)
    1. any thread that reads a field will see most recently written value
1. Perf
    1. More efficient & granular than a lock
    1. There is a cost (lost hardware optimizations)
1. Thread Safety:
    1. Does **NOT** provide thread-safety in general
    1. Only safe for **one** writer and multiple readers
1. Implemented as a [memory barrier/fence](https://en.wikipedia.org/wiki/Memory_barrier) in the CPU
    1. prevent [instruction reordering](https://en.wikipedia.org/wiki/Memory_ordering) (hardware optimization)
    1. barrier/fence implementation is CPU specific (L1 cache/registers/...)


# Data structures
1. Threadsafe data structures may require different interface to wrap multiple operations into a single method
    1. eg.  ([`compareAndSet`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/atomic/AtomicLong.html#compareAndSet(long,long)), [`putIfAbsent`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/ConcurrentHashMap.html#putIfAbsent(K,V)), etc)


## Lock-free Queue
1. TODO


## Lock-free Stack
1. TODO


# Unorganized
1. Cache padding
1. for lock-free, think in terms of transactions
1. Wait-free: all threads can make progress
1. wait-free & lock-free avoid deadlocks, livelocks, priority inversion, convoying
1. wait-free & lock-free are automatically reentrant
1. false sharing & cache lines
1. scoped variables for virtual threads
1. TODO: measure via jmh, black hole, ...
1. TODO: memory fence: Acquire, Release, ...
1. TODO: VarHandles


# Other resources
1. TODO
