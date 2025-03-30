# Overview
1. TODO


# General
1. avoid Locks
    1. `synchronized` uses an implicit lock/mutex


# volatile
1. Visibility:
    1. writes to a `volatile` are variable always visible to **all** threads (as opposed to cached/stale value)
    1. any thread that reads a field will see most recently written value
1. Perf
    1. More efficient than locks
    1. There is a cost (lost hardware optimizations)
1. Safety:
    1. Does **NOT** provide thread-safety
    1. Only safe for **one** writer and multiple readers
1. Implemented as a [memory barrier/fence](https://en.wikipedia.org/wiki/Memory_barrier) in the CPU
    1. prevent [instruction reordering](https://en.wikipedia.org/wiki/Memory_ordering) (hardware optimization)
    1. barrier/fence implementation is CPU specific (L1 cache/registers/...)


# Unorganized
1. Cache padding


# Other resources
1. TODO
