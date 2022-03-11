# Overview
1. What is garbage collection?
1. How garbage collection works on the JVM
1. Why garbage collection is important


# Table of Contents
TODO

--------
# Goals
1. Minimal pauses
1. Fast object allocation
1. Low overhead
    1. Space overhead = memory footprint
    1. Time overhead = CPU consumption, Pauses
1. Scalable to large heaps (eg. G1)


# Collector Responsibilities
1. Automated object deallocation
    1. Prevent most memory leaks & dangling pointers
    1. Reclaim unused memory
1. Object heap layout
1. Weak-reference processing
1. Class unloading
1. Object Finalization


# Trade-offs
1. Heap size vs. collection [overhead](https://en.wikipedia.org/wiki/Overhead_(computing)) (time)
    1. Larger heaps take longer to cleanup
    1. G1 solves via incremental garbage collection
1. Pause time ([Latency](https://en.wikipedia.org/wiki/Latency_(engineering))) vs. application [Throughput](https://en.wikipedia.org/wiki/Throughput#:~:text=In%20general%20terms%2C%20throughput%20is,delivery%20over%20a%20communication%20channel.)
    1. Trading between GC resources & application resources


# Typical Collection Phases

## Partial Collection (sub-regions of heap)
- **Cons**: More memory claimed per unit-of-work
- **Cons**: Must track references into collected area (Write barrier)
- **Cons**: Must coordinate with JIT compiler (TODO: WHY??)

## Full Collection (Entire heap)
- **Con**: Longer pause time (proportional to heap size)
- **Pro**: No write barrier, simpler implementation


# Impact of Pauses
- Threads executing bytecodes

## Not affected by pauses
1. JVM thread [interpreting bytecodes](https://en.wikipedia.org/wiki/Java_bytecode)
1. OS threads running native code
1. JVM code waiting on [Lock](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/concurrent/locks/Lock.html)


# More resources
1. [Official HotSpot tuning guide](https://docs.oracle.com/javase/9/gctuning/introduction-garbage-collection-tuning.htm#JSGCT-GUID-8A443184-7E07-4B71-9777-4F12947C8184)
1. [Christine H. Flood's guide](https://blogs.oracle.com/javamagazine/post/understanding-garbage-collectors)
1. [Azul C4 (pauseless)](https://www.azul.com/products/components/pgc/)
1. [other JVMs](https://docs.oracle.com/cd/E15289_01/JRSDK/garbage_collect.htm)
