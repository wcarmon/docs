# Overview

1. Idioms for low-friction, maintenance-friendly error handling
1. How to use [`anyhow`](https://docs.rs/anyhow/latest/anyhow/) and [`thiserror`](https://docs.rs/thiserror/latest/thiserror/)

# Summary of Key Ideas for success

1. Errors are values
    1. Similar to golang
    1. Unlike Java, C++, Javascript/TypeScript, Python, etc
1. Idiomatic error handling can be verbose (without libs)
    1. although not nearly as bad as golang
1. [`anyhow`](https://docs.rs/anyhow/latest/anyhow/) (high-level) and [`thiserror`](https://docs.rs/thiserror/latest/thiserror/) (low-level) are excellent solutions
    1. Prefer [`anyhow`](https://docs.rs/anyhow/latest/anyhow/) unless you have extreme performance requirements (then use thiserror)
1. Return a [`Result<Something, anyhow::Error>`](https://doc.rust-lang.org/std/result/enum.Result.html) from most functions
    1. [`anyhow::Result`](https://docs.rs/anyhow/latest/anyhow/type.Result.html) as return type on most `fn`
1. Inside functions, use [`?` operator](https://doc.rust-lang.org/reference/expressions/operator-expr.html#the-question-mark-operator) to simplify caller & chain calls
1. [Preconditions](https://github.com/google/guava/wiki/PreconditionsExplained): Use [`anyhow::ensure!`](https://docs.rs/anyhow/latest/anyhow/macro.ensure.html)
1. Don't [`panic!`](https://doc.rust-lang.org/std/macro.panic.html)
    1. No [`.unwrap()`](https://doc.rust-lang.org/std/result/enum.Result.html#method.unwrap), it provides no helpful information and panics.
    1. Try to avoid [`.expect()`](https://doc.rust-lang.org/std/result/enum.Result.html#method.expect) in production code, useful in tests though
        1. Sometimes, this can be an alternative to nesting with the same "no-panic" guarantee
    1. It's fine to panic in test code.  Test Runner handles panic cleanly
1. Only add [logs](./logging.md) where you **handle** the error, not where you propagate ([`?`](https://doc.rust-lang.org/reference/expressions/operator-expr.html#the-question-mark-operator))
    1. use `context(...)` or `with_context(...)` instead (see below)
1. On Tests, Optionally return `Result<(), anyhow::Error>` to simplify `?` usage
1. When errors drive control flow, Use [`if-let`](https://doc.rust-lang.org/rust-by-example/flow_control/if_let.html) or [`match`](https://doc.rust-lang.org/book/ch09-02-recoverable-errors-with-result.html#matching-on-different-errors)

```rust
let res = something_risky(...)
if let Err(MyCustomVariant(_)) = res {
  // ...
}

if let Ok(s) = res {
  // ...
}
```

--------

# Adding extra context info

## Approach #1: [Eager context](https://docs.rs/anyhow/latest/anyhow/trait.Context.html)

```rust
something_dangerous(...)
  .context(
    format!("failed to do something dangerous: {some_local_var}"))?;
```

1. Compatible with [`?` operator](https://doc.rust-lang.org/reference/expressions/operator-expr.html#the-question-mark-operator)
1. [Official Example](https://docs.rs/anyhow/latest/anyhow/trait.Context.html#example)
1. `anyhow` crate adds [`.context(...)`](https://docs.rs/anyhow/latest/anyhow/trait.Context.html#tymethod.context) to the [`Result`](https://doc.rust-lang.org/nightly/core/result/enum.Result.html) type

## Approach #2: Lazy context

```rust
something_dangerous(...)
  .with_context(|| format!("failed to do something dangerous: {some_local_var}"))?;
  // useful when the context is expensive to build
```

1. Compatible with [`?` operator](https://doc.rust-lang.org/reference/expressions/operator-expr.html#the-question-mark-operator)
1. [`.with_context("...")?`](https://docs.rs/anyhow/latest/anyhow/trait.Context.html#tymethod.with_context) is the lazy version of `context(...)`
1. `anyhow` crate adds [`.with_context(...)`](https://docs.rs/anyhow/latest/anyhow/trait.Context.html#method.with_context-1) to the [`Result`](https://doc.rust-lang.org/nightly/core/result/enum.Result.html) type

## Approach #3: Tracing or Logging

- Using [Tracing](./tracing.md) or [Logging](./logging.md)

## Approach #4: Custom Error

1. most verbose option
1. Define [an error type](https://docs.rs/thiserror/latest/thiserror/#example) for your crate (eg. `MyCustomError`).
    1. [thiserror](https://github.com/dtolnay/thiserror) library [makes this simple](https://docs.rs/thiserror/latest/thiserror/)
    1. More examples: [one](https://fettblog.eu/rust-enums-wrapping-errors/), [two](https://www.lpalmieri.com/posts/error-handling-rust/#modelling-errors-as-enums)
1. Ensure your custom error type implements [`std::error::Error`](https://doc.rust-lang.org/std/error/trait.Error.html) trait
    1. again, [thiserror](https://docs.rs/thiserror/latest/thiserror/derive.Error.html) makes this easy via [`#[derive(Debug, Error)]`](https://docs.rs/thiserror/latest/thiserror/derive.Error.html)
1. Add [fields](https://doc.rust-lang.org/rust-by-example/custom_types/enum.html#enums) on your custom error type

--------

# Translate Foreign Errors:

1. The [`?` operator](https://doc.rust-lang.org/reference/expressions/operator-expr.html#the-question-mark-operator) looks for `impl From<ProducedError> for ReturnedError`
1. Idiom: `impl From<foreign::SomeError> for MyCustomError { ... }`
1. [thiserror](https://docs.rs/thiserror/latest/thiserror/#details) will generate this for you

```rust
    #[error("io error")]
    StdIoError {
        #[from]
        source: std::io::Error,
        backtrace: Backtrace,
    },
    
    ... other errors ...
```

--------

# Helpful Libraries

## [anyhow](https://docs.rs/anyhow/latest/anyhow/)

1. High-level error handling lib
1. Very useful for prototyping phase
1. Use [`Err(anyhow!("foo {}", bar))`](https://docs.rs/anyhow/latest/anyhow/macro.anyhow.html) for one-off (adhoc) error message
    1. or [`bail!("foo {}", bar)`](https://docs.rs/anyhow/latest/anyhow/macro.bail.html) shorthand
1. [`chain()`](https://docs.rs/anyhow/latest/anyhow/struct.Chain.html) lets you iterate Error causes
1. Use [downcasting](https://docs.rs/anyhow/1.0.4/anyhow/struct.Error.html#example-1) to get the original error type
    1. [`anyhow::Error::downcast_ref::<io::Error>()`](https://docs.rs/anyhow/latest/anyhow/struct.Error.html#method.downcast_ref)

## [thiserror](https://docs.rs/thiserror/latest/thiserror/)

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

--------

# Unorganized/TODO

- TODO: RUST_BACKTRACE=1

# Other Resources

1. https://nick.groenen.me/posts/rust-error-handling/
1. https://vino.dev/blog/node-to-rust-day-14-managing-errors/
1. https://docs.rs/anyhow/latest/anyhow/
1. https://docs.rs/thiserror/latest/thiserror/
1. https://doc.rust-lang.org/rust-by-example/std/result/question_mark.html
1. https://doc.rust-lang.org/book/ch09-02-recoverable-errors-with-result.html
