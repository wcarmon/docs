# Overview
1. Cheatsheet on common [Data Structures](https://en.wikipedia.org/wiki/Abstract_data_type)
1. See also: [Concurrent Data Structures doc](./data-structures.concurrent.md)

# Cheatsheet

<details>
    <summary>Show All</summary>

# Basic
1. Array (known, fixed size at compile time, stack allocated)
1. Growable Array (eg. [`Vec`](https://doc.rust-lang.org/std/vec/struct.Vec.html), [`ArrayList`](https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/util/ArrayList.html))
1. ~~Linked List~~


# Adapters
1. [RingBuffer, Circular buffer](https://en.wikipedia.org/wiki/Circular_buffer)
    1. Backed by Array or Growable Array
    1. Two pointers to head & tail
    1. `O(1)` push, pop and lookup
    1. Useful for FIFO and LIFO
    1. Avoids overflows
    1. Easy to drop oldest data
1. Stack (LIFO)
    1. Backed by Array or Growable Array or Ring Buffer or Linked List
    1. Useful for ... TODO
1. Queue (FIFO)
    1. Backed by Array or Growable Array or Ring Buffer or Linked List
    1. Useful for ... TODO
1. [HashMap](https://en.wikipedia.org/wiki/Hash_table)
    1. `O(1)` lookup & insert
    1. Array of buckets
        1. Each bucket has a linked list or tree
1. [Heap, PriorityQueue](https://en.wikipedia.org/wiki/Heap_(data_structure)): [img1](./diagrams/heap-1.png), [img2](./diagrams/heap-2.png), [img3](./diagrams/heap-3.png)
    1. Partially sorted
    1. Worst case `O(Log(n))` get max (or min)
    1. Worst case `O(Log(n))` insert
    1. Useful for "Top n" items
1. Binary Tree
    1. Each node has 0, 1 or 2 children
    1. Backed by nodes with pointers or an array (children at  `2i + 1` and `2i + 2`)
        1. array items stored in breath first order
    1. Useful for ... TODO
1. Binary Search Tree (BST)
    1. TODO
    1. Useful for ... TODO
1. Graph
    1. TODO
    1. Useful for ... TODO

</details>


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

#### C++: [list](https://en.cppreference.com/w/cpp/container/list)


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

### C++: [`unordered_map`](https://en.cppreference.com/w/cpp/container/unordered_map)

### Python: [dict](TODO)


## Ordered Map

### Java: [`TreeMap`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/TreeMap.html)

### Rust: [`BTreeMap`](https://doc.rust-lang.org/std/collections/struct.BTreeMap.html)

### JS
- TODO

### Go
- TODO

### C++: [`map`](https://en.cppreference.com/w/cpp/container/map)


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
    - Growable Ring-buffer, often implemented as [a collection of fixed sized arrays](./diagrams/deque.png)
    - [`::push_back(...)`](https://doc.rust-lang.org/std/collections/struct.VecDeque.html#method.push_back)
    - [`::pop_front()`](https://doc.rust-lang.org/std/collections/struct.VecDeque.html#method.pop_front)
    - [`::is_empty()`](https://doc.rust-lang.org/std/collections/struct.VecDeque.html#method.is_empty)
    - [`::front()`](https://doc.rust-lang.org/std/collections/struct.VecDeque.html#method.front)

### JS
- TODO:

### Go
- TODO:

### C++: [deque](https://en.cppreference.com/w/cpp/container/deque)


## [Ring Buffer (Cyclic Buffer)](https://en.wikipedia.org/wiki/Circular_buffer)
1. Memory efficient (can be stack allocated)
1. Useful when you only care about the latest n-items
    1. moving average, sliding window, streaming, ...
1. Useful for FIFO or LIFO


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
1. Pre-order: current, left, right
    1. Useful for TODO
1. In-order:  left, current, right
    1. Useful for sorted iteration
1. Post-order: left, right, current
    1. Useful for deleting file tree

### Java
<details>
    <summary>Interview</summary>

```java
class Node {
    int value;
    Node left;
    Node right;
}
```

</details>

<details>
    <summary>In practice</summary>

```java
public record Node<T>(
        T value,
        @Nullable Node<T> left,
        @Nullable Node<T> right) {

    Node {
        requireNonNull(value, "value is required and null.");
    }
}
```

</details>

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
# Advanced Data Structures
- Should never need for an interview
- Sometimes useful in practice

<details>
    <summary>Show All</summary>

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

</details>


# Other resources
1. https://www.mygreatlearning.com/blog/data-structures-using-java/
1. https://doc.rust-lang.org/std/collections/
