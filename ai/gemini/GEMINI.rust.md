# Common

1. In general Follow the patterns of other files in the same directory
1. Priorities: Correctness first, then clarity, then performance, then conciseness
1. Prefer simple solutions over complex solutions
1. Follow idioms suggested by clippy and the rustc compiler
    1. Avoid most warnings
1. avoid panic, use proper error handling with anyhow (usually) or thiserror (published libraries)
1. Minimize nesting


# Testing

1. Use // -- Arrange, // -- Act, // -- Assert (or Act and Assert) comments to separate sections
1. Use assert2 crate
