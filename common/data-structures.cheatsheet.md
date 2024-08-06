# Overview
1. Cheatsheet on common [Data Structures](https://en.wikipedia.org/wiki/Abstract_data_type) (mostly for interviews)
1. See also: [Data Structures doc](./data-structures.md)
1. See also: [Concurrent Data Structures doc](./data-structures.concurrent.md)


# Basic

## Array

<details>
    <summary>Java</summary>

- [Java Spec](https://docs.oracle.com/javase/specs/jls/se8/html/jls-10.html)
- heap allocated
- length is **NOT** part of the type

```java
// TODO: int array example
// TODO: 2d int array example
```

</details>

<details>
    <summary>Rust</summary>

- [Rust array doc](https://doc.rust-lang.org/std/primitive.array.html)
- known, fixed size at compile time, stack allocated

```rust
// TODO: int array example
// TODO: 2d int array example
```

</details>

<details>
    <summary>JS</summary>

- TODO

```js
// TODO: number array example
// TODO: 2d number array example
```

</details>


## Growable Array

<details>
    <summary>Java</summary>

- [`java.util.ArrayList`](https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/util/ArrayList.html)

```java
// TODO: number arraylist example
// TODO: 2d number arraylist example

// TODO: access item at index
// TODO: swap values at two indexes
// TODO: iterate (for loop)
// TODO: get size/length
```

</details>

<details>
    <summary>Rust</summary>

- [`Vec`](https://doc.rust-lang.org/std/vec/struct.Vec.html)

```rust
// TODO: i32 vec example
// TODO: 2d i32 vec example

// TODO: access item at index
// TODO: swap values at two indexes
// TODO: iterate (for loop)
// TODO: get size/length
```

</details>

<details>
    <summary>JS</summary>

- TODO

```js
// TODO: number array example
// TODO: 2d number array example

// TODO: access item at index
// TODO: swap values at two indexes
// TODO: iterate (for loop)
// TODO: get size/length
```

</details>


## ~~Linked List (Single)~~

<details>
    <summary>Java</summary>

```java
class Node {
    int value;
    Node next;
}
```

</details>

<details>
    <summary>Rust</summary>

```rust
// TODO
```

</details>

<details>
    <summary>JS</summary>

```js
// TODO
```

</details>


## ~~Linked List (Double)~~

<details>
    <summary>Java</summary>

- [`LinkedList`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/LinkedList.html)

- Alternative:

```java
class Node {
    int value;
    Node next;
    Node prev;
}
```

</details>

<details>
    <summary>Rust</summary>

- TODO: https://doc.rust-lang.org/std/collections/struct.LinkedList.html
- TODO: Make a `struct` <-- TODO: non-trivial because of Option, Pin, Rc, etc

```rust
//TODO
```

</details>

<details>
    <summary>JS</summary>

- simple object example
```
//TODO
```

</details>

<details>
    <summary>Golang</summary>

- TODO: simple struct example
```
//TODO
```

</details>

<details>
    <summary>C++</summary>

- [list](https://en.cppreference.com/w/cpp/container/list)
```c++
//TODO
```

</details>




# Adapters

## [Ring Buffer, Circular Buffer](https://en.wikipedia.org/wiki/Circular_buffer)
1. Backed by Array or Growable Array
1. Two pointers to `head` & `tail`
1. `O(1)` push, pop and lookup
1. Useful for FIFO and LIFO
1. Avoids overflows
1. Easy to drop oldest data

<details>
    <summary>Java</summary>

- TODO:

```java
// TODO: ...
```

</details>

<details>
    <summary>Rust</summary>

- TODO:

```rust
// TODO: ...
```

</details>

<details>
    <summary>JS</summary>

- TODO:

```js
// TODO: ...
```

</details>


## Stack (LIFO)
1. Backed by Array or Growable Array or Ring Buffer or Linked List
1. Useful for ... TODO

<details>
    <summary>Java</summary>

- Use [`java.util.Stack`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/Stack.html) (only for interviews, never in practice)
    - Backed by [`java.util.Vector`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Vector.html), which is `synchronized` (threadsafe, but slow)
    - [`.push()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/Stack.html#push(java.lang.Object))
    - [`.pop()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/Stack.html#pop())
    - [`.empty()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/Stack.html#empty())
    - [`.peek()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/Stack.html#peek())

```java
// TODO
```

</details>

<details>
    <summary>Rust</summary>

- [`Vec`](https://doc.rust-lang.org/std/vec/struct.Vec.html)

```rust
// TODO
```

</details>

<details>
    <summary>JS</summary>

- Use [`Array`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)

```js
// TODO
```

</details>


## Queue (FIFO)
1. Backed by Array or Growable Array or Ring Buffer or Linked List
1. Useful for ... TODO

<details>
    <summary>Java</summary>

- Use [`java.util.LinkedList`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/LinkedList.html)
    - [`.offer(...)`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/Queue.html#offer(E))
    - [`.poll()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/Queue.html#poll())
    - [`.peek()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/Queue.html#peek())
    - [`.isEmpty()`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F22%2Fdocs%2Fapi%2F%2F/java.base/java/util/Collection.html#isEmpty())

```java
// TODO
```

</details>

<details>
    <summary>Rust</summary>

- TODO: use ...

```rust
// TODO
```

</details>

<details>
    <summary>JS</summary>

- TODO: use ...

```js
// TODO
```

</details>


## [HashMap](https://en.wikipedia.org/wiki/Hash_table)
1. `O(1)` lookup & insert
1. Array of buckets
    1. Each "bucket" has a Linked List or Binary Tree

<details>
    <summary>Java</summary>

- TODO: use ...

```java
// TODO
```

</details>

<details>
    <summary>Rust</summary>

- TODO: use ...

```rust
// TODO
```

</details>

<details>
    <summary>JS</summary>

- TODO: use ...

```js
// TODO
```

</details>


## [Heap, PriorityQueue](https://en.wikipedia.org/wiki/Heap_(data_structure)): [img-1](./diagrams/heap-1.png), [img-2](./diagrams/heap-2.png), [img-3](./diagrams/heap-3.png)
1. Partially sorted
1. Worst case `O(Log(n))` get max (or min)
1. Worst case `O(Log(n))` insert
1. Useful for "Top n" items

<details>
    <summary>Java</summary>

- TODO: use ...

```java
// TODO
```

</details>

<details>
    <summary>Rust</summary>

- TODO: use ...

```rust
// TODO
```

</details>

<details>
    <summary>JS</summary>

- TODO: use ...

```js
// TODO
```

</details>


## [Binary Tree](https://en.wikipedia.org/wiki/Binary_tree)
1. Each node has 0, 1 or 2 children
1. Backed by ...
    1. nodes with 2 pointers or
    1. an array with children at index `2i + 1` and `2i + 2`
        1. array items stored in [Breath First Order](TODO)
1. Useful for ... TODO

<details>
    <summary>Java</summary>

```java
public class Node {
    int value;
    Node left;
    Node right;
}
```

</details>

<details>
    <summary>Rust</summary>

- TODO: use ...

```rust
// TODO: struct
```

</details>

<details>
    <summary>JS</summary>

- TODO: use ...

```js
// TODO
```

</details>



## [Binary Search Tree (BST)](https://en.wikipedia.org/wiki/Binary_search_tree)
1. Ordered
1. All items in `.left` are smaller
1. All items in `.right` are larger
1. Challenge: keeping tree balanced
1. Useful for ... TODO


## [Graph](https://en.wikipedia.org/wiki/Adjacency_list)
1. (for interviews) store as [Adjacency list](https://en.wikipedia.org/wiki/Adjacency_list)
1. Useful for ... TODO

<details>
    <summary>Java</summary>

- TODO: use ...

```java
// TODO
```

</details>

<details>
    <summary>Rust</summary>

- TODO: use ...

```rust
// TODO
```

</details>

<details>
    <summary>JS</summary>

- TODO: use ...

```js
// TODO
```

</details>
