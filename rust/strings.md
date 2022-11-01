# Overview
1. Key points about [strings](https://doc.rust-lang.org/rust-by-example/std/str.html)
1. How [Rust strings differ from Java, Go, C, etc](https://dev.to/loige/comment/1maa0)


# Types
## [String](https://doc.rust-lang.org/std/string/struct.String.html)
1. `Ownership`: [Owned](./ownership.md)
1. `Mutability`: Growable, Mutable (eg. truncate, extend, etc)
1. `Length`: dynamic
1. `Allocated`: [Heap](./memory.md)
1. `Guarantees`: always valid [UTF-8](https://en.wikipedia.org/wiki/UTF-8)
1. **Not** null terminated (compare to c & c++), `\n` is treated as newline

### Comparison
- Golang equivalent: [`strings.Builder`](https://pkg.go.dev/strings#Builder)
- Java equivalent: [`StringBuilder`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/StringBuilder.html)


## [&str](https://doc.rust-lang.org/std/str/index.html)
1. `Ownership`: [Borrowed](./ownership.md)
1. `Mutability`: Immutable and read-only
1. `Length`: fixed
1. `Allocated`: [Heap](./memory.md) or static (TODO: be clearer)
1. `Guarantees`: always valid [UTF-8](https://en.wikipedia.org/wiki/UTF-8)
1. a.k.a. ["slice"](https://doc.rust-lang.org/book/ch04-03-slices.html#string-slices)

### Comparison
- Golang equivalent: [`string`](https://pkg.go.dev/builtin#string), see also [strings doc](../golang/strings.md)
- Java equivalent: [`String`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/String.html)
- JavaScript equivalent: [`String`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String)
- Python equivalent: [`String`](https://docs.python.org/3/library/stdtypes.html#textseq)


# [PathBuf](https://doc.rust-lang.org/stable/std/path/struct.PathBuf.html)
1. `Ownership`: [Owned](./ownership.md) version of [`&Path`](https://doc.rust-lang.org/stable/std/path/struct.Path.html)
1. `Mutability`: Mutable
1. TODO


# [&Path](https://doc.rust-lang.org/stable/std/path/struct.Path.html)
1. `Ownership`: [Borrowed](./ownership.md) version of [`PathBuf`](https://doc.rust-lang.org/stable/std/path/struct.PathBuf.html)
1. TODO


# [OsString](https://doc.rust-lang.org/std/ffi/struct.OsString.html)
1. `Ownership`: [Owned](./ownership.md) version of [`&OsStr`](https://doc.rust-lang.org/std/ffi/struct.OsStr.html)
1. `Mutability`: Mutable
1. System specific (eg. Linux, Mac, Android, win, etc)
1. UTF-8 on Linux, Mac, Android
1. UTF-16 strings on Windows


# [&OsStr](https://doc.rust-lang.org/std/ffi/struct.OsStr.html)
1. `Ownership`: [Borrowed](./ownership.md) version of [`OsString`](https://doc.rust-lang.org/std/ffi/struct.OsString.html)


# [CString](https://doc.rust-lang.org/stable/std/ffi/struct.CString.html)
1. `Ownership`: [Owned](./ownership.md)
1. for interacting with C
1. NUL-terminated


# [&CStr](https://doc.rust-lang.org/stable/std/ffi/struct.CStr.html)
1. `Ownership`: [Borrowed](./ownership.md)
1. TODO


# Idioms
1. `fn` args should accept [`&str`](https://doc.rust-lang.org/std/str/index.html) as fn arg, not [`String`](https://doc.rust-lang.org/std/string/struct.String.html)
    1. accepting `&str` allows caller to pass either `String` or `&str`
1. `fn` should return [`String`](https://doc.rust-lang.org/std/string/struct.String.html), not [`&str`](https://doc.rust-lang.org/std/primitive.str.html)
    1. give up ownership and let the caller decide on mutability


# String literals
1. static lifetime (guaranteed valid for duration of entire program)
1. We only every borrow them, never own them
1. TODO: raw strings


# Common operations
- [See all](../common/strings.gen.md)


# Conversion
- [`&str.to_string()`](https://doc.rust-lang.org/std/string/trait.ToString.html#impl-ToString-for-str) calls [String::from](https://doc.rust-lang.org/stable/std/convert/trait.From.html#impl-From%3C%26str%3E-for-String)
- [String::from](https://doc.rust-lang.org/stable/std/convert/trait.From.html#impl-From%3C%26str%3E-for-String) calls [&str.to_owned()](https://doc.rust-lang.org/stable/std/borrow/trait.ToOwned.html#impl-ToOwned-for-str), which allocates a new String
- [&str.to_owned()](https://doc.rust-lang.org/stable/std/borrow/trait.ToOwned.html#impl-ToOwned-for-str), which allocates a new String


# Ownership
|Owned|Borrowed|
|---|---|
|`String`|`&str`, `&String`, `&mut String`|
|`PathBuf`|`&path`, `&PathBuf`, `&mut PathBuf`|
|`OsString`|TODO|


# Mutability
|Mutable|Immutable|
|---|---|
|`String`, `&mut String`|`&String`, `&str`|
|`OsString`, `&mut OsString`|`&OsString`, `&OsStr`|


# Other resources
1. https://blog.logrocket.com/understanding-rust-string-str/
1. https://locka99.gitbooks.io/a-guide-to-porting-c-to-rust/content/features_of_rust/strings.html
1. https://cheats.rs/#strings-chars
1. https://cheats.rs/#owned-strings
1. https://web.mit.edu/rust-lang_v1.25/arch/amd64_ubuntu1404/share/doc/rust/html/book/first-edition/strings.html

