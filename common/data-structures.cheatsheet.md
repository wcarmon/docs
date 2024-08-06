# Overview
1. Cheatsheet on common [Data Structures](https://en.wikipedia.org/wiki/Abstract_data_type)
1. See also: [Data Structures doc](./data-structures.md)
1. See also: [Concurrent Data Structures doc](./data-structures.concurrent.md)



# Basic
1. Array
    - [Java](https://docs.oracle.com/javase/specs/jls/se8/html/jls-10.html): heap allocated, length is NOT part of the type
    - [Rust](https://doc.rust-lang.org/std/primitive.array.html): known, fixed size at compile time, stack allocated
1. Growable Array
    - [Java `ArrayList`](https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/util/ArrayList.html)
    - [Rust `Vec`](https://doc.rust-lang.org/std/vec/struct.Vec.html)
1. ~~Linked List~~


# Adapters
1. [RingBuffer, Circular buffer](https://en.wikipedia.org/wiki/Circular_buffer)
    1. Backed by Array or Growable Array
    1. Two pointers to `head` & `tail`
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
        1. Each "bucket" has a Linked List or Binary Tree
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

