# Overview
1. Augmenting external types (new methods)


# Concept
- Adding method(s) to a type defined in another crate
- Challenging because of [The Orphan Rule](https://doc.rust-lang.org/book/ch10-02-traits.html?highlight=orphan#implementing-a-trait-on-a-type)


# Motivation
1. Helps the type system maintain invariants
1. Helps make code more ergonomic


# Rough Equivalent in other languages
- [Kotlin extensions](https://kotlinlang.org/docs/extensions.html)
- [C# extension methods](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/extension-methods)
- [Java with Manifold](https://github.com/manifold-systems/manifold/tree/master/manifold-deps-parent/manifold-ext)
- [JS monkeypatching](https://en.wikipedia.org/wiki/Monkey_patch)


# Pattern-A: Extension Trait (Simpler)

1. Define [Trait](./traits.md) (eg. `FooExt`)
1. Add new method stubs to the Trait (`impl FooExt {...}`)
1. `impl FooExt for SomeExternalType { ... }`
1. Use `SomeExternalType` normally, but import your `trait`, (eg. `use a::b::c::FooExt`)


# Pros & Cons
1. `Pro`: simple
1. `Pro`: can feel a bit magical, but the compiler/IDE can resolve methods correctly
1. `Con`: Conflicting extension traits
1. `Con`: Homograph traits are confusing (eg. [`std::io::Write`](https://doc.rust-lang.org/std/io/trait.Write.html)  and [`std::fmt::Write`](https://doc.rust-lang.org/std/fmt/trait.Write.html))


## Examples
- [`std::os::unix::fs::PermissionsExt`](https://doc.rust-lang.org/std/os/unix/fs/trait.PermissionsExt.html)
- [`std::os::linux::fs::MetadataExt`](https://doc.rust-lang.org/std/os/linux/fs/trait.MetadataExt.html)
- [``]()
- [``]()


## Other resources
1. https://www.howtocodeit.com/articles/ultimate-guide-rust-newtypes


# Pattern-B: [newtype](https://doc.rust-lang.org/rust-by-example/generics/new_types.html) (More powerful)

1. Concept: [proxy pattern](TODO)
1. Create a wrapper (tuple) struct `FooWrapper` (or some name logical for your domain)
1. Add methods to expose features on the inner type
1. Create a `FooWrapper::new(inner_type)` method to accept the inner type
1. `impl From<TheInnerType> for FooWrapper` or `impl TryFrom<TheInnerType> for FooWrapper`
    1. in either case, invoke `::new(...)`
1. Add a method to convert to the inner type: `pub fn as_foo(&self) -> TheInnerType`
    1. See the conversion method [naming](https://rust-lang.github.io/api-guidelines/naming.html#ad-hoc-conversions-follow-as_-to_-into_-conventions-c-conv) guide
1. `impl AsRef<TheInnerType> for FooWrapper`
1. `#[derive(...)]` the same traits (or `impl` manually when complex)
1. Add [`#[repr(transparent)]`](https://doc.rust-lang.org/reference/type-layout.html#the-transparent-representation) so the struct has the same layout in memory as the underlying type
1. Avoid ~~`Deref`~~ since it breaks encapsulation and has some side effects for `*` operator
1. (If using serde), add [`#[serde(transparent)]`](https://serde.rs/container-attrs.html#transparent) so the wrapper is ignored for serialization & deserialization


# Pros & Cons
1. `Pro`: can "add" or "remove" methods from types
1. `Pro`: stronger type safety & semantics (eg. [`NonZeroI32`](https://doc.rust-lang.org/std/num/type.NonZeroI32.html))
1. `Pro`: Type system enforces invariants (assuming newtype has validation)
1. `Con`: boilerplate


## Helpful crates:
    1. [derive_more](https://crates.io/crates/derive_more)
    1. Avoid/Skip the ~~`nutype`~~ crate, it's feature rich, but it's "frameworky" and becomes a dependency for everything downstream


## Examples
1. [example-1](https://doc.rust-lang.org/rust-by-example/generics/new_types.html)
1. [example-2](https://rust-unofficial.github.io/patterns/patterns/behavioural/newtype.html)
1. [example-3](https://doc.rust-lang.org/book/ch19-04-advanced-types.html)


## Other resources
1. https://rust-unofficial.github.io/patterns/patterns/behavioural/newtype.html
1. https://doc.rust-lang.org/book/ch19-03-advanced-traits.html?highlight=orphan#using-the-newtype-pattern-to-implement-external-traits-on-external-types
1. https://www.lurklurk.org/effective-rust/newtype.html
1. https://www.howtocodeit.com/articles/ultimate-guide-rust-newtypes