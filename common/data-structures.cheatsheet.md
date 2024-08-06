# Overview
1. Cheatsheet on common [Data Structures](https://en.wikipedia.org/wiki/Abstract_data_type) (mostly for interviews)
1. See also: [Data Structures doc](./data-structures.md)
1. See also: [Concurrent Data Structures doc](./data-structures.concurrent.md)


# Basic

## Array

<details>
    <summary>Java</summary>

- [Java Spec](https://docs.oracle.com/javase/specs/jls/se8/html/jls-10.html)
- heap allocated, length is NOT part of the type

```java
// TODO
```

</details>

<details>
    <summary>Rust</summary>

- [Rust array doc](https://doc.rust-lang.org/std/primitive.array.html)
- known, fixed size at compile time, stack allocated

```rust
// TODO
```

</details>

<details>
    <summary>JS</summary>

- TODO
</details>


## Growable Array

<details>
    <summary>Java</summary>
- [`ArrayList`](https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/util/ArrayList.html)

```java
// TODO
```

</details>

<details>
    <summary>Rust</summary>

- [Rust `Vec`](https://doc.rust-lang.org/std/vec/struct.Vec.html)

```rust
// TODO
```

</details>

<details>
    <summary>JS</summary>

- TODO

</details>

1. ~~Linked List~~

<details>
    <summary>Java</summary>

```java
// TODO
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


# Adapters

## [Ring Buffer, Circular Buffer](https://en.wikipedia.org/wiki/Circular_buffer)
1. Backed by Array or Growable Array
1. Two pointers to `head` & `tail`
1. `O(1)` push, pop and lookup
1. Useful for FIFO and LIFO
1. Avoids overflows
1. Easy to drop oldest data


## Stack (LIFO)
1. Backed by Array or Growable Array or Ring Buffer or Linked List
1. Useful for ... TODO


## Queue (FIFO)
1. Backed by Array or Growable Array or Ring Buffer or Linked List
1. Useful for ... TODO


## [HashMap](https://en.wikipedia.org/wiki/Hash_table)
1. `O(1)` lookup & insert
1. Array of buckets
    1. Each "bucket" has a Linked List or Binary Tree


## [Heap, PriorityQueue](https://en.wikipedia.org/wiki/Heap_(data_structure)): [img-1](./diagrams/heap-1.png), [img-2](./diagrams/heap-2.png), [img-3](./diagrams/heap-3.png)
1. Partially sorted
1. Worst case `O(Log(n))` get max (or min)
1. Worst case `O(Log(n))` insert
1. Useful for "Top n" items


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
class Node {
    int value;
    Node left;
    Node right;
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
</details>

<details>
    <summary>Rust</summary>
</details>

<details>
    <summary>JS</summary>
</details>
