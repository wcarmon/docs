# Overview
1. TODO


- TODO: https://www.kuniga.me/docs/rust/#struct


# Idioms
1. ~~[Builder](https://docs.rs/derive_builder/latest/derive_builder/)~~
    1. Builder is simpler than multiple constructor `fn`s
    1. Builder doesn't help much because structs can be built by field name
    1. Builder allows incremental construction (which may or may not be a good idea)
    1. If you already implement [`Default`](https://doc.rust-lang.org/std/default/trait.Default.html), builder is wasted syntax/complexity (eg. must unwrap the build result)
    1. [Tradeoffs](https://rust-unofficial.github.io/patterns/patterns/creational/builder.html)
1. ~~[Getter](https://docs.rs/derive-getters/0.2.0/derive_getters/)~~
    1. doesn't help much because mutability is already controlled by references & ownership


# Other Resources
1. TODO