# Overview
- TODO: https://vino.dev/blog/node-to-rust-day-11-module-system/

# Package
1. TODO


# Crate
1. A compilation unit
1. either an executable or a library
1. TODO


## Crate root
1. *Crate root* is the starting file for compiler (rustc)
1. *Crate root* is the starting file for imported modules
1. `src/lib.rs` (for library)
1. `src/main.rs` (for binary)
1. like [`cmd/foo/main.go`](https://github.com/golang-standards/project-layout#cmd) for go
1. like a [main class](https://docs.oracle.com/javase/tutorial/getStarted/application/index.html) for java (or whatever you set in `build.gradle.kts`)
1. like [`index.js`](https://docs.npmjs.com/cli/v8/configuring-npm/package-json#main) for node (or whatever you set in your [`package.json`](https://docs.npmjs.com/cli/v8/configuring-npm/package-json#main))


# Module
1. `mod` is the closest thing rust has to `import` (golang, java, node, ts, dart, )
1. If you declare a module, Rust uses "a resolution algorithm" to find it
1. One file can have multiple modules, flat or nested
1. A module can be split across multiple files <-- TODO: how
1. Module defines visibility barrier (public, private, etc)
1. Comparison
    1. Node: no packages, only files (import files)
    1. Go: one package per directory, one directory per package, names can differ (import packages)
    1. Java: package structure matches (a subtree of) directory structure, names match, import classes
1. `use` has nothing to do with importing
1. Don't use ~~`mod.rs`~~ (legacy, tech debt)
1. it helps to define a directory AND file for a module (`foo/*.rs` and `foo.rs`)
1. `mod foo;`: import/expand (copy/paste) the contents of `foo.rs` into the current file
1. `mod foo { ... }`: put `...` into module named foo


## Example
1. Given a file at `src/a/b.rs`
```rust
mod c;  // <-- looks for a file named c.rs

// everything defined here is accessible as crate::?
```
1. in ?/?/`c.rs`
```rust
```
1. Use `mod` to declare a module

|Module Path|filesystem path|contents|
|---|---|---|
|`crate`|`lib.rs` or `main.rs`|`mod a;`|
|`crate::a`|`src/a.rs`|`mod b;`|
|`crate::a::b`|`src/a/b.rs`|???|
|`crate::a::b::c`|`src/a/b/c.rs`|?|




# Namespace
1. `use` has nothing to do with importing (see `mod`)
1. `use` maps fully qualified namespace to a shorter identifier
1. `use x::y::Z`: bring `Z` into the current namespace, so I can reference as `y::Z`
1. `use` allow referencing items without fully qualifying


# Other resources
1. https://doc.rust-lang.org/reference/items/modules.html#module-source-filenames
1. https://stevedonovan.github.io/rust-gentle-intro/4-modules.html
1. https://web.mit.edu/rust-lang_v1.25/arch/amd64_ubuntu1404/share/doc/rust/html/book/first-edition/crates-and-modules.html
1. https://betterprogramming.pub/explaining-rusts-modules-420d38eed6c5
1. https://medium.com/codex/rust-modules-and-project-structure-832404a33e2e