# Overview
1. Using dates, times, zones
1. See [durations & periods](./duration.md) doc
1. Using [chrono](https://docs.rs/chrono/latest/chrono/) lib


# Construct
```rust
TODO
```


# [Current Time](https://doc.rust-lang.org/std/time/struct.Instant.html#method.now)
```rust
let now = Instant::now();
```


# Format (to string)
1. To standard [rfc3339](https://datatracker.ietf.org/doc/html/rfc3339)
1. [syntax](https://docs.rs/chrono/latest/chrono/format/strftime/index.html#specifiers)
```rust
TODO
```
1. To other formats
```rust
TODO
```
1. [Official doc](TODO)


# Parse (from string)
1. From standard [rfc3339](https://datatracker.ietf.org/doc/html/rfc3339)
```rust
TODO
```
1. [Official doc](TODO)



# Inject a clock
```rust
fn do_something(clock: fn() -> Instant) {
    let now = clock();
    ...
}
```


# Equality & Comparison
```rust
TODO
```


# Before & After
```rust
TODO
```


# Add/Subtract Durations/Periods
- See [duration](./duration.md) doc


# Parts of year
```rust
TODO
```


# Timezones
```rust
TODO
```


# Months
TODO


# Timing operations
1. See [Duration](./duration.md) doc


# Sleep
1. See [Duration](./duration.md) doc


# Run periodically
```rust
TODO
```


# Interop
## Java/JVM
TODO


## Golang
TODO



# TODO/Unorganized
- TODO: https://docs.rs/chrono/0.4.0/chrono/struct.DateTime.html
- TODO: https://rust-lang-nursery.github.io/rust-cookbook/datetime.html


# Other resources
1. TODO
