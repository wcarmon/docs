# Overview

1. Packages, Crates, Modules, `use`, `mod`, ...
1. See [abstraction doc](./abstraction.md)
1. See [modeling doc](./modeling.md)

# Summary

- Workspace > Package > Crate > File > Module > sub-module

# Workspace

1. one or more [Packages](TODO) which share [`Cargo.lock`](TODO) and output directory
1. has a `Cargo.toml` at the root, containing `[workspace]`

# Package

1. one or more [*Crates*](./modules.md#crate)
1. Contains one `Cargo.toml` at the root, containing `[package]`

# Crate

1. A compilation unit
1. Either an executable or a library (not both)
    1. A *Package* can have multiple binary *crates*

## Crate root

1. *Crate root* is the starting **file** for compiler ([rustc](https://doc.rust-lang.org/rustc/what-is-rustc.html))
1. *Crate root* is the starting **file** for imported modules
1. `src/lib.rs` (for library, non-executable)
1. `src/main.rs` (for binary)
1. Language Comparison:
    1. *Go*: like [`cmd/foo/main.go`](https://github.com/golang-standards/project-layout#cmd)
    1. *Java*: like a [main class](https://docs.oracle.com/javase/tutorial/getStarted/application/index.html) (or whatever you set in `build.gradle.kts`)
    1. *Node*: like [`index.js`](https://docs.npmjs.com/cli/v8/configuring-npm/package-json#main) (or whatever you set in your [`package.json`](https://docs.npmjs.com/cli/v8/configuring-npm/package-json#main))

# Module

1. Every file is a module
1. Modules can have sub-modules
    - ... but not sub-sub modules, no grandchild modules
    - `mod child` must appear in `main.rs`  (or `lib.rs`)
    - `mod grandchild` must appear in child.rs
1. One file can have multiple modules, flat or nested
1. See a complex but working example: [example.modules](./example.modules)
1. [`mod`](https://doc.rust-lang.org/std/keyword.mod.html) is the closest thing rust has to `import` (golang, java, node, ts, dart, etc)
    1. `mod` declares a sub-module
1. If you declare a sub-module (using [`mod`](https://doc.rust-lang.org/std/keyword.mod.html)), Rust uses "a resolution algorithm" to find it
1. A Module CANNOT cross a file boundary
    1. You can re-export things from other modules (`pub use crate::...`)
1. Module defines visibility barrier (**pub**lic, private, etc)
1. Language Comparison
    1. *Node*: [no packages, only files, import files](https://nodejs.org/api/packages.html#imports)
    1. *Go*: [one package per directory, one directory per package, names can differ, import packages](https://go.dev/ref/spec#Packages)
    1. *Java*: package structure matches (a subtree of) directory structure, names match, import classes
1. `mod foo;`: means import/expand (copy/paste) the contents of `foo.rs` into the current file
    1. Rust automatically creates a module namespace as `foo` (matches the file name)
    1. It also means "a sub-module exists at, called foo
1. `mod foo { ... }`: means put `...` into module named foo
1. [`use`](https://doc.rust-lang.org/reference/items/use-declarations.html) has **nothing** to do with importing
1. Do **not** use ~~`mod.rs`~~ [(legacy approach from pre-1.30)](https://doc.rust-lang.org/reference/items/modules.html#module-source-filenames)
    - `/foo/mod.rs` is the legacy alternative to having both `foo.rs` and `foo/`

## Sub-modules

1. For a sub-module, create a directory **AND** matching file for the module
    1. eg. `foo/*.rs` and `foo.rs`
    1. The names **MUST** match
    1. JetBrains [Rust plugin](https://www.jetbrains.com/rust/) enforces this
    1. `foo.rs` defines the public interface for your (sub) module
1. parent/super modules can only access `pub` members & modules on sub-module types
1. sub-module can access private members of parent/super modules
1. Use `#[path = "path/to/file.rs"]` to get behavior like nodejs
    1. Use sparingly since you're fighting the ecosystem

## Module: Relation to file system

| Module Path | filesystem path       | contents                           |
|-------------|-----------------------|------------------------------------|
| `crate`     | `lib.rs` or `main.rs` | `mod a;` <br/>(meaning `src/a.rs`) |
| `crate::a`  | `src/a.rs`            | `mod b;`                           |

# Namespace

1. [`use`](https://doc.rust-lang.org/reference/items/use-declarations.html) allows referencing items without fully qualifying
1. [`use`](https://doc.rust-lang.org/reference/items/use-declarations.html) has **nothing** to do with importing (see `mod`)
1. [`use`](https://doc.rust-lang.org/reference/items/use-declarations.html) maps fully qualified namespace to a shorter identifier
1. `use w::x::y::Z` means: bring `Z` into the current namespace, so I can reference as `y::Z`

# Visibility/Encapsulation

1. Use `pub` or [`pub(crate)`](https://doc.rust-lang.org/reference/visibility-and-privacy.html#pubin-path-pubcrate-pubsuper-and-pubself) on an `enum`, a `struct`, fields, ...
1. Separate code into different [modules](./modules.md)
    1. See [abstraction doc](./abstraction.md)
    1. See [Visibility summary](https://aloso.github.io/2021/03/28/module-system.html#visibilities-overview)

| Syntax       | Meaning                                          |
|--------------|--------------------------------------------------|
| `pub`        | visible everywhere                               |
| `pub(crate)` | visible in current crate                         |
| `pub(super)` | visible in parent module                         |
| `pub(self)`  | private, visible within module (this is default) |


# Other Resources

1. https://www.sheshbabu.com/posts/rust-module-system/
1. https://doc.rust-lang.org/rust-by-example/mod.html
1. https://doc.rust-lang.org/reference/items/modules.html#module-source-filenames
1. https://stevedonovan.github.io/rust-gentle-intro/4-modules.html
1. https://web.mit.edu/rust-lang_v1.25/arch/amd64_ubuntu1404/share/doc/rust/html/book/first-edition/crates-and-modules.html
1. https://betterprogramming.pub/explaining-rusts-modules-420d38eed6c5
1. https://medium.com/codex/rust-modules-and-project-structure-832404a33e2e
1. https://vino.dev/blog/node-to-rust-day-11-module-system/
