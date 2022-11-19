# Overview
1. Important types related to File IO
1. Some patterns for File IO


# Related Types

## [`Write`](https://doc.rust-lang.org/std/io/trait.Write.html) trait
- Two methods: [`write`](https://doc.rust-lang.org/std/io/trait.Write.html#tymethod.write) and [`flush`](https://doc.rust-lang.org/std/io/trait.Write.html#tymethod.flush)
- Comparison:
    - Golang: [`bufio.Writer`](https://pkg.go.dev/bufio#Writer)
    - Java: [`BufferedWriter`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/io/BufferedWriter.html)
    - Python: [`io.IOBase`](https://docs.python.org/3/library/io.html#io.IOBase)
    - C++ [`ostream`](https://cplusplus.com/reference/ostream/ostream/write/)


## [`File`](https://doc.rust-lang.org/std/fs/struct.File.html) struct
- Implements [`Write`](https://doc.rust-lang.org/std/fs/struct.File.html#impl-Write-for-%26File)
- Comparison:
    - Java: [`java.nio.file.Path`](https://docs.oracle.com/en/java/javase/18/docs/api/java.base/java/nio/file/Path.html) + methods on [`java.nio.file.Files`](https://docs.oracle.com/en/java/javase/18/docs/api/java.base/java/nio/file/Files.html)


## [`PathBuf`](https://doc.rust-lang.org/stable/std/path/struct.PathBuf.html)
- Owned
- Mutable


## [`Path`](https://doc.rust-lang.org/stable/std/path/struct.Path.html)
- Borrowed
- Comparison:
    - Golang: [`filepath`](https://pkg.go.dev/path/filepath)
    - Java: [`java.nio.file.Files`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/nio/file/Files.html)


||Immutable|Mutable|
|---|---|---|
|Owned|`String` <br/>`PathBuf` <br/>|`String` (`mut` on variable/argument) <br/>`PathBuf` (`mut` on variable/argument) <br/>|
|Borrowed|`&str` <br/>`&Path` <br/>~~`&String`~~ (double pointer) <br/>~~`&PathBuf`~~ (double pointer) |`&mut PathBuf` (double pointer)|


# [Temp dir](https://doc.rust-lang.org/std/env/fn.temp_dir.html)
```rust
let tmp_dir = env::temp_dir();
...
```


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
1. https://docs.rs/tempfile/latest/tempfile/struct.NamedTempFile.html
1. https://doc.rust-lang.org/std/fs/struct.File.html
1. https://doc.rust-lang.org/stable/std/path/struct.Path.html
