# Overview

- TODO: https://cheats.rs/#macros-attributes

# Idioms
1. Slow down :-)
1. Write the code by hand first (in a regular *.rs file)
1. make it compile & make tests pass
    1. compiler error messages are helpful and point to correct lines
1. extract & generalize code block into the macro
1. use `cargo clean` when you see unexpected behavior
1. use `cargo expand <module>` to bring broken code back into regular rs file
    1. ... so the compiler can help you


# Gotchas
1. Horrible support in JetBrains products
1. When derive proc macro fails, compiler doesn't show failing line
    - `-Zmacro-backtrace` does NOT help
1. JetBrains Debugger doesn't work inside proc macro code
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
