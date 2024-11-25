# Overview

- TODO: https://cheats.rs/#macros-attributes

# Idioms
1. Slow down
1. Write the code by hand first
1. make it compile & make tests pass
1. extract & generalize into the macro
1. use `cargo clean` when you see unexpected behavior


# Gotchas
1. Horrible support in Jetbrains products
1. When derive proc macro fails, compiler doesn't show failing line
    - `-Zmacro-backtrace` does not help
1. Jetbrains Debugger doesn't work inside proc macro code
1. Error messages won't tell you which line in the macro is broken


# Debugging

1. worst case: use `panic!("{:?}", x)` to print things

## Cargo expand (for macros)
1. Expands attributes on structs, fields, etc
1. Works even when code doesn't compile

## Steps
1. [`cargo install cargo-expand`](https://github.com/dtolnay/cargo-expand)
1. put example code in one rs file (eg. `tests/example.rs`)
1. put test module (with assertions) in separate file (eg. `tests/example_tests.rs`)
```bash
cd $DIR_WITH_CARGO_TOML

TEST_RS_FILE_WITHOUT_EXTENSION=my_test
cargo expand --test $TEST_RS_FILE_WITHOUT_EXTENSION --color=always --theme=Dracula --tests
```


## Write by hand
1. Write the code by hand (eg. the `impl`)
1. fix all compiler errors, then bring result back to the macro (and generalize)


# Other Resources
