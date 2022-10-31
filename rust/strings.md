# Overview
1. Key points about strings
1. How [rust strings differ from Java, Go, C, etc](https://dev.to/loige/comment/1maa0)


# Types
## String
1. Ownership: Owned
1. Mutability: Growable, Mutable (eg. truncate, extend, etc)
1. Length: dynamic
1. Allocated: Heap
1. Guaranteed always valid [UTF-8](https://en.wikipedia.org/wiki/UTF-8)
1. **Not** null terminated (compare to c & c++), `\n` is treated as newline

### Comparison
- Golang equivalent: [`strings.Builder`](https://pkg.go.dev/strings#Builder)
- Java equivalent: [`StringBuilder`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/StringBuilder.html)


## [&str](https://doc.rust-lang.org/std/str/index.html)
1. Ownership: Borrowed
1. Mutability: Immutable & read-only
1. Length: fixed
1. Allocated: Heap or static (TODO: be clearer)
1. Guaranteed always valid [UTF-8](https://en.wikipedia.org/wiki/UTF-8)
1. aka "slice"

### Comparison
1. TODO


# String literals
1. static lifetime (guaranteed valid for duration of entire program)
1. We only every borrow them, never own them
1. TODO: raw strings


# [OsString](https://doc.rust-lang.org/std/ffi/struct.OsString.html)
1. Owned
1. System specific (eg. Linux, Mac, Android, win, etc)
1. UTF-8 on Linux, Mac, Android
1. UTF-16 strings on Windows


# [OsStr](https://doc.rust-lang.org/std/ffi/struct.OsStr.html)
1. Borrowed version of `OsString`


# CString
1. for interacting with C
1. NUL-terminated


# CStr
1. TODO


# PathBuf
1. TODO



# Idioms
1. `fn` args should accept [`&str`](https://doc.rust-lang.org/std/str/index.html) as fn arg, not [`String`](https://doc.rust-lang.org/std/string/struct.String.html)
    1. accepting `&str` allows caller to pass either `String` or `&str`
1. `fn` should return [`String`](TODO), not [`&str`](TODO)
    1. give up ownership and let the caller decide on mutability


# Common operations
- [See all](../common/strings.gen.md)


# Conversion
- [`&str.to_string()`](https://doc.rust-lang.org/std/string/trait.ToString.html#impl-ToString-for-str) calls [String::from](https://doc.rust-lang.org/stable/std/convert/trait.From.html#impl-From%3C%26str%3E-for-String) which calls [&str.to_owned()](https://doc.rust-lang.org/stable/std/borrow/trait.ToOwned.html#impl-ToOwned-for-str), which allocates a new String


# Other resources
1. https://blog.logrocket.com/understanding-rust-string-str/
1. https://locka99.gitbooks.io/a-guide-to-porting-c-to-rust/content/features_of_rust/strings.html
1. https://cheats.rs/#strings-chars
1. https://cheats.rs/#owned-strings

- TODO: https://www.kuniga.me/docs/rust/#string
