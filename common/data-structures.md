# Overview
1. Info on common [Data Structures](https://en.wikipedia.org/wiki/Abstract_data_type)
1. See [Concurrent Data Structures doc](./data-structures.concurrent.md)
1. See [Cheatsheet](./data-structures.cheatsheet.md)

# Fundamental Structures
- All are Single-Threaded

## ArrayList, Vector (Growable, Heap-allocated, Sequentially)

### Java: [`ArrayList`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayList.html)

### Rust: [`Vec`](https://doc.rust-lang.org/std/vec/struct.Vec.html)

### JS: [`Array`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)

### Go: [slice](https://pkg.go.dev/slices)

### C++: [`vector`](https://en.cppreference.com/w/cpp/container/vector)

### Python: [`List`](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists)

## ~~Linked List~~
- Only useful for interviews, [rarely useful in practice](../java/collections.no_linkedlist.md)


--------
# Adapter Containers (Single-Threaded)

## HashMap, HashTable (Associative Array)

<details>
    <summary>Java</summary>

- [`HashMap`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/HashMap.html)
- Backed by `Entry<K,V>[]`

```java
// TODO
```

</details>

<details>
    <summary>Rust</summary>

- [`HashMap`](https://doc.rust-lang.org/std/collections/struct.HashMap.html)

```rust
// TODO
```

</details>


<details>
    <summary>JS</summary>

- [`Map`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map) or [`object`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)

```js
// TODO
```

</details>


<details>
    <summary>Golang</summary>

- [`map`](https://go.dev/blog/maps)

```go
// TODO
```

</details>

<details>
    <summary>C++</summary>

- [`unordered_map`](https://en.cppreference.com/w/cpp/container/unordered_map)

```c++
// TODO
```

</details>


## Ordered Map

<details>
    <summary>Java</summary>

- [`TreeMap`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/TreeMap.html)

```java
// TODO
```

</details>

<details>
    <summary>Rust</summary>

- [`BTreeMap`](https://doc.rust-lang.org/std/collections/struct.BTreeMap.html)
```rust
// TODO
```

</details>

<details>
    <summary>JS</summary>

- TODO

```js
// TODO
```

</details>

<details>
    <summary>Golang</summary>

- TODO
```go
// TODO
```

</details>

<details>
    <summary>C++</summary>

- [`map`](https://en.cppreference.com/w/cpp/container/map)
```c++
// TODO
```

</details>


## Stack, LIFO
- Backed by Array or Growable Array or Ring Buffer

<details>
    <summary>Java</summary>

- Use [`ArrayList`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayList.html) (behind [`SequencedCollection`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/SequencedCollection.html) reference)
    - Backed by Array (not threadsafe, not `synchronized`)
    - Avoid [~~`java.util.Stack`~~](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/Stack.html) (backed by [`Vector`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Vector.html) which uses `synchronized`, threadsafe, but slow)
    - [`.add()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayList.html#add(java.lang.Object)) (like `::push`)
    - [`.removeLast()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayList.html#removeLast()) (like `::pop`)
    - [`.isEmpty()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayList.html#isEmpty())
    - [`.get(x.size() - 1)`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayList.html#getLast()) (like `::peek`)

</details>

<details>
    <summary>Rust</summary>

- Use [`Vec`](https://doc.rust-lang.org/std/vec/struct.Vec.html)
    - [`::push(...)`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.push)
    - [`::pop()`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.pop)
    - [`::is_empty()`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.is_empty)
    - [`::last()`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.last) (like `::peek`)

</details>


<details>
    <summary>JS</summary>

- TODO

</details>

<details>
    <summary>Golang</summary>

- TODO

</details>


## Queue, FIFO
- Backed by Array or Growable Array or Ring Buffer ~~or Linked List~~

<details>
    <summary>Java</summary>

- Use [`ArrayDeque`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayDeque.html) (standard Java)
    - Avoid [~~`LinkedList`~~](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/LinkedList.html) for anything other than interviews
    - [`.offerLast(...)`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayDeque.html#offerLast(E))
    - [`.pollFirst()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayDeque.html#pollFirst())
    - [`.isEmpty()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/ArrayDeque.html#isEmpty())
    - [`.peekFirst()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/Deque.html#peekFirst())

</details>

<details>
    <summary>Rust</summary>

- Use [`VecDeque`](https://doc.rust-lang.org/std/collections/struct.VecDeque.html)
    - Growable Ring-buffer, often implemented as [a collection of fixed sized arrays](./diagrams/deque.png)
    - [`::push_back(...)`](https://doc.rust-lang.org/std/collections/struct.VecDeque.html#method.push_back)
    - [`::pop_front()`](https://doc.rust-lang.org/std/collections/struct.VecDeque.html#method.pop_front)
    - [`::is_empty()`](https://doc.rust-lang.org/std/collections/struct.VecDeque.html#method.is_empty)
    - [`::front()`](https://doc.rust-lang.org/std/collections/struct.VecDeque.html#method.front)

</details>


<details>
    <summary>JS</summary>

- TODO:

</details>


<details>
    <summary>Golang</summary>

- TODO:

</details>


<details>
    <summary>C++</summary>

- Use [`deque`](https://en.cppreference.com/w/cpp/container/deque)

</details>


## [Ring Buffer (Cyclic Buffer)](https://en.wikipedia.org/wiki/Circular_buffer)
1. `O(1)` push, pop and lookup
1. Easy to drop oldest data
1. Useful for FIFO or LIFO
1. Useful when you only care about the latest n-items
    1. moving average, sliding window, streaming, ...
1. Memory efficient (can be stack allocated in some languages)
    1. Backed by Array or Growable Array
    1. Avoids overflows
1. Impl: "arraylike" with two pointers to `head` & `tail`

<details>
    <summary>Java</summary>

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

</details>

<details>
    <summary>Rust</summary>

- Use [`VecDeque`](https://doc.rust-lang.org/std/collections/struct.VecDeque.html)
    - Growable Ring-buffer
    - (same as Queue above)

```rust
// TODO
```

</details>

<details>
    <summary>JS</summary>

- TODO

```js
// TODO
```

</details>

<details>
    <summary>Golang</summary>

- TODO

```go
// TODO
```

</details>


## Heap, Priority Queue
- Worst case `O(log(n))` for both insert and removal

<details>
    <summary>Java</summary>

- Use [`PriorityQueue`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/PriorityQueue.html) (**min**-heap)
    - Backed by `Object[]`, growable
    - [`.offer(...)`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/PriorityQueue.html#offer(E))
    - [`.poll()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/PriorityQueue.html#poll()) (remove smallest)
    - [`.isEmpty()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/AbstractCollection.html#isEmpty())
    - [`.peek()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/PriorityQueue.html#peek())

</details>

<details>
    <summary>Rust</summary>

- Use [`BinaryHeap`](https://doc.rust-lang.org/stable/std/collections/struct.BinaryHeap.html) (**max**-heap)
    - Backed by [`Vec`](https://doc.rust-lang.org/stable/std/vec/struct.Vec.html), growable
    - [`::push(...)`](https://doc.rust-lang.org/stable/std/collections/struct.BinaryHeap.html#method.push)
    - [`::pop()`](https://doc.rust-lang.org/stable/std/collections/struct.BinaryHeap.html#method.pop) (remove largest)
    - [`::peek()`](https://doc.rust-lang.org/stable/std/collections/struct.BinaryHeap.html#method.peek)
    - [`::is_empty()`](https://doc.rust-lang.org/stable/std/collections/struct.BinaryHeap.html#method.is_empty)

</details>

<details>
    <summary>JS</summary>

- TODO

```js
// TODO
```

</details>


<details>
    <summary>Golang</summary>

- TODO: https://pkg.go.dev/container/heap

```go
// TODO
```

</details>

<details>
    <summary>C++</summary>

- [`priority_queue`](https://en.cppreference.com/w/cpp/container/priority_queue)

</details>

<details>
    <summary>Python</summary>

- [`heapq`](https://docs.python.org/3/library/heapq.html)

</details>


## Binary Tree
1. Pre-order: current, left, right
    1. Useful for TODO
1. In-order:  left, current, right
    1. Useful for sorted iteration
1. Post-order: left, right, current
    1. Useful for deleting file tree

<details>
    <summary>Java</summary>

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

<details>
    <summary>Rust</summary>

- TODO
```rust
// TODO
```

</details>

<details>
    <summary>JS</summary>

- TODO
```js
// TODO
```

</details>

<details>
    <summary>Golang</summary>

- TODO
```go
// TODO
```

</details>


## Binary Search Tree

<details>
    <summary>Java</summary>

- TODO
```java
// TODO
```

</details>

<details>
    <summary>Rust</summary>

- TODO
```rust
// TODO
```

</details>

<details>
    <summary>JS</summary>

- TODO
```js
// TODO
```

</details>

<details>
    <summary>Golang</summary>

- TODO
```go
// TODO
```

</details>


## Graph

<details>
    <summary>Java</summary>

- TODO
```java
// TODO
```

</details>

<details>
    <summary>Rust</summary>

- TODO
```rust
// TODO
```

</details>

<details>
    <summary>JS</summary>

- TODO
```js
// TODO
```

</details>

<details>
    <summary>Golang</summary>

- TODO
```go
// TODO
```

</details>


## Set

<details>
    <summary>Java</summary>

- TODO
```java
// TODO
```

</details>

<details>
    <summary>Rust</summary>

- TODO
```rust
// TODO
```

</details>

<details>
    <summary>JS</summary>

- TODO
```js
// TODO
```

</details>

<details>
    <summary>Golang</summary>

- TODO
```go
// TODO
```

</details>


--------
# Advanced Data Structures
- Should never need for an interview
- Sometimes useful in practice

## Trie

<details>
    <summary>Java</summary>

- TODO: evaluate: https://commons.apache.org/proper/commons-collections/javadocs/api-4.4/org/apache/commons/collections4/trie/PatriciaTrie.html
- TODO: evaluate: https://commons.apache.org/proper/commons-collections/javadocs/api-4.4/org/apache/commons/collections4/trie/UnmodifiableTrie.html

```rust
// TODO
```

</details>

<details>
    <summary>Rust</summary>

- TODO
```rust
// TODO
```

</details>

<details>
    <summary>JS</summary>

- TODO
```js
// TODO
```

</details>

<details>
    <summary>Golang</summary>

- TODO
```go
// TODO
```

</details>


## Treap
<details>
    <summary>Java</summary>

- TODO
```java
// TODO
```

</details>

<details>
    <summary>Rust</summary>

- TODO
```rust
// TODO
```

</details>

<details>
    <summary>JS</summary>

- TODO
```js
// TODO
```

</details>

<details>
    <summary>Golang</summary>

- TODO
```go
// TODO
```

</details>


## BloomFilter

<details>
    <summary>Java</summary>

- TODO
```java
// TODO
```

</details>

<details>
    <summary>Rust</summary>

- TODO
```rust
// TODO
```

</details>

<details>
    <summary>JS</summary>

- TODO
```js
// TODO
```

</details>

<details>
    <summary>Golang</summary>

- TODO
```go
// TODO
```

</details>

# HyperLogLog

<details>
    <summary>Java</summary>

- TODO
```java
// TODO
```

</details>

<details>
    <summary>Rust</summary>

- TODO
```rust
// TODO
```

</details>

<details>
    <summary>JS</summary>

- TODO
```js
// TODO
```

</details>

<details>
    <summary>Golang</summary>

- TODO
```go
// TODO
```

</details>

## Merkle Tree

<details>
    <summary>Java</summary>

- TODO
```java
// TODO
```

</details>

<details>
    <summary>Rust</summary>

- TODO
```rust
// TODO
```

</details>

<details>
    <summary>JS</summary>

- TODO
```js
// TODO
```

</details>

<details>
    <summary>Golang</summary>

- TODO
```go
// TODO
```

</details>

## MultiSet, Bag
- `Set` performance, but allowing duplicates (counted)

<details>
    <summary>Java</summary>

- TODO: evaluate: https://commons.apache.org/proper/commons-collections/javadocs/api-4.4/org/apache/commons/collections4/bag/HashBag.html
- TODO: evaluate: https://commons.apache.org/proper/commons-collections/javadocs/api-4.4/org/apache/commons/collections4/bag/TreeBag.html

```java
// TODO
```

</details>

<details>
    <summary>Rust</summary>

- TODO
```rust
// TODO
```

</details>

<details>
    <summary>JS</summary>

- TODO
```js
// TODO
```

</details>

<details>
    <summary>Golang</summary>

- TODO
```go
// TODO
```

</details>



# Other resources
1. https://www.mygreatlearning.com/blog/data-structures-using-java/
1. https://doc.rust-lang.org/std/collections/
