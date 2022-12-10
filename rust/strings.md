# Overview
1. Key points about [strings](https://doc.rust-lang.org/rust-by-example/std/str.html)
1. How [Rust strings differ from Java, Go, C, etc](https://dev.to/loige/comment/1maa0)


# Summary
||Immutable|Mutable|
|---|---|---|
|Owned|`String` <br/>`PathBuf` <br/>`OsString` <br/>`Vec<T>`|`String` (`mut` on variable/argument) <br/>`PathBuf` (`mut` on variable/argument) <br/>`OsString` (`mut` on variable/argument) <br/>`Vec<T>` (`mut` on variable/argument)|
|Borrowed|`&str` <br/>`&Path` <br/>`&OsStr` <br/>`&[T]` <br/>~~`&String`~~ (double pointer) <br/>~~`&PathBuf`~~ (double pointer) |`&mut String` (double pointer)|


# Types

## [String](https://doc.rust-lang.org/std/string/struct.String.html)
1. `Ownership`: [Owned](./ownership.md) version of [`&str`](https://doc.rust-lang.org/std/str/index.html)
1. `Mutability`: Growable, Mutable (eg. truncate, extend, etc)
1. `Length`: dynamic
1. `Allocated`: [Heap](./memory.md) always
1. `Guarantees`: always valid [UTF-8](https://en.wikipedia.org/wiki/UTF-8)
1. **Not** null terminated (compare to c & c++), `\n` is treated as newline
1. [`String`](https://doc.rust-lang.org/std/string/struct.String.html) "extends" `&str` with mutable behavior

### Comparison
- Golang equivalent: [`strings.Builder`](https://pkg.go.dev/strings#Builder)
- Java equivalent: [`StringBuilder`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/StringBuilder.html)


## [&str](https://doc.rust-lang.org/std/str/index.html)
1. `Ownership`: [Borrowed](./ownership.md) version of [`String`](https://doc.rust-lang.org/std/string/struct.String.html)
1. `Mutability`: Immutable and read-only
1. `Length`: fixed
1. `Allocated`: [Heap](./memory.md) or static (TODO: be clearer)
1. `Guarantees`: always valid [UTF-8](https://en.wikipedia.org/wiki/UTF-8) (Unicode)
1. a.k.a. ["slice"](https://doc.rust-lang.org/book/ch04-03-slices.html#string-slices)
1. [`&str` is a slice (`&[u8]`)](https://doc.rust-lang.org/rust-by-example/std/str.html), always points to a valid UTF-8 sequence
1. [String literals](https://doc.rust-lang.org/rust-by-example/std/str.html#literals-and-escapes) are `&'static str` (live forever, immutable, borrowed)


### Comparison
- Golang equivalent: [`string`](https://pkg.go.dev/builtin#string), see also [strings doc](../golang/strings.md)
- Java equivalent: [`String`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/String.html)
- JavaScript equivalent: [`String`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String)
- Python equivalent: [`String`](https://docs.python.org/3/library/stdtypes.html#textseq)


# [PathBuf](https://doc.rust-lang.org/stable/std/path/struct.PathBuf.html)
1. `Ownership`: [Owned](./ownership.md) version of [`&Path`](https://doc.rust-lang.org/stable/std/path/struct.Path.html)
1. `Mutability`: Mutable
1. TODO
1. **Not** guaranteed UTF-8
1. For both relative and absolute paths
1. Each individual component is a `&OsStr`
1. Growable, Heap allocated


# [&Path](https://doc.rust-lang.org/stable/std/path/struct.Path.html)
1. `Ownership`: [Borrowed](./ownership.md) version of [`PathBuf`](https://doc.rust-lang.org/stable/std/path/struct.PathBuf.html)
1. **Not** guaranteed UTF-8
1. For both relative and absolute paths
1. Each individual component is a `&OsStr`


# [OsString](https://doc.rust-lang.org/std/ffi/struct.OsString.html)
1. `Ownership`: [Owned](./ownership.md) version of [`&OsStr`](https://doc.rust-lang.org/std/ffi/struct.OsStr.html)
1. `Mutability`: Mutable
1. System specific (eg. Linux, Mac, Android, win, etc)
1. UTF-8 on Linux, Mac, Android
1. UTF-16 strings on Windows
1. Superset of `String`
1. Growable, Heap allocated


# [&OsStr](https://doc.rust-lang.org/std/ffi/struct.OsStr.html)
1. `Ownership`: [Borrowed](./ownership.md) version of [`OsString`](https://doc.rust-lang.org/std/ffi/struct.OsString.html)
1. `Mutability`: Immutable
1. Superset of `&str`


# [CString](https://doc.rust-lang.org/stable/std/ffi/struct.CString.html)
1. `Ownership`: [Owned](./ownership.md)
1. `Mutability`: Mutable
1. For interacting with [C](https://en.wikipedia.org/wiki/C_(programming_language))
1. NUL-terminated


# [&CStr](https://doc.rust-lang.org/stable/std/ffi/struct.CStr.html)
1. `Ownership`: [Borrowed](./ownership.md)
1. For interacting with [C](https://en.wikipedia.org/wiki/C_(programming_language))
1. `Mutability`: Immutable
1. TODO


# Raw strings
```rust
assert_eq!("foo", r"foo");          // foo
assert_eq!("\"foo\"", r#""foo""#);  // "foo"

assert_eq!("", r#""#);          // (empty string)
assert_eq!("\"", r#"""#);       // "
assert_eq!("\"\"", r#""""#);    // ""

assert_eq!("#", r##"#"##);          // #
assert_eq!("\"#\"", r##""#""##);    // "#"
```


# Escaping
1. Double quote (for `String`/`&str`): `\"`
1. Single quote (for `char`): `\'`


# Comparison
1. Unlike Go, Rust doesn't support [backtick strings](https://yourbasic.org/golang/multiline-string/)
    1. [Raw strings are similar](https://rahul-thakoor.github.io/rust-raw-string-literals/), [more info](https://doc.rust-lang.org/rust-by-example/std/str.html),
1. Unlike TS/JS, Rust doesn't support single quote strings


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

## Literal to `&str`
```rust
let input: &'static str = "some literal";
...
let output: &str = input;
```


## `String` to `&str`
```rust
let input: String = String::new();
...
let output0 = input.as_str();
let output1 = &input[..];
let output2 = &input;
```


## Literal to `String`
```rust
let input: &'static str = "some literal";
...
let output = input.to_owned();
```


## `&str` to `String`
```rust
let input: &str = "foo";
...
let output: String = input.to_owned();
```


# Concatenation
1. First part must be **owned** ([`String`](https://doc.rust-lang.org/std/string/struct.String.html))
1. subsequent parts must be [borrowed](https://doc.rust-lang.org/std/primitive.str.html)
1. [Why?](https://doc.rust-lang.org/std/string/struct.String.html#impl-Add%3C%26str%3E-for-String)


## Examples
```rust
// String + &str (simplest case)
print!("{:?}", owned_string + my_str);

// String + literal
print!("{:?}", owned_string + "literal");

// String + String
print!("{:?}", owned_string1 + &owned_string2);


// &str + literal
print!("{:?}", my_str.to_owned() + "literal");

// &str + String
print!("{:?}", my_str.to_owned() + &owned_string);
print!("{:?}", my_str.to_owned() + owned_string.borrow());

// &str + &str
print!("{:?}", my_str1.to_owned() + my_str2);


// literal + &str
print!("{:?}", "literal".to_owned() + my_str);

// literal + String
print!("{:?}", "literal".to_owned() + &owned_string);
print!("{:?}", "literal".to_owned() + owned_string.borrow());

// literal + literal
let s: &str = concat!("a", "b"); // only works with literals
print!("{:?}", "foo".to_owned() + "bar");
```


## Other methods
- [`&str.to_string()`](https://doc.rust-lang.org/std/string/trait.ToString.html#impl-ToString-for-str) calls [`String::from`](https://doc.rust-lang.org/stable/std/convert/trait.From.html#impl-From%3C%26str%3E-for-String)
- [`String::from`](https://doc.rust-lang.org/stable/std/convert/trait.From.html#impl-From%3C%26str%3E-for-String) calls [`&str.to_owned()`](https://doc.rust-lang.org/stable/std/borrow/trait.ToOwned.html#impl-ToOwned-for-str)
- [`&str.to_owned()`](https://doc.rust-lang.org/stable/std/borrow/trait.ToOwned.html#impl-ToOwned-for-str) allocates a new `String`


# Abbreviate
```rust
pub fn abbreviate(s: &str, max_len: usize) -> String {
    let bound = open_upper_bound_for_chars(s.len(), max_len);
    if bound.is_none() {
        return s.to_string();
    }

    let bound = bound.unwrap();

    let mut out = String::with_capacity(max_len);
    out.push_str(&s[..bound]);
    if must_add_elipses(s.len(), max_len) {
        out.push_str("...");
    }

    out
}

fn open_upper_bound_for_chars(str_len: usize, max_output_len: usize) -> Option<usize> {
    if str_len <= max_output_len {
        return Some(str_len);
    }

    let suffix_len = 3; // = "...".len();
    if max_output_len <= suffix_len {
        return None;
    }

    Some(max_output_len - suffix_len)
}

fn must_add_elipses(str_len: usize, max_output_len: usize) -> bool {    
    3 < max_output_len && max_output_len < str_len
}
```


# Other Resources
1. https://blog.logrocket.com/understanding-rust-string-str/
1. https://locka99.gitbooks.io/a-guide-to-porting-c-to-rust/content/features_of_rust/strings.html
1. https://cheats.rs/#strings-chars
1. https://cheats.rs/#owned-strings
1. https://web.mit.edu/rust-lang_v1.25/arch/amd64_ubuntu1404/share/doc/rust/html/book/first-edition/strings.html
1. https://iq.opengenus.org/rust-string-concat/
