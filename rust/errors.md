# Overview
1. Idioms for error handling
1. How to use [`anyhow`](https://docs.rs/anyhow/latest/anyhow/) and [`thiserror`](https://docs.rs/thiserror/latest/thiserror/)


# Summary of key ideas for success
1. Idiomatic error handling can be verbose (without libs)
1. Define [an error type](https://docs.rs/thiserror/latest/thiserror/#example) for your crate (eg. `MyCustomError`).
    1. [thiserror](https://github.com/dtolnay/thiserror) library [makes this simple](https://docs.rs/thiserror/latest/thiserror/)
    1. More examples: [one](https://fettblog.eu/rust-enums-wrapping-errors/), [two](https://www.lpalmieri.com/posts/error-handling-rust/#modelling-errors-as-enums)
1. Return a [`std::result::Result<Something, MyCustomError>`](https://doc.rust-lang.org/std/result/enum.Result.html) from most of your functions
    1. [`anyhow::Result<T>`](https://docs.rs/anyhow/latest/anyhow/type.Result.html) is fine for prototyping
    1. Production/robust/fast code should use your custom error directly in the [`Result`](https://doc.rust-lang.org/std/result/enum.Result.html)
1. Ensure your custom error type implements [`std::error::Error`](https://doc.rust-lang.org/std/error/trait.Error.html) trait
    1. again, [thiserror](https://docs.rs/thiserror/latest/thiserror/derive.Error.html) makes this easy via [`#[derive(Debug, Error)]`](https://docs.rs/thiserror/latest/thiserror/derive.Error.html)
1. Inside functions, use [`?` operator](https://doc.rust-lang.org/reference/expressions/operator-expr.html#the-question-mark-operator) to simplify caller & chain calls
1. Don't [`panic!`](https://doc.rust-lang.org/std/macro.panic.html)
    1. No [`.unwrap()`](https://doc.rust-lang.org/std/result/enum.Result.html#method.unwrap) nor [`.expect()`](https://doc.rust-lang.org/std/result/enum.Result.html#method.expect) in production code
1. Only add [logs](./logging.md) where you **handle** the error, not where you propagate ([`?`](https://doc.rust-lang.org/reference/expressions/operator-expr.html#the-question-mark-operator))
1. Add extra context ...
    1. Using fields on your Custom Error type variants
    1. Using [fields](https://doc.rust-lang.org/rust-by-example/custom_types/enum.html#enums) on your custom error type
    1. Using [tracing](./tracing.md) or [logging](./logging.md)
    1. Using [`some_result.context("...")?`](https://docs.rs/anyhow/latest/anyhow/trait.Context.html) to add extra error details
        1. [`.with_context("...")?`](https://docs.rs/anyhow/latest/anyhow/trait.Context.html#tymethod.with_context) is the lazy version
1. `impl From<foreign::SomeError> for MyCustomError {` to translate foreign errors ([thiserror](https://docs.rs/thiserror/latest/thiserror/#details) can generate)
    1. ```rust
        #[error("io error")]
        StdIoError {
            #[from]
            source: std::io::Error,
            backtrace: Backtrace,
        },```
1. Use [`if-let`](https://doc.rust-lang.org/rust-by-example/flow_control/if_let.html) or [`match`](https://doc.rust-lang.org/book/ch09-02-recoverable-errors-with-result.html#matching-on-different-errors) on error when needed for control flow
```
let res = something_risky(...)
if let Err(MyCustomVariant(_)) = res {
  // ...
}

if let Ok(s) = res {
  // ...
}
```


# While prototyping ...
1. Use [`anyhow`](https://docs.rs/anyhow/latest/anyhow/) ...
    1. [`anyhow::Result`](https://docs.rs/anyhow/latest/anyhow/type.Result.html) as return type on most `fn`
    1. [`anyhow::ensure!`](https://docs.rs/anyhow/latest/anyhow/macro.ensure.html) to check [preconditions](https://github.com/google/guava/wiki/PreconditionsExplained)


# [thiserror](https://docs.rs/thiserror/latest/thiserror/)
1. Low-level error handling lib
1. thiserror helps ...
    1. to build an idiomatic custom error type
    1. to generate a [`From`](https://doc.rust-lang.org/std/convert/trait.From.html) impl
    1. to implement [`Display`](https://doc.rust-lang.org/std/fmt/trait.Display.html) and [`Debug`](https://doc.rust-lang.org/std/fmt/trait.Debug.html) for custom error type
1. Add [`#[derive(Error, Debug)]`](https://docs.rs/thiserror/latest/thiserror/#example) to your crate level `Error` enum
1. [`#[error]`](https://docs.rs/thiserror/latest/thiserror/#details) attribute is for [`Display`](https://doc.rust-lang.org/std/fmt/trait.Display.html)
1. [`#[from]`](https://docs.rs/thiserror/latest/thiserror/#details) attribute is for [`From`](https://doc.rust-lang.org/std/convert/trait.From.html)
1. [`#[source]`](https://docs.rs/thiserror/latest/thiserror/#details) attribute is for root cause (see [Error chaining](https://docs.rs/anyhow/latest/anyhow/struct.Chain.html))
1. Alternative: [snafu](https://docs.rs/snafu/latest/snafu/index.html)


# [anyhow](https://docs.rs/anyhow/latest/anyhow/)
1. High-level error handling lib
1. Very useful for prototyping phase
1. Use [`Err(anyhow!("foo {}", bar))`](https://docs.rs/anyhow/latest/anyhow/macro.anyhow.html) for one-off (adhoc) error message
    1. or [`bail!("foo {}", bar)`](https://docs.rs/anyhow/latest/anyhow/macro.bail.html) shorthand
1. [`chain()`](https://docs.rs/anyhow/latest/anyhow/struct.Chain.html) lets you iterate Error causes
1. Use [downcasting](https://docs.rs/anyhow/1.0.4/anyhow/struct.Error.html#example-1) to get the original error type
    1. [`anyhow::Error::downcast_ref::<io::Error>()`](https://docs.rs/anyhow/latest/anyhow/struct.Error.html#method.downcast_ref)


# Unorganized/TODO
- TODO: RUST_BACKTRACE=1


# Other Resources
1. https://vino.dev/blog/node-to-rust-day-14-managing-errors/
1. https://docs.rs/anyhow/latest/anyhow/
1. https://docs.rs/thiserror/latest/thiserror/
1. https://doc.rust-lang.org/rust-by-example/std/result/question_mark.html
1. https://doc.rust-lang.org/book/ch09-02-recoverable-errors-with-result.html
