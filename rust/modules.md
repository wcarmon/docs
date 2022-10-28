# Overview
- TODO: https://vino.dev/blog/node-to-rust-day-11-module-system/

# Package
1. TODO


# Crate
1. TODO


## Crate root
1. *Crate root* is the starting file for compiler (rustc)
1. *Crate root* is the starting file for imported modules
1. `src/lib.rs` (for library)
1. `src/main.rs` (for binary)
1. like `cmd/foo/main.go` for go
1. like a main class for java (or whatever you set in `build.gradle.kts`)
1. like `index.js` for node (or whatever you set in your `package.json`)


# Module
1. If you declare a module, Rust uses "a resolution algorithm" to find it
1. Use `mod` to declare a module
    1. `mod foo;`: import/expand (copy/paste) the contents of `foo.rs` into the current file
    1. `mod foo { ... }`: put `...` into module named foo
1. One file can have multiple modules, flat or nested
1. A module can be split across multiple files <-- TODO: how
1. Module defines visibility barrier (public, private, etc)
1. Comparison
    1. Unlike Node, You don't import files
    1. Unlike Go, You don't import packages
    1. Unlike Java, You don't import classes
1. Don't use ~~`mod.rs`~~ (legacy, tech debt)


# Namespace
1. `use x::y::Z`: bring `Z` into the current namespace, so I can reference as `y::Z`
1. `use` allow referencing items without fully qualifying


# Other resources
1. TODO
