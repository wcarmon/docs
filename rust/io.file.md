# Overview

1. Important types and traits related to File IO
1. Some patterns for File IO

# Important Types

## [`std::fmt::Write`](https://doc.rust-lang.org/std/fmt/trait.Write.html) Trait
- For text (`String`, `&str`, etc)

- Comparison:
    - Java: [`java.io.Writer`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/io/Writer.html)
    - Golang: [`StringWriter`](https://pkg.go.dev/io#StringWriter)

## [`std::io::Write`](https://doc.rust-lang.org/std/io/trait.Write.html) Trait
- For bytes

- lower level than `std::fmt::Write`
- Two methods: [`write`](https://doc.rust-lang.org/std/io/trait.Write.html#tymethod.write) and [`flush`](https://doc.rust-lang.org/std/io/trait.Write.html#tymethod.flush)
- Comparison:
    - Java: [`java.io.OutputStream`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/io/OutputStream.html)
    - Golang: [`Writer`](https://pkg.go.dev/io#Writer)

### [`std::io::BufWriter`](https://doc.rust-lang.org/std/io/struct.BufWriter.html)

- Comparison:
    - Java: [`java.io.BufferedWriter`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/io/BufferedWriter.html)
    - Golang: [`bufio.Writer`](https://pkg.go.dev/bufio#Writer)

## [`std::fs::File`](https://doc.rust-lang.org/std/fs/struct.File.html) struct

- Implements [`Write`](https://doc.rust-lang.org/std/fs/struct.File.html#impl-Write-for-%26File)
- Comparison:
    - Java: [`java.nio.file.Path`](https://docs.oracle.com/en/java/javase/18/docs/api/java.base/java/nio/file/Path.html) + methods on [`java.nio.file.Files`](https://docs.oracle.com/en/java/javase/18/docs/api/java.base/java/nio/file/Files.html)

## [`std::path::PathBuf`](https://doc.rust-lang.org/stable/std/path/struct.PathBuf.html)

- `Ownership`: Owned
- `Mutability`: Mutable
- GOTCHA: [`.ends_with(...)`](https://doc.rust-lang.org/std/path/struct.Path.html#method.ends_with) doesn't include extension
    - Unexpected behavior compared to Go, Java, Python, ...

## [`std::path::Path`](https://doc.rust-lang.org/stable/std/path/struct.Path.html)

- similar to `&str`
- `Ownership`: Borrowed
- `Mutability`: Immutable
- Comparison:
    - Golang: [`filepath`](https://pkg.go.dev/path/filepath)
    - Java: [`java.nio.file.Files`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/nio/file/Files.html)
- Thin wrapper around [`OsStr`](https://doc.rust-lang.org/std/ffi/struct.OsStr.html)
- GOTCHA: [`.ends_with(...)`](https://doc.rust-lang.org/std/path/struct.Path.html#method.ends_with) doesn't include extension
    - Unexpected behavior compared to Go, Java, Python, ...

|              | Immutable                                                                                    | Mutable                                                                                 |
|--------------|----------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------|
| **Owned**    | `String` <br/>`PathBuf` <br/>                                                                | `String` (`mut` on variable/argument) <br/>`PathBuf` (`mut` on variable/argument) <br/> |
| **Borrowed** | `&str` <br/>`&Path` <br/>~~`&String`~~ (double pointer) <br/>~~`&PathBuf`~~ (double pointer) | `&mut PathBuf` (double pointer)                                                         |

# Patterns

## Read a file

```rust
// -- Simple case
let data: String = fs::read_to_string("foo.txt")?;


// ----------------------------------------------------
// -- More configurable alternative, with buffering
// ----------------------------------------------------
let p = PathBuf::from("/path/to/foo.txt").canonicalize()?;

// p can be String, &str, Path, or PathBuf
let mut f = OpenOptions::new().read(true).open(p)?;
  
let mut br = BufReader::new(f);
let mut data = String::new();
br.read_to_string(&mut data)?;

println!("contents: {data}");
// file & buffer handles auto closed when they go out of scope
```

## Iterate lines of a string

```rust
for line in data.lines() {
    ...
}
```

## Append or Overwrite a file

```rust
use std::fs::OpenOptions;
use std::io::Write;
use std::os::unix::fs::OpenOptionsExt; // for mode/perms
use std::path::PathBuf;
...

let p: PathBuf = "/tmp/path/to/foo.txt".parse()?;

// -- Truncate/overwrite:
let mut f = OpenOptions::new()
        .create(true)
        .truncate(true)
        .write(true) // yes, write is required
        .open(p)?; 

// -- Append: 
let mut f = OpenOptions::new().append(true).open(p)?;

let data = "whatever";
write!(f, "{data}")?; // requires:  use std::io::Write;


// ----------------------------------------------------
// -- More configurable alternative, with buffering
// ----------------------------------------------------
let mut f = OpenOptions::new()
    .create(true)   // replace with .create_new(true) to fail on existing file
    .mode(0o640)    // must import std::os::unix::fs::OpenOptionsExt, only applied if created    
    .open(p)?;      // p can be String, &str, Path, or PathBuf

let mut bw = BufWriter::new(&mut f);
bw.write_all(data.as_bytes())?; // or just pass any &[u8]

// Automatically flushes on drop,
// but better manual flush helps catch errors
bw.flush()?; 
```

## Create [Temp dir](https://doc.rust-lang.org/std/env/fn.temp_dir.html)
- See [tempfile crate](https://docs.rs/tempfile/latest/tempfile/struct.TempDir.html)
- In `Cargo.toml`:
```toml
[dependencies]
tempfile = "3"
```
- Managed directory:
```rust
let managed_dir = TempDir::with_prefix("whatever")?.into_path();

// -- all files auto deleted on drop(managed_dir)
```
- Unmanaged directory:
```rust

// -- You own the dir, nothing deleted on drop(...)
let unmanaged_dir = TempDir::with_prefix("whatever")?.into_path();
let foo = unmanaged_dir.join(...);

// -- Cleanup later
// fs::remove_dir_all(unmanaged_dir)?;

// -- Below is not as helpful as tempdir crate
// let tmp_dir_from_env_var: PathBuf = env::temp_dir();
// tmp_dir_from_env_var.join(...)
...
```

## Create [Temp file](https://docs.rs/tempfile/latest/tempfile/)
- In `Cargo.toml`
```toml
tempfile = "3"
```
- Code:
```rust
use tempfile::NamedTempFile;
...

let mut file = NamedTempFile::new()
    .context("failed to create temp file")?;

file.write_all("...".as_bytes())?;
// file.flush()?;

// -- NOTE: file is auto-deleted when it goes out of scope
```

## Set file permissions

```rust
//TODO: https://doc.rust-lang.org/std/fs/fn.set_permissions.html
```

## Check if file exists

```rust
//TODO: https://doc.rust-lang.org/std/fs/fn.try_exists.html
//TODO: https://doc.rust-lang.org/std/path/struct.Path.html#method.exists
``` 

## Check file type

```rust
//TODO: https://doc.rust-lang.org/std/fs/struct.Metadata.html#method.is_dir
//TODO: https://doc.rust-lang.org/std/path/struct.Path.html#method.is_dir

//TODO: https://doc.rust-lang.org/std/fs/struct.Metadata.html#method.is_file
```

## Get file size

```rust
//TODO: https://doc.rust-lang.org/std/fs/struct.Metadata.html#method.len
```

## List files in a directory
1. See also [walkdir crate](https://docs.rs/walkdir/latest/walkdir/)
```rust
let dir: &Path = ... ;

for dir_entry in fs::read_dir(dir)? {
    let entry = dir_entry?;
    let path = entry.path();

    if path.is_dir() {
        info!("found a dir: {:?}", path)
        continue;
    }

    if path.is_file() {
        info!("found a file: {:?}", path)
        continue;
    }

    // ... use it here
}
```


# Gotcha

- `canonicalize` fails if path doesn't already exist

# Other Resources

1. https://rust-lang-nursery.github.io/rust-cookbook/file.html
1. https://rust-lang-nursery.github.io/rust-cookbook/
1. https://docs.rs/tempfile/latest/tempfile/struct.NamedTempFile.html
1. https://doc.rust-lang.org/std/fs/struct.File.html
1. https://doc.rust-lang.org/stable/std/path/struct.Path.html
1. https://doc.rust-lang.org/std/fs/struct.OpenOptions.html
