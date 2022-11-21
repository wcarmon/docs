# Overview

1.
Common [smart pointers](https://doc.rust-lang.org/book/ch15-00-smart-pointers.html)
1. Typical usage patterns

# Summary

|             | Ownership (`T`) |      Mutability (`T`)       | Thread-safety | Safety Enforcement | Location (`T`) |   Send   |
|------------:|:---------------:|:---------------------------:|:-------------:|:------------------:|:--------------:|:--------:|
|           T |      Owned      |          *passthru*           |   *passthru*    |    Compile time    |    *passthru*    | *passthru* |
|          &T |    Borrowed     |          Immutable          |  Sync (yes)   |    Compile time    |    *passthru*    | *passthru* |
|       mut T |      Owned      |   Mutable<br/>(Inherited)   |                 |   Compile time   |   *passthru*    |      *passthru*      |
|      &mut T |    Borrowed     |           Mutable<br/>(Inherited) |                 |        Compile time         |   *passthru*    |     ?*passthru*?     |
|      Box<T> |      Owned      |          *passthru*           |   *passthru*    |    Compile time    |      Heap      | *passthru* |
|     Cell<T> |    *passthru*     |   Mutable<br/>(Interior)    |   !Sync (No)    |            Runtime            |   *passthru*    |      *passthru*      |
|  RefCell<T> |    *passthru*     |      Mutable<br/>(Interior)      |   !Sync (No)    |           Runtime           |   *passthru*    |      *passthru*      |
|    Mutex<T> |      Owned      |           Mutable<br/>(Interior) |   Sync (yes)    |           Runtime           |   *passthru*    |        Yes         |
|   RwLock<T> |      Owned      |           Mutable<br/>(Interior) |   Sync (yes)    |           Runtime           |   *passthru*    |      *passthru*      |
|       Rc<T> |    Multiple     |          Immutable          |  !Sync (No)   |      Runtime       |    *passthru*    |    No    |
|      Arc<T> |    Multiple     |          Immutable          |   *passthru*    |      Runtime       |    *passthru*    | *passthru* |
|     Weak<T> |    Not owned    |          Immutable          |  !Sync (No)   |    Compile time    |    *passthru*    |    No    |
|         Cow |    *passthru*     |          Immutable          |  Sync (yes)   |    Compile time    |                | *passthru* |

- TODO: https://cheats.rs/#references-pointers

# Other Resources
