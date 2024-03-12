# Overview
1. What are [traits](https://doc.rust-lang.org/book/ch10-02-traits.html)?, How to use, Popular traits, ... 
1. See [derive doc](./traits.derive.md)
1. Traits are frustrating if you don't understand the prerequisites first


## Prerequisites
1. Understand [Ownership](./ownership.md)
1. Understand [`Sized`](https://doc.rust-lang.org/std/marker/trait.Sized.html) and [`?Sized`](https://doc.rust-lang.org/std/marker/trait.Sized.html)
1. Understand [References]((./references_pointers.md)) 
    

# Definitions
1. A trait is a collection of **methods** defined for an **unknown type**, called `Self`
    1. Type can be resolved at compile time (generics & [Monomorphization](https://rustc-dev-guide.rust-lang.org/backend/monomorph.html)) or at runtime ([`dyn`](https://doc.rust-lang.org/std/keyword.dyn.html))
1. [Marker Trait](https://doc.rust-lang.org/std/marker/index.html): agreement between user and implementer for something the compiler cannot represent
1. Traits can be used with [static dispatch](https://www.cs.brandeis.edu/~cs146a/rust/doc-02-21-2015/book/static-and-dynamic-dispatch.html#static-dispatch) (generics) or with [dynamic dispatch](https://www.cs.brandeis.edu/~cs146a/rust/doc-02-21-2015/book/static-and-dynamic-dispatch.html#dynamic-dispatch) (trait objects via `dyn`)
1. Traits are a polymorphism tool.
1. Traits enable operator overloading 
1. Traits are the way we "hook-into" built-in functionality, for example:
    1. [`Add`](https://doc.rust-lang.org/std/ops/trait.Add.html) and [`Sub`](https://doc.rust-lang.org/std/ops/trait.Sub.html) allow your type with the `+` and `-` operators (summation & difference), (operator overloading)
    1. [`AddAssign`](https://doc.rust-lang.org/std/ops/trait.AddAssign.html) and [`SubAssign`](https://doc.rust-lang.org/std/ops/trait.SubAssign.html) allow your type to work with `+=` and `-=` operators (operator overloading)
    1. [`Clone`](https://doc.rust-lang.org/std/clone/trait.Clone.html) allows your type with [`cloned()`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.cloned) in iterators
    1. [`Debug`](https://doc.rust-lang.org/std/fmt/trait.Debug.html) allows a type to work with [`{:?}` syntax](https://doc.rust-lang.org/std/fmt/trait.Debug.html#examples)
    1. [`Deref`](https://doc.rust-lang.org/book/ch15-02-deref.html#implicit-deref-coercions-with-functions-and-methods) auto converts types for fn/method args (also useful with [NewType](https://doc.rust-lang.org/rust-by-example/generics/new_types.html) pattern)
    1. [`Display`](https://doc.rust-lang.org/std/fmt/trait.Display.html) allows your types in (user facing) print/format statements
    1. [`Drop`](https://doc.rust-lang.org/std/ops/trait.Drop.html) allows your type to cleanup when done (eg. closing connection pools, files, etc)
    1. [`Eq`](https://doc.rust-lang.org/std/cmp/trait.Eq.html) and [`PartialEq`](https://doc.rust-lang.org/std/cmp/trait.PartialEq.html) allow `==` operator on your type
    1. [`From`](https://doc.rust-lang.org/std/convert/trait.From.html) and [`TryFrom`](https://doc.rust-lang.org/std/convert/trait.TryFrom.html) help you auto convert between types (eg. transparently when invoking methods, automatic error conversion, when using [serde](https://serde.rs/container-attrs.html#try_from))
    1. [`Hash`](https://doc.rust-lang.org/std/hash/trait.Hash.html) allows your type in [`HashMap`](https://doc.rust-lang.org/std/collections/struct.HashMap.html) & [`HashSet`](https://doc.rust-lang.org/std/collections/struct.HashSet.html)
    1. [`Index`](https://doc.rust-lang.org/std/ops/trait.Index.html) allows your type to use the index operator `foo[7]`
    1. [`IntoIterator`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html) allows your type to work in [`for` loop](https://doc.rust-lang.org/std/iter/index.html#for-loops-and-intoiterator)
    1. [`LowerHex`](https://doc.rust-lang.org/std/fmt/trait.LowerHex.html) and [`UpperHex`](https://doc.rust-lang.org/std/fmt/trait.UpperHex.html) allow your numeric types to print as hexidecimal strings
    1. [`Not`](https://doc.rust-lang.org/std/ops/trait.Not.html) allows your type to work with `!` operator (eg. to invert an enum with two variants)
    1. [`Ord`](https://doc.rust-lang.org/std/cmp/trait.Ord.html) and [`PartialOrd`](https://doc.rust-lang.org/std/cmp/trait.PartialEq.html) allow your type with `<`, `>`, etc operators, allows as key for [`BTreeMap`](https://doc.rust-lang.org/std/collections/struct.BTreeMap.html) or [`BTreeSet`](https://doc.rust-lang.org/std/collections/struct.BTreeSet.html), and [allows sorting](https://doc.rust-lang.org/std/primitive.slice.html#method.sort)
    1. [`RangeBounds`](https://doc.rust-lang.org/std/ops/trait.RangeBounds.html) allows your type to work in ranges (like `..`, `a..`, `..b`)
    1. [`Try`](https://doc.rust-lang.org/std/ops/trait.Try.html) allows your type to work with the `?` operator (error propagation)
    1. `Deref`, `AsRef`, `Borrow` allows you to make your own pointers
1. Traits unify the rust community by standardizing how we do common things
1. Traits turn some runtime issues into compilation issues
    1. eg. `Hash` can catch if part of your object graph isn't hash compatible (like `f32` or `f64`)


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
1. `dyn` can make parts of your code [(slightly) slower](https://stackoverflow.com/questions/28621980/what-are-the-actual-runtime-performance-costs-of-dynamic-dispatch) (eg. at the same level as Go, Java, C#, ...)
    1. virtual function call, [vtable](https://en.wikipedia.org/wiki/Virtual_method_table) lookup, etc
1. `dyn` disables some arithmetic optimizations & inlining
1. Must access `dyn` behind a pointer (or smart pointer) because compiler doesn't know the type (and therefore doesn't know the size)
    - `&dyn MyTrait`: **borrowed**, heap allocated (pointer)
    - `Box<dyn MyTrait>`: **owned**, heap allocated (smart pointer)
    - `Rc<dyn MyTrait>`: **shared ownership**, heap allocated (smart pointer)

## Convert Implementation to Trait (upcast)
1. With regular pointer (`&`)
    ```rust
    let my_impl = MyImpl{...};
    
    let my_trait_obj: &dyn MyTrait = &my_impl; // coercion
    
    // or
    
    let my_trait_obj = &my_impl as &dyn MyTrait; // cast
    ```
1. With `Box` (or other Smart pointer)
    ```rust
    let my_impl = Box::new(MyImpl {...});
    
    let my_trait_obj: Box<dyn MyTrait> = my_impl;
    ```

## Convert Trait to implementation (downcast)
1. Convert trait object to any: `as &dyn Any`, then use [`downcast_ref`](https://doc.rust-lang.org/std/any/trait.Any.html#method.downcast_ref)
    ```rust
    let my_trait_obj: &dyn MyTrait = &Quux {...};
    
    if let Some(real_impl) = (&my_trait_obj as &dyn Any).downcast_ref::<Quux>() {
        // use `real_impl` here
    }
    ```


## Other Pointer Conversions
1. See examples in [references doc](./references_pointers.md)


## Relation to Collections
# `Vec<&dyn MyTrait>`
1. TODO

# ~~`Vec<Box<dyn MyTrait>>`~~ (Anti-pattern)
1. [Overly complex](https://rust-lang.github.io/rust-clippy/master/#vec_box)

# `Vec<Rc<dyn MyTrait>>`
1. TODO


# Same method, multiple traits
1. https://web.mit.edu/rust-lang_v1.25/arch/amd64_ubuntu1404/share/doc/rust/html/book/second-edition/ch19-03-advanced-traits.html#fully-qualified-syntax-for-disambiguation-calling-methods-with-the-same-name


# Language Comparison

## Java
1. Similar to [java interfaces](https://docs.oracle.com/javase/tutorial/java/concepts/interface.html)
    1. Traits can "extend" other traits
    1. Traits *cannot* have fields, just methods
1. Differences
    1. implementation is decoupled from the type (`impl` block is separate from struct/enum/type)
    1. Trait implementation is outside the type’s definition
    1. Can choose between vtable/indirect dispatch (heap allocated) and static/direct dispatch
    1. A type can implement same method on multiple traits (with different implementation)


## Golang
1. Similar to [golang interfaces](https://go.dev/ref/spec#Interface_types)
    1. Traits can "extend" other traits
    1. Traits *cannot* have fields, just methods
1. Differences
    1. Traits are **explicitly** implemented on types
    1. No embedding
    1. A type can implement same method on multiple traits (with different implementation)


## C++
1. Similar to c++ [abstract classes](TODO)
    1. Traits can "extend" other traits
1. Differences
    1. TODO: no fields
    1. [Operator overloading](https://doc.rust-lang.org/rust-by-example/trait/ops.html) works via traits
    1. A type can implement same method on multiple traits (with different implementation)


# Gotchas
1. If you see error message about [object safe](https://doc.rust-lang.org/reference/items/traits.html#object-safety), add `&self` param to your trait fn
1. Traits + Generics are hard to use
    1. eg. try to return `Vec<MyTrait>`
1. Start by owning & cloning,
    1. Use `Box` for ownership     
    1. Use `&dyn MyTrait` for dynamic dispatch (vtable)
    1. `impl Debug for dyn MyTrait { ... }` 
    1. Use `Vec<Box<dyn MyTrait>>` for collection
         

# [Trait Objects](https://doc.rust-lang.org/reference/types/trait-object.html)
1. An new type that behaves like a pointer to a Trait.
1. A (well defined) view of some other type.
1. Type is unknown at Compile time
1. We don't know the type until runtime (so, must use [`dyn` keyword](TODO)).
1. Because of type-erasure, users of the Trait Object lack access to the rest of the type (opaque)
1. Must access via `&` or `Box<...>` because they are dynamically sized (think heap)


## [Object safety](https://doc.rust-lang.org/reference/items/traits.html#object-safety)
1. A way to [restrict which traits](https://github.com/rust-lang/rfcs/blob/master/text/0255-object-safety.md) can be used as trait objects
1. `Pro`: Simplifies usage
1. `Pro`: Simplifies error messages, and they happen closer to the root cause
1. `Pro`: simplifies evolution of code that uses Traits
1. Base Trait: TODO



# TODO/Unorganized
- `Into` for owned parameter, `AsRef` for borrowed parameter
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
1. https://stackoverflow.com/questions/28621980/what-are-the-actual-runtime-performance-costs-of-dynamic-dispatch
