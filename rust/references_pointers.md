# Overview
1. Common [smart pointers](https://doc.rust-lang.org/book/ch15-00-smart-pointers.html)
1. Typical usage patterns
1. Relationship to other concepts


## Prerequisites
1. Understand [ownership](./ownership.md)


# Tools for [Ownership](./ownership.md)

|              | Ownership (`T`) |      Mutability (`T`)    | Thread-safety | Safety Enforcement | Location (`T`) |   Send   |
|---:|:---:|:---:|:---:|:---:|:---:|:---:|
|          `T`                                                        | Owned           | on `let mut` or `&mut` | only if `T: Sync`  | Compile time  | Stack    | only if `T: Send` |
|         `&T`                                                        | Borrowed        | Immutable              | [Sync](https://doc.rust-lang.org/std/marker/trait.Sync.html) (Yes)   | Compile time | Stack or Heap | *passthru* |
|     [`Box<T>`](https://doc.rust-lang.org/std/boxed/struct.Box.html) | Owned           | on `let mut` or `&mut` | only if `T: Sync`  | Compile time  | Heap | only if `T: Send` |
|      [`Rc<T>`](https://doc.rust-lang.org/std/rc/struct.Rc.html)     | Multiple Owners | Immutable              | !Sync (No)         | Runtime       | Heap | No |
|     [`Arc<T>`](https://doc.rust-lang.org/std/sync/struct.Arc.html)  | Multiple Owners | Immutable              | only if `T: Sync`  | Runtime       | Heap | *passthru* |
|    [`Weak<T>`](https://doc.rust-lang.org/std/rc/struct.Weak.html)   | Not owned       | Immutable              | !Sync (No)         | Compile time  | Heap | No |
|        [`Cow`](https://doc.rust-lang.org/std/borrow/enum.Cow.html)  | *passthru*      | Immutable              | [Sync](https://doc.rust-lang.org/std/marker/trait.Sync.html) (Yes)   | Compile time |      ?          | *passthru* |

## Relationships
1. `&`, `&mut`, `Box`, `Rc`, `Arc`, `Weak` are related ([so never use together on the same type](https://rust-lang.github.io/rust-clippy/master/index.html#redundant_allocation))
1. functions should accept the most general type (eg. `&` or `&mut`)
1. functions should return the most specific type
1. [clippy](https://rust-lang.github.io/rust-clippy/master/index.html#redundant_allocation) can catch many of these issues


## `&` and `&mut`
1. Useful for borrowing
1. May be on heap or stack
1. Functions should accept either `&` or `&mut`
    1. which allows callers to pass `T`, `&T`, `Box<T>`, `Rc<T>`, `Arc<T>`, ...


## [`Box`](https://doc.rust-lang.org/std/boxed/struct.Box.html)
1. Useful for (compile time enforced) ownership on heap
1. Useful for `dyn` Traits
1. `Conversion`: `x: T` to `Box<T>` *(owned-on-stack to owned-on-heap)*
    ```rust
    let x = Quux {}; // Quux implements MyTrait 
    let bx: Box<dyn MyTrait> = Box::new(x);
    ```
1. `Conversion`: `&x` to `Box<T>` *(borrowed to owned)*
    1. Harder because you don't own `x`
    1. Although, you can [`clone`](https://doc.rust-lang.org/std/clone/trait.Clone.html)    
    ```rust
    let x_ref = &x; 
    let bx: Box<Quux> = Box::new(x_ref.clone());
    ```

## [`Rc`](https://doc.rust-lang.org/std/rc/struct.Rc.html)
1. Useful for safely sharing ownership (immutably)
    1. *Sharing* ownership across variables, not threads :-)
1. Useful for `dyn` Traits    
1. `Intuition`:
    1. a [`Box`](https://doc.rust-lang.org/std/boxed/struct.Box.html) with shared ownership
    1. a faster, single-threaded [`Arc`](https://doc.rust-lang.org/std/sync/struct.Arc.html)
    1. a garbage collected ref (think Java, Golang, C#, Python, ...)
1. `Conversion`: `x: T` to `Rc<T>` (owned-on-stack to shared-ownership-on-heap)
    ```rust
    let x = Quux {}; // Quux implements MyTrait
    let rc: Rc<dyn MyTrait> = Rc::new(x);
    ```
1. `Conversion`: `Box<T>` to `Rc<T>` *(owned-on-heap to shared-ownership-on-heap)*
    ```rust
    let bx:Box<dyn MyTrait> = Box::new(x);  // box of trait
    let rc: Rc<dyn MyTrait> = bx.into();    // same as Rc::from(bx)
    
    // or 
    
    let bx: Box<Quux> = Box::new(x);        // box of implementation
    let rc: Rc<dyn MyTrait> = Rc::new(*bx); // dereference first since mem layout is different
    ```
1. `Conversion`: `&x` to `Rc<T>` *(borrowed to shared-ownership-on-heap)*
    1. Harder because you don't own `x`
    1. Although, you can [`clone`](https://doc.rust-lang.org/std/clone/trait.Clone.html)
    ```rust
    let x_ref = &x;
    let rc: Rc<dyn MyTrait> = Rc::new(x_ref.clone());  // assuming x implements Clone
    ```


## [`Arc`](https://doc.rust-lang.org/std/sync/struct.Arc.html)
1. Useful for safely sharing ownership across threads (immutably)
1. Useful for `dyn` Traits
1. `Intuition`:
    1. a threadsafe [`Rc`](https://doc.rust-lang.org/std/rc/struct.Rc.html)
    1. a shared, threadsafe [`Box`](https://doc.rust-lang.org/std/boxed/struct.Box.html)
1. TODO: & -> Arc
1. TODO: Box -> Arc
1. TODO: Rc -> Arc


## [`Weak`](https://doc.rust-lang.org/std/rc/struct.Weak.html)
- Useful for [circular references](TODO) (eg. Graphs)
- Can be [upgraded](https://doc.rust-lang.org/std/rc/struct.Weak.html#method.upgrade) to [`Rc`](https://doc.rust-lang.org/std/rc/struct.Rc.html)


# Tools for Mutability

|              | Ownership (`T`) |      Mutability (`T`)    | Thread-safety | Safety Enforcement | Location (`T`) |   Send   |
|---:|:---:|:---:|:---:|:---:|:---:|:---:|
|      `mut T`                                                           | Owned         | Mutable<br/>(Inherited) |             | Compile time | *passthru* | Stack or Heap |
|     `&mut T`                                                           | Borrowed      | Mutable<br/>(Inherited) |             | Compile time | *passthru* | ?*passthru*?  |
|    [`Cell<T>`](https://doc.rust-lang.org/std/cell/struct.Cell.html)    | *passthru*    | Mutable<br/>(Interior)  | !Sync (No)  | Runtime      | *passthru* | *passthru*    |
| [`RefCell<T>`](https://doc.rust-lang.org/std/cell/struct.RefCell.html) | Owned         | Mutable<br/>(Interior)  | !Sync (No)  | Runtime      | *passthru* | *passthru*    |
|   [`Mutex<T>`](https://doc.rust-lang.org/std/sync/struct.Mutex.html)   | Owned         | Mutable<br/>(Interior)  | [Sync](https://doc.rust-lang.org/std/marker/trait.Sync.html) (Yes)  | Runtime | *passthru* | Yes        |
|  [`RwLock<T>`](https://doc.rust-lang.org/std/sync/struct.RwLock.html)  | Owned         | Mutable<br/>(Interior)  | [Sync](https://doc.rust-lang.org/std/marker/trait.Sync.html) (Yes)  | Runtime | *passthru* | *passthru* |


## Relationships
1. `Cell`, `RefCell`, `Mutex`, `RwLock` are related (so never use together on the same type)  


## [`Mutex`](https://doc.rust-lang.org/std/sync/struct.Mutex.html)
- Useful for safe mutation across threads
- TODO

## [`RwLock`](https://doc.rust-lang.org/std/sync/struct.RwLock.html)
- Useful for safe mutation across threads, with optimization for concurrent reads


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

- TODO: other sensible combinations of Ownership + Mutability



- TODO: Pin
- TODO: https://cheats.rs/#references-pointers

# Other Resources
