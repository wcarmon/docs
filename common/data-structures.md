# Overview
1. TODO


# Core

## Array/ArrayList/Vector
- Stored on the (thread) stack

- TODO: Java: https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayList.html
- TODO: Rust: https://doc.rust-lang.org/std/vec/struct.Vec.html
- TODO: JS:
- TODO: Go:

## Linked List
- Stored on the Heap

### Single
- TODO: Java
- TODO: Rust
- TODO: JS
- TODO: Go

### Double
- TODO: Java: https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/LinkedList.html
- TODO: Rust
- TODO: JS
- TODO: Go

### Circular
- TODO: Java
- TODO: Rust
- TODO: JS
- TODO: Go


--------
# Adapter Containers (All Single-Threaded)

## HashMap, HashTable (Associative Array)
- TODO: Java
- TODO: Rust
- TODO: JS
- TODO: Go


## Ordered Map
- TODO: Java
    - https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/TreeMap.html
- TODO: Rust
- TODO: JS
- TODO: Go


## Stack, LIFO

### Java
- Use [`ArrayList`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayList.html)
    - Backed by Array (not threadsafe, not `synchronized`)
    - Better in practice than `java.util.Stack`
    - [`.add()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayList.html#add(java.lang.Object)) (like `::push`)
    - [`.removeLast()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayList.html#removeLast()) (like `::pop`)
    - [`.isEmpty()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayList.html#isEmpty())
    - [`.getLast()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayList.html#getLast()) (like `::peek`)

- For interviews, use [`Stack`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/Stack.html)
    - Backed by [`Vector`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Vector.html), which is `synchronized` (threadsafe, but slow)
    - Better for interviews than in practice
    - [`.push()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/Stack.html#push(java.lang.Object))
    - [`.pop()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/Stack.html#pop())
    - [`.empty()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/Stack.html#empty())
    - [`.peek()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/Stack.html#peek())

### Rust
- Use [`Vec`](https://doc.rust-lang.org/std/vec/struct.Vec.html)
    - [`::push(...)`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.push)
    - [`::pop()`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.pop)
    - [`::is_empty()`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.is_empty)
    - [`::last()`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.last) (like `::peek`)
- Heap allocated

### JS
- TODO:

### Golang
- TODO:


## Queue, FIFO
- TODO: Java
    - https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/LinkedBlockingQueue.html
- TODO: Rust: https://doc.rust-lang.org/std/collections/struct.VecDeque.html
- TODO: JS
- TODO: Go


## Dequeue
- TODO: Java
    - https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayDeque.html
    - https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/LinkedBlockingDeque.html
    - https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ArrayBlockingQueue.html
- TODO: Rust
- TODO: JS
- TODO: Go


## Heap, Priority Queue
- TODO: Java
    - https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/PriorityQueue.html
- TODO: Rust
- TODO: JS
- TODO: Go


## Binary Tree
- TODO: Java
- TODO: Rust
- TODO: JS
- TODO: Go


## Binary Search Tree
- TODO: Java
- TODO: Rust
- TODO: JS
- TODO: Go


## Graph
- TODO: Java, Guava
- TODO: Rust
- TODO: JS
- TODO: Go


## Ring Buffer (Cyclic Buffer)
- TODO: Java
    - https://www.javadoc.io/doc/com.google.guava/guava/latest/com/google/common/collect/EvictingQueue.html
    - https://javadoc.io/doc/com.lmax/disruptor/latest/com.lmax.disruptor/com/lmax/disruptor/RingBuffer.html
    - https://commons.apache.org/proper/commons-collections/javadocs/api-4.4/org/apache/commons/collections4/queue/CircularFifoQueue.html
- TODO: Rust
- TODO: JS
- TODO: Go

## Set
- TODO: Java
- TODO: Rust
- TODO: JS
- TODO: Go


--------
# Concurrent

## Threadsafe Map
- TODO: Java
    - https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ConcurrentSkipListMap.html
    - https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ConcurrentHashMap.html
- TODO: Rust
- TODO: JS
- TODO: Go


## Threadsafe Set
- TODO: Java
- TODO: Rust
- TODO: JS
- TODO: Go


## Queue: SPSC
- TODO: Java
- TODO: Rust
- TODO: JS
- TODO: Go


## Queue: MPSC
- TODO: Java
- TODO: Rust
- TODO: JS
- TODO: Go


## Queue: SPMC
- TODO: Java
- TODO: Rust
- TODO: JS
- TODO: Go


## Queue: MPMC
- TODO: Java:
    - https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ConcurrentLinkedDeque.html
- TODO: Rust
- TODO: JS
- TODO: Go


## Lock-free Queue
- TODO: Java
- TODO: Rust
- TODO: JS
- TODO: Go


## Lock-free Stack
- TODO: Java
- TODO: Rust
- TODO: JS
- TODO: Go


--------
# Advanced

## Trie
- TODO: Java
    - https://commons.apache.org/proper/commons-collections/javadocs/api-4.4/org/apache/commons/collections4/trie/PatriciaTrie.html
    - https://commons.apache.org/proper/commons-collections/javadocs/api-4.4/org/apache/commons/collections4/trie/UnmodifiableTrie.html
- TODO: Rust
- TODO: JS
- TODO: Go


## Treap
- TODO: Java
- TODO: Rust
- TODO: JS
- TODO: Go


## BloomFilter
- TODO: Java
- TODO: Rust
- TODO: JS
- TODO: Go


# HyperLogLog
- TODO: Java
- TODO: Rust
- TODO: JS
- TODO: Go


## Merkle Tree
- TODO: Java
- TODO: Rust
- TODO: JS
- TODO: Go


## MultiSet, Bag
- TODO: Java
    - https://commons.apache.org/proper/commons-collections/javadocs/api-4.4/org/apache/commons/collections4/bag/HashBag.html
    - https://commons.apache.org/proper/commons-collections/javadocs/api-4.4/org/apache/commons/collections4/bag/TreeBag.html
- TODO: Rust
- TODO: JS
- TODO: Go



# Other resources
1. https://www.mygreatlearning.com/blog/data-structures-using-java/
1. https://doc.rust-lang.org/std/collections/
