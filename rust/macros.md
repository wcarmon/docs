# Overview

- TODO: https://cheats.rs/#macros-attributes

# Gotchas
1. Horrible support in Jetbrains products
1. When derive proc macro fails, compiler doesn't show failing line
    - `-Zmacro-backtrace` does not help
1. Jetbrains Debugger doesn't work inside proc macro code


# Debugging

## Cargo expand (for macros)
1. Expands attributes on structs, fields, etc
1. [`cargo install cargo-expand`](https://github.com/dtolnay/cargo-expand)


## Write by hand
1. Write the code by hand (eg. the `impl`)
1. fix all compiler errors, then bring result back to the macro (and generalize)


# Other Resources
