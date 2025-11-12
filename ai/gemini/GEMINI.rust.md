# General

1. In general Follow the patterns of other files in the same directory
1. Priorities: Correctness first, then clarity, then performance, then conciseness
1. Prefer simple solutions over complex solutions
1. Avoid panic!, use proper error handling with anyhow (usually) or thiserror (published libraries)
1. Avoid unsafe unless you need to mutate env variables in a test.
1. Minimize nesting
1. Assume we are always using the latest 2 versions of rust, no need to support anything older.
1. After completing a everything, review and verify you followed all the instructions.


# Static analysis

1. You are always free to run cargo clippy and the compiler.  Use the warnings and errors to improve the code
1. Most crates have a clippy.sh file preconfigured with clippy settings.  Execute whenever it is helpful.
1. Follow idioms suggested by clippy and the rustc compiler
    1. Avoid most warnings


# Testing

1. Use // -- Arrange, // -- Act, // -- Assert (or Act and Assert) comments to separate sections
1. Use assert2 crate
