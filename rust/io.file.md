# Overview
1. Important types related to File IO
1. Some patterns for IO


# Related Types

## [`Write`](https://doc.rust-lang.org/std/io/trait.Write.html) trait
- Two methods: [`write`](https://doc.rust-lang.org/std/io/trait.Write.html#tymethod.write) and [`flush`](https://doc.rust-lang.org/std/io/trait.Write.html#tymethod.flush)
- Comparison:
    - Golang: [`bufio.Writer`](https://pkg.go.dev/bufio#Writer)
    - Java: [`BufferedWriter`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/io/BufferedWriter.html)
    - Python: [`io.IOBase`](https://docs.python.org/3/library/io.html#io.IOBase)
    - C++ [`ostream`](https://cplusplus.com/reference/ostream/ostream/write/)


## [`File`](https://doc.rust-lang.org/std/fs/struct.File.html)
- Implements [`Write`](https://doc.rust-lang.org/std/fs/struct.File.html#impl-Write-for-%26File)


## [`Pathbuf`](https://doc.rust-lang.org/stable/std/path/struct.PathBuf.html)
- TODO

## [`Path`](https://doc.rust-lang.org/stable/std/path/struct.Path.html)
- TODO


- TODO: prune table below
||Immutable|Mutable|
|---|---|---|
|Owned|`String` <br/>`PathBuf` <br/>`OsString` <br/>`Vec<T>`|`String` (`mut` on variable/argument) <br/>`PathBuf` (`mut` on variable/argument) <br/>|
|Borrowed|`&str` <br/>`&Path` <br/>`&OsStr` <br/>`&[T]` <br/>~~`&mut str`~~ (behaves like `&str`) <br/>~~`&String`~~ (double pointer) <br/>~~`&PathBuf`~~ (double pointer) |`&mut String` (double pointer)|


# [Temp files](https://docs.rs/tempfile/latest/tempfile/)
```rust
use tempfile::NamedTempFile;
...

let mut file = NamedTempFile::new().unwrap();
file.write_all("...".as_bytes()).unwrap();

// file is auto-deleted when it goes out of scope
```


# Other Resources
1. https://rust-lang-nursery.github.io/rust-cookbook/
