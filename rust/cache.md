# Overview
1. Evaluation of popular caching libs


# Moka
1. `Con`: less popular than `cached`
1. `Pro`: actively developed
1. `Pro`: async support (separate crate feature)
1. `Pro`: Bounded (entry count, size)
1. `Pro`: expiration policies
1. `Pro`: Feels like a Map
1. `Pro`: Good docs & examples
1. `Pro`: Lifecycle listener support
1. `Pro`: Lock-free concurrent iteration
1. `Pro`: LRU support
1. `Pro`: popular enough
1. `Pro`: Simple
1. `Pro`: somewhat inspired by [Caffeine](https://github.com/ben-manes/caffeine)
1. `Pro`: Threadsafe
1. `Pro`: TTL


# Cached
1. `Con`: [App code in macros is a bit magical & frameworky (no static analysis, no fmt, etc.)](https://github.com/jaemk/cached/blob/master/examples/kitchen_sink.rs)
1. `Con`: Complex (learning curve)
1. `Con`: Very macro focused
1. `Pro`: Actively developed
1. `Pro`: async (tokio) support
1. `Pro`: Lots of examples
1. `Pro`: macros for memoization
1. `Pro`: More popular than Moka
1. `Pro`: Well organized crates & features


# ~~quickcache~~
1. `Con`: No lifecycle listener support
1. `Con`: No TTL support
1. `Con`: Not as popular as Moka
1. `Con`: Not as well documented as Moka
1. `Pro`: Simple


# Other Resources
