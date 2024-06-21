# Overview

1. What are Lifetimes?
1. Why are Lifetimes useful?
1. When do we need them?

# What are they?

1. Lifetimes define when a **reference** is valid
1. Lifetimes are both a performance optimization & safety tool
1. Lifetimes help the compiler avoid dangling **references**
1. Without lifetimes, we must ...
    1. copy: which is safe, but slower
    1. ignore lifetimes: which is fast, but unsafe (concurrent mutability, use after free, etc)
    1. manually choose from the 2 options above, at every point, and manually reason about both safety and performance
1. Think: `... must outlive ...`



# Scope/Applicibility

1. Only applies to **references** (borrowing)
1. Not required for Owned types (eg. [String](https://doc.rust-lang.org/std/string/struct.String.html), [PathBuf](https://doc.rust-lang.org/stable/std/path/struct.PathBuf.html))
1. Not required for smart pointers (because the variables which reference them have a lifetime)
1. Useful for sharing immutable data and safely mutating **referenced** data.
1. Useful for avoiding unnecessary allocations
    1. This is huge for performance.
    1. This avoids unnecessary deallocation (`free`) too.
    1. This reduces runtime memory footprint.
1. Only need to specify lifetimes on ...
    1. `struct`s (or `enum` variants) with borrowed fields
    1. functions with borrowed **return** types
1. Most often, compiler will automatically determine lifetimes


# Global Lifetime

- `static`: guaranteed valid for duration of entire program


# Lifetimes on Structs
1. A borrowed `struct` field **must outlive** the `struct`.
2. Only need lifetime annotation on the struct and field, not at the usage points.
3. lifetimes define the contract enforced by the compiler (specifically, the borrow checker)


# Lifetimes on Functions
1. By default, borrowed args **must outlive** the function invocation.
1. returned references **must outlive** one of the borrowed arguments (or be `static`).
    1. connects output lifetime to input lifetime
1. For multiple borrowed args, compiler can enforce they have the same or different lifetimes
1. lifetimes define the contract enforced by the compiler (specifically, the borrow checker)


# Static lifetime
1. `static` items outlive all other lifetimes
1. `static` means *lives for the remaining lifetime of the running program*
1. [constants and string literals](https://doc.rust-lang.org/rust-by-example/scope/lifetime/static_lifetime.html) have `static` lifetime
1. [`Box::leak`](https://doc.rust-lang.org/std/boxed/struct.Box.html#method.leak) helps you make a static reference on the heap
1. owned can act like `static` because they can live as long as they need to
1. `static` items don't call `drop`


# Multi threading
1. [thread::spawn](https://doc.rust-lang.org/std/thread/fn.spawn.html) requires that the fn & return value have `static` lifetime
    2. because both must switch call stacks


# Other Resources

1. TODO
