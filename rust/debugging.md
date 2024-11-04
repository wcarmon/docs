# Overview
1. Help with debugging rust code


# Clion
- https://www.jetbrains.com/help/clion/debugging-code.html#useful-debugger-shortcuts
- https://blog.jetbrains.com/clion/2019/10/debugging-rust-code-in-clion/
- https://lp.jetbrains.com/debugging-rust-in-clion/
- https://blog.jetbrains.com/rust/2021/10/19/debugging-rust-in-jetbrains-ides-state-of-affairs/


# dbg!
- https://doc.rust-lang.org/std/macro.dbg.html
- https://edgarluque.com/blog/rust-dbg-macro/


# Libraries (External dependencies)
1. Change local source code
1. `cargo clean`
1. build & debug with breakpoints


# Macros
1. [see doc](./macros.md)


# Mutating 3rd party dependencies/libs
1. Add the dependency normally to `Cargo.toml`
1. Open one of the `*.rs` source files in crate
1. Get the full path of the (`Ctrl` + `Shift` + `C`)
    1. eg. `$HOME/.cargo/registry/src/index.crates.io-6f17d22bba15001f/my-dependency-0.1.2`
1. Update `Cargo.toml`, change `version` to `path`
    1. eg.  `opentelemetry-otlp = { path = "/home/myself/.cargo/registry/src/index.crates.io-6f17d22bba15001f/opentelemetry-otlp-0.25.0", features = ["grpc-tonic"] }`
1. Reload project from `Cargo.toml`
1. Update the source code
1. Recompile

## When done ...
1. Undo your changes in `Cargo.toml`
1. `rm -rf $HOME/.cargo/registry/src/index.crates*`
1. Rebuild


# Other Resources
- TODO
