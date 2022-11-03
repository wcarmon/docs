# Overview
1. Using durations
1. See also [datetime](./datetime.md) doc


# Terms
## `Duration`
1. Represents hours, minutes, seconds, millis, microseconds and nanoseconds
1. Max value is ~1 Billion Centuries
1. Standard [`Duration`](https://doc.rust-lang.org/stable/std/time/struct.Duration.html)
1. Chrono [`Duration`](https://docs.rs/chrono/latest/chrono/struct.Duration.html)
    1. They might eventually migrate to std
    1. They have more (convenience) methods
    1. Allows negative duration
1. [Golang equivalent](https://pkg.go.dev/time#Duration)
1. [JVM equivalent](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/Duration.html)
1. [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601#Durations)


# [Construct](TODO) (from string)
```rust
TODO
```


# [Parse](TODO) (from string)
```rust
TODO
```


# [Format](TODO) (to string)
```rust
TODO
```


# Timing
```rust
TODO
```


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


#  [`chrono::Duration`](https://docs.rs/chrono/latest/chrono/struct.Duration.html) to/from [`std::time::Duration`](https://doc.rust-lang.org/stable/std/time/struct.Duration.html)
```rust
// to std
let chr_dur = chrono::Duration::seconds(1);
chrono::Duration::to_std(&chr_dur)
    .map_err(anyhow::Error::msg)


// to chrono
let std_d = std::time::Duration::from_secs(1u64);
let chr_dur = chrono::Duration::from_std(std_d)
    .map_err(anyhow::Error::msg)
```
1. [`::to_std()`](https://docs.rs/chrono/latest/chrono/struct.Duration.html#method.to_std), [`::from_std()`](https://docs.rs/chrono/latest/chrono/struct.Duration.html#method.from_std)



# Idioms
1. TODO


# TODO/Unorganized
- `sleep(Duration::new(30, 0));`
- https://rust-lang-nursery.github.io/rust-cookbook/datetime/duration.html#perform-checked-date-and-time-calculations


# Other resources
1. https://doc.rust-lang.org/std/time/index.html
