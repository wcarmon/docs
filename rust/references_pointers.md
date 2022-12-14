# Overview
1. Common [smart pointers](https://doc.rust-lang.org/book/ch15-00-smart-pointers.html)
1. Typical usage patterns

# Summary
|              | Ownership (`T`) |      Mutability (`T`)    | Thread-safety | Safety Enforcement | Location (`T`) |   Send   |
|---:|:---:|:---:|:---:|:---:|:---:|:---:|
|          `T` | Owned                                                   | *passthru*              | *passthru*                 | Compile time  | *passthru*    | *passthru* |
|         `&T` | Borrowed                                                | Immutable               | [Sync](https://doc.rust-lang.org/std/marker/trait.Sync.html) (Yes)   | Compile time | *passthru* | *passthru* |
|      `mut T` | Owned                                                   | Mutable<br/>(Inherited) |                            | Compile time  | *passthru*    | *passthru*      |
|     `&mut T` | Borrowed                                                | Mutable<br/>(Inherited) |                            | Compile time  | *passthru*    | ?*passthru*?     |
|     [`Box<T>`](https://doc.rust-lang.org/std/boxed/struct.Box.html)    | Owned                   | *passthru*                 | *passthru*    | Compile time  | Heap | *passthru* |
|      [`Rc<T>`](https://doc.rust-lang.org/std/rc/struct.Rc.html)        | Multiple Owners         | Immutable                  | !Sync (No)    | Runtime       | *passthru* | No |
|     [`Arc<T>`](https://doc.rust-lang.org/std/sync/struct.Arc.html)     | Multiple Owners         | Immutable                  | *passthru*    | Runtime       | *passthru* | *passthru* |
|    [`Weak<T>`](https://doc.rust-lang.org/std/rc/struct.Weak.html)      | Not owned               | Immutable                  | !Sync (No)    | Compile time  | *passthru* | No |
|        [`Cow`](https://doc.rust-lang.org/std/borrow/enum.Cow.html)     | *passthru*              | Immutable                  | [Sync](https://doc.rust-lang.org/std/marker/trait.Sync.html) (Yes)   | Compile time |                | *passthru* |


|              | Ownership (`T`) |      Mutability (`T`)    | Thread-safety | Safety Enforcement | Location (`T`) |   Send   |
|---:|:---:|:---:|:---:|:---:|:---:|:---:|
|    [`Cell<T>`](https://doc.rust-lang.org/std/cell/struct.Cell.html)    | *passthru*              |  Mutable<br/>(Interior)    | !Sync (No)    | Runtime       | *passthru* |      *passthru*      |
| [`RefCell<T>`](https://doc.rust-lang.org/std/cell/struct.RefCell.html) | Owned                   |  Mutable<br/>(Interior)    | !Sync (No)    | Runtime       | *passthru* |      *passthru*      |
|   [`Mutex<T>`](https://doc.rust-lang.org/std/sync/struct.Mutex.html)   | Owned                   |  Mutable<br/>(Interior)    | [Sync](https://doc.rust-lang.org/std/marker/trait.Sync.html) (Yes)    | Runtime | *passthru* | Yes |
|  [`RwLock<T>`](https://doc.rust-lang.org/std/sync/struct.RwLock.html)  | Owned                   |  Mutable<br/>(Interior)    | [Sync](https://doc.rust-lang.org/std/marker/trait.Sync.html) (Yes)    | Runtime | *passthru* |      *passthru*      |


# Relationships
## Ownership Tools 
1. `&`, `&mut`, `Box`, `Rc`, `Arc`, `Weak` are related ([so never use together on the same type](https://rust-lang.github.io/rust-clippy/master/index.html#redundant_allocation))
1. functions should accept the most general type (eg. `&` or `&mut`)
1. functions should return the most specific type
1. [clippy](https://rust-lang.github.io/rust-clippy/master/index.html#redundant_allocation) can catch many of these issues


## Mutability Tools
1. `Cell`, `RefCell`, `Mutex`, `RwLock` are related (so never use together on the same type)  


# Tools for [Ownership](https://doc.rust-lang.org/book/ch04-00-understanding-ownership.html)
## `&` and `&mut`
- Useful for borrowing
- May be on heap or stack
- Functions should accept this since callers can pass `&`, `Box`, `Rc`, `Arc`, ...


## [`Box`](https://doc.rust-lang.org/std/boxed/struct.Box.html)
- Useful for ownership
- Useful for heap allocation


## [`Rc`](https://doc.rust-lang.org/std/rc/struct.Rc.html)
- Useful for safely sharing ownership (immutably)
- `Intuition`: a [`Box`](https://doc.rust-lang.org/std/boxed/struct.Box.html) with shared ownership
- `Intuition`: a faster, single threaded [`Arc`](https://doc.rust-lang.org/std/sync/struct.Arc.html)
- `Intuition`: a garbage collected ref (think Java, Golang, C#, Python, ...)


## [`Arc`](https://doc.rust-lang.org/std/sync/struct.Arc.html)
- Useful for safely sharing ownership across threads (immutably)
- `Intuition`: a threadsafe [`Rc`](https://doc.rust-lang.org/std/rc/struct.Rc.html)
- `Intuition`: a shared, threadsafe [`Box`](https://doc.rust-lang.org/std/boxed/struct.Box.html)


## [`Weak`](https://doc.rust-lang.org/std/rc/struct.Weak.html)
- Useful for TODO
- Can be [upgraded](https://doc.rust-lang.org/std/rc/struct.Weak.html#method.upgrade) to [`Rc`](https://doc.rust-lang.org/std/rc/struct.Rc.html)


# Tools for Mutability
## [`Mutex`](https://doc.rust-lang.org/std/sync/struct.Mutex.html)
- Useful for safe mutation across threads
- TODO

## [`RwLock`](https://doc.rust-lang.org/std/sync/struct.RwLock.html)
- Useful for safe mutation across threads with optimization for concurrent reads


## [`RefCell`](https://doc.rust-lang.org/std/cell/struct.RefCell.html)
- Useful for provably safe mutation within one thread


## [`Cell`](https://doc.rust-lang.org/std/cell/struct.Cell.html)
- Useful for TODO
- TODO


# Tools for Thread-safety
## [`Sync`](https://doc.rust-lang.org/std/marker/trait.Sync.html) marker trait
- Threadsafety

## [`Send`](https://doc.rust-lang.org/std/marker/trait.Send.html) marker trait
- Safe to [transfer](https://doc.rust-lang.org/nomicon/send-and-sync.html) ownership between threads


# Combinations
# `Arc<Mutex<T>>`
1. [Threadsafe](https://doc.rust-lang.org/std/sync/struct.Arc.html#thread-safety), [reference counted](https://en.wikipedia.org/wiki/Reference_counting), runtime enforced, safe mutability
    1. [`Arc`](https://doc.rust-lang.org/std/sync/struct.Arc.html)
    1. [`Mutex`](https://doc.rust-lang.org/std/sync/struct.Mutex.html)
1. Comparison
    1. Equivalent to golang [`sync.Mutex`](https://pkg.go.dev/sync#Mutex)
    1. Equivalent to java [`ReentrantLock`](https://docs.oracle.com/en/java/javase/18/docs/api/java.base/java/util/concurrent/locks/ReentrantLock.html)

# Rc<RefCell<T>>
1. Useful for sharing ownership with **provably safe** mutation within **one thread**



- TODO: Pin
- TODO: https://cheats.rs/#references-pointers

# Other Resources
