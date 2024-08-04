# Overview
1. Cheatsheet on common [Data Structures](https://en.wikipedia.org/wiki/Abstract_data_type)


# Fundamental Structures (Single-Threaded)

## ArrayList, Vector (Growable, Heap allocated Sequentially)

### Java: [`ArrayList`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayList.html)

### Rust: [`Vec`](https://doc.rust-lang.org/std/vec/struct.Vec.html)

### JS: [`Array`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)

### Go: [slice](https://pkg.go.dev/slices)

### C++: [`vector`](https://en.cppreference.com/w/cpp/container/vector)

### Python: [`List`](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists)



## ~~Linked List~~
- Only useful for interviews, [rarely useful in practice](../java/collections.no_linkedlist.md)

### Single linked (only for interviews)

#### Java
- TODO

#### Rust
- TODO

#### JS
- TODO

#### Go
- TODO

### Double linked (only for interviews)

#### Java
- Use [`LinkedList`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/LinkedList.html)
- TODO: Make a simple `Record`

#### Rust
- TODO: https://doc.rust-lang.org/std/collections/struct.LinkedList.html
- TODO: Make a `struct` <-- TODO: non-trivial because of Option, Pin, Rc, etc

#### JS
- TODO: simple object example

#### Go
- TODO: simple struct example

#### C++: [https://en.cppreference.com/w/cpp/container/list]


### Circular Linked List (only for interviews)
- TODO: Java
- TODO: Rust
- TODO: JS
- TODO: Go


--------
# Adapter Containers (Single-Threaded)

## HashMap, HashTable (Associative Array)
### Java: [`HashMap`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/HashMap.html)
- Backed by `Entry<K,V>[]`

### Rust: [`HashMap`](https://doc.rust-lang.org/std/collections/struct.HashMap.html)

### JS: [`Map`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map) or [`object`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)

### Go: [`map`](https://go.dev/blog/maps)

### C++: [https://en.cppreference.com/w/cpp/container/unordered_map](TODO)

### Python: [dict](TODO)


## Ordered Map

### Java: [`TreeMap`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/TreeMap.html)

### Rust: [`BTreeMap`](https://doc.rust-lang.org/std/collections/struct.BTreeMap.html)

### JS
- TODO

### Go
- TODO


## Stack, LIFO

### Java
- Use [`ArrayList`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayList.html) (behind [`SequencedCollection`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/SequencedCollection.html) reference)
    - Backed by Array (not threadsafe, not `synchronized`)
    - In practice, better than `java.util.Stack`
    - [`.add()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayList.html#add(java.lang.Object)) (like `::push`)
    - [`.removeLast()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayList.html#removeLast()) (like `::pop`)
    - [`.isEmpty()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayList.html#isEmpty())
    - [`.get(x.size() - 1)`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayList.html#getLast()) (like `::peek`)

- Only for interviews, use [`Stack`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/Stack.html)
    - Backed by [`Vector`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Vector.html), which is `synchronized` (threadsafe, but slow)
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

### JS
- TODO:

### Golang
- TODO:


## Queue, FIFO

### Java

- Use [`ArrayDeque`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayDeque.html) (standard Java)
    - [`.offerLast(...)`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayDeque.html#offerLast(E))
    - [`.pollFirst()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayDeque.html#pollFirst())
    - [`.isEmpty()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayDeque.html#isEmpty())
    - [`.peekFirst()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/Deque.html#peekFirst())

- For interviews, use [`LinkedList`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/LinkedList.html)
    - [`.offer(...)`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/Queue.html#offer(E))
    - [`.poll()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/Queue.html#poll())
    - [`.peek()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/Queue.html#peek())
    - [`.isEmpty()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/Collection.html#isEmpty())


### Rust

- Use [`VecDeque`](https://doc.rust-lang.org/std/collections/struct.VecDeque.html)
    - Growable Ring-buffer
    - [`::push_back(...)`](https://doc.rust-lang.org/std/collections/struct.VecDeque.html#method.push_back)
    - [`::pop_front()`](https://doc.rust-lang.org/std/collections/struct.VecDeque.html#method.pop_front)
    - [`::is_empty()`](https://doc.rust-lang.org/std/collections/struct.VecDeque.html#method.is_empty)
    - [`::front()`](https://doc.rust-lang.org/std/collections/struct.VecDeque.html#method.front)

### JS
- TODO:

### Go
- TODO:

### C++: [deque](https://en.cppreference.com/w/cpp/container/deque)


## Ring Buffer (Cyclic Buffer)

### Java

- Use [`ArrayDeque`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayDeque.html) (standard Java)
    - [`.offerLast(...)`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayDeque.html#offerLast(E))
    - [`.pollFirst()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayDeque.html#pollFirst())
    - [`.isEmpty()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayDeque.html#isEmpty())
    - [`.peekFirst()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/Deque.html#peekFirst())
- 3rd party alternatives
    - Guava [`EvictingQueue`](https://www.javadoc.io/doc/com.google.guava/guava/latest/com/google/common/collect/EvictingQueue.html)
        - [`.add(...)`](https://guava.dev/releases/15.0/api/docs/com/google/common/collect/EvictingQueue.html#add(E))
        - [`.poll()`](https://guava.dev/releases/15.0/api/docs/com/google/common/collect/ForwardingQueue.html#poll())
        - [`.isEmpty()`](https://guava.dev/releases/15.0/api/docs/com/google/common/collect/ForwardingCollection.html#isEmpty())
        - [`.peek()`](https://guava.dev/releases/15.0/api/docs/com/google/common/collect/ForwardingQueue.html#peek())
    - Apache Commons [`CircularFifoQueue`](https://commons.apache.org/proper/commons-collections/javadocs/api-4.4/org/apache/commons/collections4/queue/CircularFifoQueue.html)

### Rust
- Use [`VecDeque`](https://doc.rust-lang.org/std/collections/struct.VecDeque.html)
    - Growable Ring-buffer
    - (same as Queue above)

### JS
- TODO

### Go
- TODO


## Heap, Priority Queue
- Worst case `O(log(n))` for both insert and removal

### Java
- Use [`PriorityQueue`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/PriorityQueue.html) (**min**-heap)
    - Backed by `Object[]`, growable
    - [`.offer(...)`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/PriorityQueue.html#offer(E))
    - [`.poll()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/PriorityQueue.html#poll()) (remove smallest)
    - [`.isEmpty()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/AbstractCollection.html#isEmpty())
    - [`.peek()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/PriorityQueue.html#peek())

### Rust
- Use [`BinaryHeap`](https://doc.rust-lang.org/stable/std/collections/struct.BinaryHeap.html) (**max**-heap)
    - Backed by [`Vec`](https://doc.rust-lang.org/stable/std/vec/struct.Vec.html), growable
    - [`::push(...)`](https://doc.rust-lang.org/stable/std/collections/struct.BinaryHeap.html#method.push)
    - [`::pop()`](https://doc.rust-lang.org/stable/std/collections/struct.BinaryHeap.html#method.pop) (remove largest)
    - [`::peek()`](https://doc.rust-lang.org/stable/std/collections/struct.BinaryHeap.html#method.peek)
    - [`::is_empty()`](https://doc.rust-lang.org/stable/std/collections/struct.BinaryHeap.html#method.is_empty)

### JS
- TODO

### Go
- TODO: https://pkg.go.dev/container/heap

### C++: [`priority_queue`](https://en.cppreference.com/w/cpp/container/priority_queue)

### Python: [`heapq`](https://docs.python.org/3/library/heapq.html)


## Binary Tree

### Java
- TODO

### Rust
- TODO

### JS
- TODO

### Go
- TODO


## Binary Search Tree

### Java
- TODO

### Rust
- TODO

### JS
- TODO

### Go
- TODO


## Graph

### Java
- TODO

### Rust
- TODO

### JS
- TODO

### Go
- TODO


## Set

### Java
- TODO

### Rust
- TODO

### JS
- TODO

### Go
- TODO


--------
# Concurrent
1. `Wait-free`: Uses Atomics: [Java](https://docs.oracle.com/javase/tutorial/essential/concurrency/atomicvars.html), [Rust](https://doc.rust-lang.org/std/sync/atomic/index.html)
    - Non-blocking
    - Generally simple
    - No spin-loops, no CAS
1. `Lock-free`: Uses [compare-and-swap CPU instructions](https://en.wikipedia.org/wiki/Compare-and-swap) in spin loop (maybe with backoff)
    - Non-blocking
    - Very hard to implement correctly
    - Memory management is hard in non-GC languages
    - Risks:
        - [ABA problem](https://en.wikipedia.org/wiki/ABA_problem)
            - Summary: Assume if value is `A`, it hasn't changed
        - Too much Retry/throw-away work
1. `Lock-based`: Uses mutex or Lock
    - Blocking
    - Generally slower than other options
    - Easy to reason about
    - Risks:
        - [priority inversion](TODO)
        - [deadlock](TODO)


## Threadsafe Map (Lock/Mutex based)

### Java
- Use [`ConcurrentHashMap`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ConcurrentHashMap.html) (unordered)
    - Uses granular `ReentrantLock`s (enclosed class `Segment` extends `ReentrantLock`)


### Rust
- TODO: https://docs.rs/dashmap/latest/dashmap/struct.DashMap.html (uses RwLock & Cache padding to avoid false sharing)
- TODO: https://github.com/komora-io/concurrent-map (lock free)
- TODO: https://docs.rs/chashmap/latest/chashmap/ (granular Locks)
- TODO: scc (lockfree) - https://github.com/wvwwvwwv/scalable-concurrent-containers/?tab=readme-ov-file#hashmap

### JS
- TODO

### Go
- TODO


## Threadsafe Map (Lock-free)

### Java
- Use [`ConcurrentSkipListMap`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ConcurrentSkipListMap.html) (ordered)
    -

### Rust
- TODO https://github.com/crossbeam-rs/crossbeam/tree/master/crossbeam-skiplist

### JS
### Go



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

### Java
- TODO:

### Rust
- TODO: https://docs.rs/crossbeam/latest/crossbeam/queue/struct.ArrayQueue.html

### JS
- TODO

### Go
- TODO


## Queue: SPMC
- TODO: Java
- TODO: Rust
- TODO: JS
- TODO: Go


## Queue: MPMC

### Java
- https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ArrayBlockingQueue.html
- https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/ConcurrentLinkedDeque.html
- https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/concurrent/LinkedBlockingQueue.html

### Rust
- TODO:

### JS
- TODO

### Go
- TODO


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
