# Overview

1. What are Lifetimes?
1. Why are Lifetimes useful?
1. When do we need them?

# What are they?

1. Lifetimes are a performance & safety optimization
1. without lifetime, we have to ...
    1. Copy: which is safe, but slower
    2. Ignore: which is fast, but unsafe
    3. Manually choose from the options above at every point and manually reason about safety and performance


# Scope/Applicibility

1. Only applies to references (borrowing)
1. Not required for Owned types (eg. [String](https://doc.rust-lang.org/std/string/struct.String.html), [PathBuf](https://doc.rust-lang.org/stable/std/path/struct.PathBuf.html))
1. Not required for smart pointers (because the variables which reference them have a lifetime)
1. Useful for sharing immutable data (avoiding unnecessary allocations)
    1. This is huge for performance
    1. This avoids unnecessary deallocation (`free`) too
    1. This reduces memory corruption
1. Only need to specify lifetimes on ...
    1. structs with borrowed fields
    1. functions with borrowed **return** types
1. Most of the time compiler can automatically determine lifetimes


# Popular Lifetimes

- `static`: guaranteed valid for duration of entire program (eg. global lifetime)

# Structs
1. borrowed struct fields must outlive the struct
2. only need to define on the struct and field, not at the usage points
3. lifetimes define the contract enforced by the compiler 


# Functions
1. borrowed fn args may need to outlive return type?
2. multiple borrowed args may need the same or different lifetime
3. lifetimes define the contract enforced by the compiler 


# Other Resources

1. TODO
