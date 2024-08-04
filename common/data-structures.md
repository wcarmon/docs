# Overview
1. Cheatsheet on common [Data Structures](https://en.wikipedia.org/wiki/Abstract_data_type)


# Fundamental Structures (Single-Threaded)

## ArrayList, Vector (Growable, Heap allocated Sequentially)

### Java
- Use [`ArrayList`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayList.html)

### Rust
- Use [`Vec`](https://doc.rust-lang.org/std/vec/struct.Vec.html)

### JS
- Use [`Array`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)

### Go
- Use a [slice](https://pkg.go.dev/slices)


## ~~Linked List~~
- Only useful for interviews, [rarely useful in practice](../java/collections.no_linkedlist.md)

### Single linked
- TODO: Java
- TODO: Rust
- TODO: JS
- TODO: Go

### Double linked

#### Java
- Use [`LinkedList`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/LinkedList.html)

#### Rust
- TODO

#### JS
- TODO

#### Go
- TODO:

### Circular Linked List
- TODO: Java
- TODO: Rust
- TODO: JS
- TODO: Go


--------
# Adapter Containers (Single-Threaded)

## HashMap, HashTable (Associative Array)
### Java
- Use [`HashMap`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/HashMap.html)

### Rust
- Use [`HashMap`](https://doc.rust-lang.org/std/collections/struct.HashMap.html)

### JS
- TODO

### Go
- TODO


## Ordered Map

### Java
- Use [`TreeMap`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/TreeMap.html)

### Rust
- Use [`BTreeMap`](https://doc.rust-lang.org/std/collections/struct.BTreeMap.html)

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

### Java
- TODO: https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/PriorityQueue.html

### Rust
- TODO: https://doc.rust-lang.org/stable/std/collections/struct.BinaryHeap.html

### JS
- TODO

### Go
- TODO


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
