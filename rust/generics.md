# Overview
1. Generics, Associated Types, Parametric polymorphism, monomorphization, ...


# Summary of key ideas
1. [Generic types](TODO) are resolved at compile time [(static dispatch)](TODO)
    1. [Traits](./traits.md) are resolved at runtime [(dynamic dispatch)](TODO)


# [Associated Types](TODO)
1. one struct/enum can only `impl` a `Trait` once
1. Associated Types are a simplification or specialized version of Generics
1. "Output types"
    1. eg. See how [`Iterator`](TODO) uses `Item` as an associated type for output of [`.next()`](TODO)
1. Eg. `Error` type for most failable traits


## Comparison
1. Java generics work this way because of [type erasure](https://docs.oracle.com/javase/tutorial/java/generics/erasure.html)


# [Generics](TODO)
1. one struct/enum can `impl` a `Trait` with **multiple** generic types
1. Useful for [`From`](https://doc.rust-lang.org/std/convert/trait.From.html)
1. "Input types" <-- TODO: I don't understand enough yet


# [Generic Associated Types](TODO)
1. TODO


# Other Resources
1. https://doc.rust-lang.org/beta/rust-by-example/generics/assoc_items/types.html
1. https://medium.com/codechain/rust-associated-type-b0193c22eacd
1. https://www.infoq.com/news/2022/11/rust-generic-associated-types/