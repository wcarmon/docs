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


# Other Resources
1. Basics:
    1. https://doc.rust-lang.org/rust-by-example/testing/unit_testing.html
    1. https://doc.rust-lang.org/book/ch11-01-writing-tests.html
1. Organizing tests:
    1. https://doc.rust-lang.org/book/ch11-03-test-organization.html
    1. https://blog.logrocket.com/how-to-organize-rust-tests/

