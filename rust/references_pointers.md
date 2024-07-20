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

1. `fn` should accept accept `&T` (not ~~`Box<T>`~~, not ~~`Rc<T>`~~, not ~~`Arc<T>`~~)
    1. caller should pass `my_box.as_ref()`, or `rc.as_ref()` or `arc.as_ref()` 
1. `fn` should return the most specific Pointer type (eg. TODO)


## `&` and `&mut`
1. Useful for borrowing
1. May be on heap or stack
1. Functions should accept either `&` or `&mut`
    1. which allows callers to pass `T`, `&T`, `Box<T>`, `Rc<T>`, `Arc<T>`, ...


## [`Box`](https://doc.rust-lang.org/std/boxed/struct.Box.html)
1. Useful for (compile time enforced) ownership on heap
1. Useful for `dyn` Trait (trait objects)
1. `Conversion`: `x: T` to `Box<T>` *(owned-on-stack to owned-on-heap)*
    ```rust
    let x = MyImpl {}; // MyImpl implements MyTrait 
    let bx: Box<dyn MyTrait> = Box::new(x);
    ```
1. `Conversion`: `&x` to `Box<T>` *(borrowed to owned)*
    1. Hard because you don't own `x`
    1. Although, you can [`clone`](https://doc.rust-lang.org/std/clone/trait.Clone.html)    
    ```rust
    let x_ref = &x; 
    let bx: Box<MyImpl> = Box::new(x_ref.clone());
    ```
1. `Idiom`: `fn` should  accept `&T` and return `Box<T>`
    ```rust 
    fn whatever() {    
        let bx: Box<dyn MyTrait> = Box::new(MyImpl {});        
        some_consumer(bx.as_ref());
    }

    fn some_consumer(t: &dyn MyTrait) {
        ...
    }   
    ```

## [`Rc`](https://doc.rust-lang.org/std/rc/struct.Rc.html)
1. Prefer `Arc` or `Box` unless you know exactly **why** this is needed
1. This is a single-threaded optimization for `Arc`, not useful for multi-threaded programming
1. Useful for safely sharing ownership across variables (immutably)    
1. Useful for [`dyn`](./traits.md) Traits    
1. `Intuition`:
    1. a [`Box`](https://doc.rust-lang.org/std/boxed/struct.Box.html) with shared ownership and runtime safety enforcement
    1. a faster, single-threaded [`Arc`](https://doc.rust-lang.org/std/sync/struct.Arc.html)
    1. a garbage collected ref (think Java, Golang, C#, Python, ...)
1. `Conversion`: `x: T` to `Rc<T>` (owned-on-stack to shared-ownership-on-heap)
    ```rust
    let x = MyImpl {}; // MyImpl implements MyTrait
    let rc: Rc<dyn MyTrait> = Rc::new(x);
    ```
1. `Conversion`: `Box<T>` to `Rc<T>` *(owned-on-heap to shared-ownership-on-heap)*
    ```rust
    let bx: Box<dyn MyTrait> = Box::new(x);  // box of trait
    let rc: Rc<dyn MyTrait> = bx.into();    // same as Rc::from(bx)
    
    // or 
    
    let bx: Box<MyImpl> = Box::new(x);        // box of implementation
    let rc: Rc<dyn MyTrait> = Rc::new(*bx); // dereference first since mem layout is different
    ```
1. `Conversion`: `&x` to `Rc<T>` *(borrowed to shared-ownership-on-heap)*
    1. Harder because you don't own `x`
    1. Although, you can [`clone`](https://doc.rust-lang.org/std/clone/trait.Clone.html)
    ```rust
    let x_ref = &x;
    let rc: Rc<dyn MyTrait> = Rc::new(x_ref.clone());  // assuming x implements Clone
    ```
1. `Idiom`: `fn` should  accept `&T` and return `Rc<T>`
    ```rust 
    fn whatever() {    
        let rc: Rc<dyn MyTrait> = Rc::new(MyImpl {});        
        some_consumer(rc.as_ref());
    }

    fn some_consumer(t: &dyn MyTrait) {
        ...
    }   
    ``` 
1. GOTCHA: cannot iterate directly over `Rc` since it doesn't implement [`IntoIterator`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html)
    1. Use [`rc.iter()`](https://doc.rust-lang.org/std/primitive.slice.html#method.iter) which converts to slice
    ```rust
    let rc: Rc<Vec<String>> = Rc::new(vec![...]);

    for s in rc.iter() {
        // use `s` here
    }
    ```
    

## [`Arc`](https://doc.rust-lang.org/std/sync/struct.Arc.html)
1. Useful for safely sharing ownership across threads (immutably)
1. Useful for `dyn` Traits
1. `&` is simpler than `Arc`, but only works across threads when **All** members are Sync/Send
1. `Intuition`:
    1. a threadsafe [`Rc`](https://doc.rust-lang.org/std/rc/struct.Rc.html)
    1. a shared, threadsafe [`Box`](https://doc.rust-lang.org/std/boxed/struct.Box.html) with runtime safety enforcement
    1. a garbage collected ref (think Java, Golang, C#, Python, ...)
1. `Conversion`: `x: T` to `Arc<T>` (owned-on-stack to shared-ownership-on-heap)
    ```rust
    let x = MyImpl {}; // MyImpl implements MyTrait
    let arc: Arc<dyn MyTrait> = Arc::new(x);
    ```
1. `Conversion`: `Box<T>` to `Arc<T>` *(owned-on-heap to shared-ownership-on-heap)*
    ```rust
    let bx:Box<dyn MyTrait> = Box::new(x);  // box of trait
    let arc: Arc<dyn MyTrait> = bx.into(); // same as Arc::from(bx)
    
    // or 
    
    let bx: Box<MyImpl> = Box::new(x);        // box of implementation
    let arc: Arc<dyn MyTrait> = Arc::new(*bx); // dereference first since mem layout is different
    ```
1. `Conversion`: `&x` to `Arc<T>` *(borrowed to shared-ownership-on-heap)*
    1. Hard because you don't own `x`
    1. Although, you can [`clone`](https://doc.rust-lang.org/std/clone/trait.Clone.html)
    ```rust
    let x_ref = &x;
    let arc: Arc<dyn MyTrait> = Arc::new(x_ref.clone());  // assuming x implements Clone
    ```
1. `Conversion`: `Rc<T>` to `Arc<T>` *(single-threaded to threadsafe)*
    1. No easy way to do since 
        1. you don't know how many references (aliases) there are
        1. you'd have to replace all with the threadsafe Arc
1. `Idiom`: `fn` should  accept `&T` and return `Rc<T>`
    ```rust 
    fn whatever() {    
        let arc: Arc<dyn MyTrait> = Arc::new(MyImpl {});
        some_consumer(arc.as_ref());
    }

    fn some_consumer(t: &dyn MyTrait) {
        ...
    }   
    ```
1. GOTCHA: cannot iterate directly over `Arc` since it doesn't implement [`IntoIterator`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html)
    1. Use [`rc.iter()`](https://doc.rust-lang.org/std/primitive.slice.html#method.iter) which converts to slice
    ```rust
    let arc: Arc<Vec<String>> = Arc::new(vec![...]);

    for s in arc.iter() {
        // use `s` here
    }
    ```


## [`Weak`](https://doc.rust-lang.org/std/rc/struct.Weak.html)
- Useful for [circular references](TODO) (eg. Graphs)
- Can be [upgraded](https://doc.rust-lang.org/std/rc/struct.Weak.html#method.upgrade) to [`Rc`](https://doc.rust-lang.org/std/rc/struct.Rc.html)


## Conversion summary
1. [`T` --> `Box<T>`](https://doc.rust-lang.org/std/boxed/struct.Box.html#method.new)
1. `&T` --> `Box<T>`: must `clone`
1. [`Box<T>` --> `Rc<T>`](https://doc.rust-lang.org/std/rc/struct.Rc.html#impl-From%3CBox%3CT%2C%20Global%3E%3E-for-Rc%3CT%3E)
1. [`Box<T>` --> `Arc<T>`](https://doc.rust-lang.org/std/sync/struct.Arc.html#impl-From%3CBox%3CT%2C%20Global%3E%3E-for-Arc%3CT%3E)
1. [`Arc<T>` --> `Weak<T>`](https://doc.rust-lang.org/std/sync/struct.Arc.html#method.downgrade)
1. [`Weak<T>` --> `Arc<T>`](https://doc.rust-lang.org/std/sync/struct.Weak.html#method.upgrade)


--------
# Tools for Mutability

|              | Ownership (`T`) |      Mutability (`T`)    | Thread-safety | Safety Enforcement | Location (`T`) |   Send   |
|---:|:---:|:---:|:---:|:---:|:---:|:---:|
|      `mut T`                                                           | Owned          | Mutable<br/>(Inherited) |             | Compile time | *passthru* | Stack or Heap |
|     `&mut T`                                                           | Borrowed       | Mutable<br/>(Inherited) |             | Compile time | *passthru* | ?*passthru*?  |
|    [`Cell<T>`](https://doc.rust-lang.org/std/cell/struct.Cell.html)    | *passthru*     | Mutable<br/>(Interior)  | !Sync (No)  | Runtime      | *passthru* | *passthru*    |
| [`RefCell<T>`](https://doc.rust-lang.org/std/cell/struct.RefCell.html) | Owned (shared) | Mutable<br/>(Interior)  | !Sync (No)  | Runtime      | *passthru* | *passthru*    |
|   [`Mutex<T>`](https://doc.rust-lang.org/std/sync/struct.Mutex.html)   | Owned (shared) | Mutable<br/>(Interior)  | [Sync](https://doc.rust-lang.org/std/marker/trait.Sync.html) (Yes)  | Runtime | *passthru* | Yes        |
|  [`RwLock<T>`](https://doc.rust-lang.org/std/sync/struct.RwLock.html)  | Owned (shared) | Mutable<br/>(Interior)  | [Sync](https://doc.rust-lang.org/std/marker/trait.Sync.html) (Yes)  | Runtime | *passthru* | *passthru* |


## Relationships
1. `Cell`, `RefCell`, `Mutex`, `RwLock` are related (so never use together on the same type)  


## [`Mutex`](https://doc.rust-lang.org/std/sync/struct.Mutex.html)
- Useful for safe mutation across threads
- Threadsafe sharable mutable container (shared across threads and variables/aliases)
- See also [atomic types](https://doc.rust-lang.org/std/sync/atomic/index.html)


## [`RwLock`](https://doc.rust-lang.org/std/sync/struct.RwLock.html)
- Useful for safe mutation across threads, with optimization for concurrent reads
- Threadsafe sharable mutable container (shared across threads and variables)
- See also [atomic types](https://doc.rust-lang.org/std/sync/atomic/index.html)


## [`RefCell`](https://doc.rust-lang.org/std/cell/struct.RefCell.html)
- Useful for provably safe mutation within one thread (across aliases/variables)
- **Single-threaded** sharable mutable container (shared across aliases/variables)
- Move flexible version of [`Cell`](https://doc.rust-lang.org/std/cell/struct.Cell.html)
- Runtime safety enforcement of Rust borrow & mutation patterns.
    - shifts borrow checking from compile time to runtime
- Single-threaded version of `Mutex`
- `Rc<RefCell<Foo>>` is basically how all references work in (single threaded) Java or C++ code
    - ~~`Arc<RefCell<Foo>>`~~ is how multithreaded Java or C++ work by default.  It's an antipattern in Rust, C++ and Java.


## [`Cell`](https://doc.rust-lang.org/std/cell/struct.Cell.html)
- Useful for static & thread-local variables
- Mostly used to implement higher level types like `Rc`
- Atomically moves values in and out (only [Copy]() types, think numbers, bool, ...)
- **Single-threaded** sharable mutable container (shared across variables)
- Runtime safety enforcement


# Tools for Thread-safety
## [`Sync`](https://doc.rust-lang.org/std/marker/trait.Sync.html) marker trait
- Threadsafety

## [`Send`](https://doc.rust-lang.org/std/marker/trait.Send.html) marker trait
- Safe to [transfer](https://doc.rust-lang.org/nomicon/send-and-sync.html) ownership between threads


# Combinations (Ownership + Mutability)
# `Arc<Mutex<T>>` 
1. [Threadsafe](https://doc.rust-lang.org/std/sync/struct.Arc.html#thread-safety), [reference counted](https://en.wikipedia.org/wiki/Reference_counting), runtime enforced, safe mutability
    1. [`Arc`](https://doc.rust-lang.org/std/sync/struct.Arc.html)
    1. [`Mutex`](https://doc.rust-lang.org/std/sync/struct.Mutex.html)
1. Comparison
    1. Equivalent to golang [`sync.Mutex`](https://pkg.go.dev/sync#Mutex)
    1. Equivalent to java [`ReentrantLock`](https://docs.oracle.com/en/java/javase/18/docs/api/java.base/java/util/concurrent/locks/ReentrantLock.html)


# `Arc<RwLock<T>>`
1. Multi-reader optimized version of `Arc<Mutex<T>>`


# Rc<RefCell<T>>
1. Useful for sharing ownership with **provably safe** mutation within **one thread**


# Rc<Cell<T>>
1. TODO



## Invalid combinations
- [~~`Rc<Mutex<T>>`~~](https://rust-lang.github.io/rust-clippy/master/index.html#rc_mutex)
- [~~`Rc<RwLock<T>>`~~](https://rust-lang.github.io/rust-clippy/master/index.html#rc_mutex) 
- ~~`Arc<Cell<T>>`~~: overly complex without thread safety
- ~~`Arc<RefCell<T>>`~~: overly complex without thread safety
- ~~`Box<Cell<T>>`~~: TODO
- ~~`Box<Mutex<T>>`~~: cannot alias, so threadsafe mutation is pointless
- ~~`Box<RefCell<T>>`~~: TODO
- ~~`Box<RwLock<T>>`~~: cannot alias, so threadsafe mutation is pointless


# TODO/Unorganized
- TODO: combination: `&Cell<T>`
- TODO: combination: `&Mutex<T>`
- TODO: combination: `&RefCell<T>`
- TODO: combination: `&RwLock<T>`



- TODO: Pin
- TODO: https://cheats.rs/#references-pointers

# Other Resources
