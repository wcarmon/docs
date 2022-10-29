# Overview
1. Idioms for error handling
1. How to use [`anyhow`](https://docs.rs/anyhow/latest/anyhow/) and [`thiserror`](https://docs.rs/thiserror/latest/thiserror/)


# Summary or key ideas
1. Idiomatic error handling can be verbose (without libs)
1. Use return [`anyhow::Result<T>`](https://docs.rs/anyhow/latest/anyhow/type.Result.html) for most `fn`
1. Use [`anyhow`](https://docs.rs/anyhow/latest/anyhow/) to ...
    1. `fn` return value, [`anyhow::Result`](https://docs.rs/anyhow/latest/anyhow/type.Result.html)
1. Use [`thiserror`](TODO) to ...
    1. building custom error type
    1. Generate a [`From`](https://doc.rust-lang.org/std/convert/trait.From.html) impl

1. Use [`?`](TODO) operator to simplify caller & chain calls
1. Make one `Error` enum at the top of your crate (see [`thiserror`](TODO) for examples
1. Add extra context ...
    1. Using fields on your custom error type
    1. Using [tracing](./tracing.md)/[logging](./logging.md)
    1. Using [`some_result.context("...")?`](https://docs.rs/anyhow/latest/anyhow/trait.Context.html) to add extra error details
        1. [`.with_context("...")?](https://docs.rs/anyhow/latest/anyhow/trait.Context.html#tymethod.with_context) is the lazy version
1. Don't `panic!`


# [anyhow](https://docs.rs/anyhow/latest/anyhow/)
1. High-level error handling lib
1. Use [`Err(anyhow!("foo {}", bar))`](https://docs.rs/anyhow/latest/anyhow/macro.anyhow.html) for one-off (adhoc) error message
    1. or [`bail!("foo {}", bar)`](https://docs.rs/anyhow/latest/anyhow/macro.bail.html) shorthand
1. [`chain()`](https://docs.rs/anyhow/latest/anyhow/struct.Chain.html) lets you iterate Error causes


# [thiserror](https://docs.rs/thiserror/latest/thiserror/)
1. Low-level error handling lib


- TODO: RUST_BACKTRACE=1
- TODO:
- TODO:
- TODO:

# Other resources
1. https://vino.dev/blog/node-to-rust-day-14-managing-errors/
1. https://docs.rs/anyhow/latest/anyhow/
1. https://docs.rs/thiserror/latest/thiserror/
1. https://doc.rust-lang.org/rust-by-example/std/result/question_mark.html
1. https://doc.rust-lang.org/book/ch09-02-recoverable-errors-with-result.html