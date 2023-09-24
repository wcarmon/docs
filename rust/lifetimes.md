# Overview

1. What are Lifetimes?
1. Why are Lifetimes useful?
1. When do we need them?

# Scope/Applicibility

1. Only applies to references
1. Not required for Owned types (eg. [String](https://doc.rust-lang.org/std/string/struct.String.html), [PathBuf](https://doc.rust-lang.org/stable/std/path/struct.PathBuf.html))
1. Not required for smart pointers (because the variables which reference them have a lifetime)

# Popular Lifetimes

- `static`: guaranteed valid for duration of entire program


- TODO: struct properties
- TODO: fn args & return types

# Other Resources

1. TODO
