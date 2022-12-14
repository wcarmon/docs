# Overview
1. What are [traits](https://doc.rust-lang.org/book/ch10-02-traits.html)?, How to use, Popular traits, ... 
1. See [derive doc](./traits.derive.md)
1. Traits are frustrating if you don't understand the prerequisites first


## Prerequisites
1. Understand [ownership](./ownership.md)
1. Understand [`Sized`](https://doc.rust-lang.org/std/marker/trait.Sized.html) and [`?Sized`](https://doc.rust-lang.org/std/marker/trait.Sized.html)
1. Understand [references]((./references_pointers.md)) 
    

# Definitions
1. A trait is a collection of **methods** defined for an **unknown type**, called `Self`
    1. Type can be resolved at compile time (generics) or at runtime (`dyn`)
1. Marker trait: agreement between user and implementer for something the compiler cannot represent
1. Traits can be used with static dispatch (generics) or with dynamic dispatch (trait objects via `dyn`)


# Static dispatch
1. [Generics](https://doc.rust-lang.org/book/ch10-01-syntax.html), [monomorphization](https://rustwasm.github.io/twiggy/concepts/generic-functions-and-monomorphization.html)
1. Faster than [dynamic dispatch](https://www.cs.brandeis.edu/~cs146a/rust/doc-02-21-2015/book/static-and-dynamic-dispatch.html), but slightly larger binary
    1. Compiler generates an (separately optimizable) version for each type you call the `fn`
1. `impl MyTrait` is resolved at compile time
1. Limited use
    1. Only works with known [size](https://doc.rust-lang.org/std/marker/trait.Sized.html) types
    1. Cannot use different implementations in the same collection


# Dynamic dispatch (`dyn`)
1. `dyn` is only ever useful with Traits
1. Dynamic dispatch More flexible than static dispatch at runtime
1. Dynamic dispatch produces slightly smaller binary than static dispatch
1. `dyn` tells the compiler not to determine the exact type (just use a reference and deal with it at runtime, vtable)
1. `dyn` can make parts of your code (slightly) slower (eg. at the same level as Go, Java, C#, ...)
    1. virtual function call, [vtable](https://en.wikipedia.org/wiki/Virtual_method_table) lookup, etc
1. `dyn` disables some arithmetic optimizations & inlining
1. Must access `dyn` behind a pointer (or smart pointer) because compiler doesn't know the type (and therefore doesn't know the size)
    - `&dyn MyTrait`: **borrowed**, heap allocated (pointer)
    - `Box<dyn MyTrait>`: **owned**, heap allocated (smart pointer)
    - `Rc<dyn MyTrait>`: **shared ownership**, heap allocated (smart pointer)


## Conversions
1. See examples in [references doc](./references_pointers.md)


## Relation to Collections
# `Vec<&dyn MyTrait>`
1. TODO

# ~~`Vec<Box<dyn MyTrait>>`~~ (Anti-pattern)
1. [Overly complex](https://rust-lang.github.io/rust-clippy/master/#vec_box)

# `Vec<Rc<dyn MyTrait>>`
1. TODO


# Language Comparison

## Java
1. Similar to [java interfaces](https://docs.oracle.com/javase/tutorial/java/concepts/interface.html)
    1. Traits can "extend" other traits
    1. Traits *cannot* have fields, just methods
1. Differences
    1. implementation is decoupled from the type (`impl` block is separate from struct/enum/type)
    1. Trait implementation is outside the type’s definition
    1. Can choose between vtable/indirect dispatch (heap allocated) and static/direct dispatch


## Golang
1. Similar to [golang interfaces](https://go.dev/ref/spec#Interface_types)
    1. Traits can "extend" other traits
    1. Traits *cannot* have fields, just methods
1. Differences
    1. Traits are **explicitly** implemented on types
    1. No embedding


## C++
1. Similar to c++ [abstract classes](TODO)
    1. Traits can "extend" other traits
1. Differences
    1. TODO: no fields
    1. [Operator overloading](https://doc.rust-lang.org/rust-by-example/trait/ops.html) works via traits


# Gotchas
1. If you see error message about [object safe](https://doc.rust-lang.org/reference/items/traits.html#object-safety), add `&self` param to your trait fn
1. Traits + Generics are hard to use
    1. eg. try to return `Vec<MyTrait>`
1. Start by owning & cloning,
    1. Use `Box` for ownership     
    1. Use `&dyn MyTrait` for dynamic dispatch (vtable)
    1. `impl Debug for dyn MyTrait { ... }` 
    1. Use `Vec<Box<dyn MyTrait>>` for collection
         


# TODO/Unorganized
- TODO: trait implementations must be in separate `impl` block from unrelated methods
- TODO: https://doc.rust-lang.org/book/ch10-02-traits.html
- TODO: https://doc.rust-lang.org/rust-by-example/trait.html
- TODO: https://web.mit.edu/rust-lang_v1.25/arch/amd64_ubuntu1404/share/doc/rust/html/book/first-edition/traits.html
- TODO: https://www.educative.io/answers/what-are-traits-in-rust
- TODO: https://blog.logrocket.com/rust-traits-a-deep-dive/
- TODO: https://www.chiark.greenend.org.uk/~ianmdlvl/rust-polyglot/traits.html
- TODO: https://oswalt.dev/2020/07/rust-traits-defining-behavior/
- TODO: https://stevedonovan.github.io/rustifications/2018/09/08/common-rust-traits.html
- TODO: https://vino.dev/blog/node-to-rust-day-10-traits/
- TODO: https://cheats.rs/#generics-constraints
- TODO: compiler needs to know how much space every function's return type requires
- TODO: when is `into` required (and when is it implicit?)

- TODO: https://miro.medium.com/max/1100/1*CCwiXyyiueRGZli1f3GCzw.webp (excellent diagram)

# Other Resources
1. https://doc.rust-lang.org/book/ch10-02-traits.html
1. https://doc.rust-lang.org/rust-by-example/trait.html
1. https://medium.com/digitalfrontiers/rust-dynamic-dispatching-deep-dive-236a5896e49b
