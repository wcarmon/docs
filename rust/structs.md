# Overview
1. TODO
1. See [traits doc](./traits.md)
1. See [modeling doc](./modeling.md)


# Key Concepts
1. A `struct` let us group related, named fields into one data structure
    1. [Tuples](https://doc.rust-lang.org/rust-by-example/primitives/tuples.html) let us group *unnamed* fields into one data structure
1. A `struct` is either **fully** mutable or **fully** immutable
1. [Exterior mutability](https://doc.rust-lang.org/rust-by-example/scope/borrow/mut.html) is checked and enforced [at compile-time](https://doc.rust-lang.org/std/keyword.mut.html)
1. Use [`derive`](./traits.derive.md) attribute to auto-generate [common traits](./traits.derive.md)
1. `Ownership`: Prefer to own fields in a struct ([Why?](https://www.lurklurk.org/effective-rust/lifetimes.html#lifetimes-in-data-structures))


# Destructuring
1. TODO


# Methods
1. TODO


# Idioms
1. ~~[Builder](https://docs.rs/derive_builder/latest/derive_builder/)~~
    1. Builder is simpler than multiple constructor `fn`s
    1. Builder doesn't help much because structs can be built by field name
    1. Builder allows incremental construction (which may or may not be a good idea)
    1. If you already implement [`Default`](https://doc.rust-lang.org/std/default/trait.Default.html), builder is wasted syntax/complexity (eg. must unwrap the build result)
    1. [Tradeoffs](https://rust-unofficial.github.io/patterns/patterns/creational/builder.html)
    1. [More tradeoffs](https://www.lurklurk.org/effective-rust/builders.html)
1. ~~[Getter](https://docs.rs/derive-getters/0.2.0/derive_getters/)~~
    1. doesn't help much because field-level [(exterior)](https://web.mit.edu/rust-lang_v1.25/arch/amd64_ubuntu1404/share/doc/rust/html/book/first-edition/mutability.html#interior-vs-exterior-mutability) mutability is already controlled by [references & ownership](https://web.mit.edu/rust-lang_v1.25/arch/amd64_ubuntu1404/share/doc/rust/html/book/first-edition/mutability.html#field-level-mutability)



# TODO/Unorganized
- TODO: https://www.kuniga.me/docs/rust/#struct


# Other Resources
1. https://web.mit.edu/rust-lang_v1.25/arch/amd64_ubuntu1404/share/doc/rust/html/book/first-edition/structs.html
1. https://web.mit.edu/rust-lang_v1.25/arch/amd64_ubuntu1404/share/doc/rust/html/book/first-edition/mutability.html#field-level-mutability
1. https://ricardomartins.cc/2016/06/08/interior-mutability
1. https://www.kuniga.me/docs/rust/#struct
