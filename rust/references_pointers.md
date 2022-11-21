# Overview
1. Common [smart pointers](https://doc.rust-lang.org/book/ch15-00-smart-pointers.html)
1. Typical usage patterns

# Summary
|              | Ownership (`T`) |      Mutability (`T`)    | Thread-safety | Safety Enforcement | Location (`T`) |   Send   |
|---:|:---:|:---:|:---:|:---:|:---:|:---:|
|          `T` | Owned                                                   | *passthru*              | *passthru*         | Compile time | *passthru* | *passthru* |
|         `&T` | Borrowed                                                |  Immutable              | [Sync](https://doc.rust-lang.org/std/marker/trait.Sync.html) (Yes)   | Compile time | *passthru* | *passthru* |
|      `mut T` | Owned                                                   | Mutable<br/>(Inherited) |                    | Compile time | *passthru* |      *passthru*      |
|     `&mut T` | Borrowed                                                | Mutable<br/>(Inherited) |                    | Compile time | *passthru* |     ?*passthru*?     |
|     [`Box<T>`](https://doc.rust-lang.org/std/boxed/struct.Box.html)    | Owned                   | *passthru*         | *passthru*    | Compile time | Heap | *passthru* |
|    [`Cell<T>`](https://doc.rust-lang.org/std/cell/struct.Cell.html)    | *passthru*              |  Mutable<br/>(Interior)  |   !Sync (No)    | Runtime | *passthru* |      *passthru*      |
| [`RefCell<T>`](https://doc.rust-lang.org/std/cell/struct.RefCell.html) | *passthru*              |  Mutable<br/>(Interior)  |   !Sync (No)    | Runtime | *passthru* |      *passthru*      |
|   [`Mutex<T>`](https://doc.rust-lang.org/std/sync/struct.Mutex.html)   | Owned                   |  Mutable<br/>(Interior)  |   [Sync](https://doc.rust-lang.org/std/marker/trait.Sync.html) (Yes)    | Runtime | *passthru* | Yes |
|  [`RwLock<T>`](https://doc.rust-lang.org/std/sync/struct.RwLock.html)  | Owned                   |  Mutable<br/>(Interior)  |   [Sync](https://doc.rust-lang.org/std/marker/trait.Sync.html) (Yes)    | Runtime | *passthru* |      *passthru*      |
|      [`Rc<T>`](https://doc.rust-lang.org/std/rc/struct.Rc.html)        | Multiple Owners         | Immutable          |  !Sync (No)   | Runtime | *passthru* | No |
|     [`Arc<T>`](https://doc.rust-lang.org/std/sync/struct.Arc.html)     | Multiple Owners         | Immutable          | *passthru* | Runtime | *passthru* | *passthru* |
|    [`Weak<T>`](https://doc.rust-lang.org/std/rc/struct.Weak.html)      | Not owned               | Immutable          |  !Sync (No)   | Compile time | *passthru* | No |
|        [`Cow`](https://doc.rust-lang.org/std/borrow/enum.Cow.html)     | *passthru*              | Immutable          |  [Sync](https://doc.rust-lang.org/std/marker/trait.Sync.html) (Yes)   | Compile time |                | *passthru* |

# Combinations
# Arc<Mutex<T>>
1. Comparison
    1. Equivalent to golang [`sync.Mutex`](https://pkg.go.dev/sync#Mutex)
    1. Equivalent to java [`ReentrantLock`](https://docs.oracle.com/en/java/javase/18/docs/api/java.base/java/util/concurrent/locks/ReentrantLock.html)


- TODO: https://cheats.rs/#references-pointers

# Other Resources
