# Overview
1. Tips for testing

# Assertions
1. [`assert!`](https://doc.rust-lang.org/std/macro.assert.html)
1. [`assert_eq!`](https://doc.rust-lang.org/std/macro.assert_eq.html)
1. [`assert_ne!`](https://doc.rust-lang.org/std/macro.assert_ne.html)


# Live template candidates

## build-test-module
```rust
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn should_whatever() -> Result<(), anyhow::Error> {
        //
    }
}
```


# Async tests
```rust
#[tokio::test]
async fn should_be_nice() -> Result<(), anyhow::Error> {

   // ...
}
```


# Serial vs Parallel tests
1. If your tests manipulate shared things like env vars,
    - Use a crate like [serial_test](https://docs.rs/serial_test/latest/serial_test/)
1. Conceptually similar to [JUnit `@ResourceLock`](https://junit.org/junit5/docs/5.3.0-M1/user-guide/index.html#writing-tests-parallel-execution-synchronization)


# Other Resources
1. Basics:
    1. https://doc.rust-lang.org/rust-by-example/testing/unit_testing.html
    1. https://doc.rust-lang.org/book/ch11-01-writing-tests.html
1. Organizing tests:
    1. https://doc.rust-lang.org/book/ch11-03-test-organization.html
    1. https://blog.logrocket.com/how-to-organize-rust-tests/

