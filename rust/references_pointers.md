# Overview
1. Common [smart pointers](https://doc.rust-lang.org/book/ch15-00-smart-pointers.html)
1. Typical usage patterns

# Summary
|              | Ownership (`T`) |      Mutability (`T`)    | Thread-safety | Safety Enforcement | Location (`T`) |   Send   |
|---:|:---:|:---:|:---:|:---:|:---:|:---:|
|          `T` | Owned                                                   | *passthru*              | *passthru*                 | Compile time  | *passthru*    | *passthru* |
|         `&T` | Borrowed                                                |  Immutable              | [Sync](https://doc.rust-lang.org/std/marker/trait.Sync.html) (Yes)   | Compile time | *passthru* | *passthru* |
|      `mut T` | Owned                                                   | Mutable<br/>(Inherited) |                            | Compile time  | *passthru*    | *passthru*      |
|     `&mut T` | Borrowed                                                | Mutable<br/>(Inherited) |                            | Compile time  | *passthru*    | ?*passthru*?     |
|     [`Box<T>`](https://doc.rust-lang.org/std/boxed/struct.Box.html)    | Owned                   | *passthru*                 | *passthru*    | Compile time  | Heap | *passthru* |
|    [`Cell<T>`](https://doc.rust-lang.org/std/cell/struct.Cell.html)    | *passthru*              |  Mutable<br/>(Interior)    | !Sync (No)    | Runtime       | *passthru* |      *passthru*      |
| [`RefCell<T>`](https://doc.rust-lang.org/std/cell/struct.RefCell.html) | *passthru*              |  Mutable<br/>(Interior)    | !Sync (No)    | Runtime       | *passthru* |      *passthru*      |
|   [`Mutex<T>`](https://doc.rust-lang.org/std/sync/struct.Mutex.html)   | Owned                   |  Mutable<br/>(Interior)    | [Sync](https://doc.rust-lang.org/std/marker/trait.Sync.html) (Yes)    | Runtime | *passthru* | Yes |
|  [`RwLock<T>`](https://doc.rust-lang.org/std/sync/struct.RwLock.html)  | Owned                   |  Mutable<br/>(Interior)    | [Sync](https://doc.rust-lang.org/std/marker/trait.Sync.html) (Yes)    | Runtime | *passthru* |      *passthru*      |
|      [`Rc<T>`](https://doc.rust-lang.org/std/rc/struct.Rc.html)        | Multiple Owners         | Immutable                  | !Sync (No)    | Runtime       | *passthru* | No |
|     [`Arc<T>`](https://doc.rust-lang.org/std/sync/struct.Arc.html)     | Multiple Owners         | Immutable                  | *passthru*    | Runtime       | *passthru* | *passthru* |
|    [`Weak<T>`](https://doc.rust-lang.org/std/rc/struct.Weak.html)      | Not owned               | Immutable                  | !Sync (No)    | Compile time  | *passthru* | No |
|        [`Cow`](https://doc.rust-lang.org/std/borrow/enum.Cow.html)     | *passthru*              | Immutable                  | [Sync](https://doc.rust-lang.org/std/marker/trait.Sync.html) (Yes)   | Compile time |                | *passthru* |


# Combinations
# `Arc<Mutex<T>>`
1. [Threadsafe](https://doc.rust-lang.org/std/sync/struct.Arc.html#thread-safety), [reference counted](https://en.wikipedia.org/wiki/Reference_counting), runtime enforced, safe mutability
    1. [`Arc`](https://doc.rust-lang.org/std/sync/struct.Arc.html)
    1. [`Mutex`](https://doc.rust-lang.org/std/sync/struct.Mutex.html)
1. Comparison
    1. Equivalent to golang [`sync.Mutex`](https://pkg.go.dev/sync#Mutex)
    1. Equivalent to java [`ReentrantLock`](https://docs.oracle.com/en/java/javase/18/docs/api/java.base/java/util/concurrent/locks/ReentrantLock.html)

# Rc<RefCell<T>>
1. TODO


# Tools for [Ownership](https://doc.rust-lang.org/book/ch04-00-understanding-ownership.html)
## [`Rc`](https://doc.rust-lang.org/std/rc/struct.Rc.html)
- Useful for TODO
- TODO


## [`Arc`](https://doc.rust-lang.org/std/sync/struct.Arc.html)
- Useful for TODO
- TODO


## [`Weak`](https://doc.rust-lang.org/std/rc/struct.Weak.html)
- Useful for TODO
- Can be [upgraded](https://doc.rust-lang.org/std/rc/struct.Weak.html#method.upgrade) to [`Rc`](https://doc.rust-lang.org/std/rc/struct.Rc.html)


# Tools for Mutability
## [`Mutex`](https://doc.rust-lang.org/std/sync/struct.Mutex.html)
- Useful for TODO
- TODO

## [`RwLock`](https://doc.rust-lang.org/std/sync/struct.RwLock.html)
- TODO

## [`RefCell`](https://doc.rust-lang.org/std/cell/struct.RefCell.html)
- Useful for TODO
- TODO

## [`Cell`](https://doc.rust-lang.org/std/cell/struct.Cell.html)
- Useful for TODO
- TODO


# Tools for Thread-safety
## [`Sync`](https://doc.rust-lang.org/std/marker/trait.Sync.html) marker trait
- Threadsafety

## [`Send`](https://doc.rust-lang.org/std/marker/trait.Send.html) marker trait
- Safe to [transfer](https://doc.rust-lang.org/nomicon/send-and-sync.html) ownership between threads


- TODO: Pin
- TODO: https://cheats.rs/#references-pointers

# Other Resources
