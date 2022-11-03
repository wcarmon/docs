# Overview
1. Using durations
1. See also [datetime](./datetime.md) doc


# Terms
## `Duration`
1. Represents hours, minutes, seconds, millis, microseconds and nanoseconds
1. Max value is ~2,924,712,000 Centuries
1. Standard [`Duration`](https://doc.rust-lang.org/stable/std/time/struct.Duration.html)
1. Chrono [`Duration`](https://docs.rs/chrono/latest/chrono/struct.Duration.html)
    1. They might eventually migrate to std
    1. They have more (convenience) methods
1. [Golang equivalent](https://pkg.go.dev/time#Duration)
1. [JVM equivalent](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/Duration.html)
1. [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601#Durations)


# [Parse](TODO) (from string)
```rust

```

# [Format](TODO) (to string)


# Timing operations


# [Sleep](https://doc.rust-lang.org/stable/std/thread/fn.sleep.html)
1. There's usually a better way structure code than sleep (see [Rayon](https://docs.rs/rayon/latest/rayon/), See [Crossbeam](https://docs.rs/crossbeam/latest/crossbeam/), See [tokio](https://docs.rs/tokio/latest/tokio/time/fn.sleep.html))
```rust
let d = Duration::from_secs(1);

// blocking
thread::sleep(d);
```


# Add/Sub
```rust
TODO
```


# [Round](TODO)
1. TODO: more here


# [Truncate](TODO)


# Idioms
1. TODO


# TODO/Unorganized
- `sleep(Duration::new(30, 0));`
- https://rust-lang-nursery.github.io/rust-cookbook/datetime/duration.html#perform-checked-date-and-time-calculations


# Other resources
1. https://doc.rust-lang.org/std/time/index.html
