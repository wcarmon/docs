# Overview

- TODO: https://cheats.rs/#strings-chars
- TODO: https://www.kuniga.me/docs/rust/#string

# Types
## String
1. Mutable (eg. truncate, extend, ...)
1. Growable
1. Owned
1. Guaranteed always valid [UTF-8](https://en.wikipedia.org/wiki/UTF-8)
1. Heap allocated
1. **Not** null terminated (compare to c & c++)

### Comparison
- Golang equivalent: [`strings.Builder`](https://pkg.go.dev/strings#Builder)
- Java equivalent: [`StringBuilder`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/StringBuilder.html)


## [&str](https://doc.rust-lang.org/std/str/index.html)
1. Borrowed
1. read-only
1. aka "slice"


### Comparison


# String literals
1. TODO


# Idioms
1. `fn` args should accept [`&str`](https://doc.rust-lang.org/std/str/index.html) as fn arg, not [`String`](https://doc.rust-lang.org/std/string/struct.String.html)
    1. accepting `&str` allows caller to pass either `String` or `&str`
1. `fn` should return [`String`](TODO), not [`&str`](TODO)
    1. give up ownership and let the caller decide on mutability


# Common operations
- [See all](../common/strings.gen.md)


# Other resources
1. https://blog.logrocket.com/understanding-rust-string-str/
1. https://locka99.gitbooks.io/a-guide-to-porting-c-to-rust/content/features_of_rust/strings.html