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
1. Internally stored as [seconds + nanos](https://doc.rust-lang.org/stable/src/core/time.rs.html#86)
    - Same as Java


# Construct
1. Chrono: [hours](https://docs.rs/chrono/latest/chrono/struct.Duration.html#method.hours), [minutes](https://docs.rs/chrono/latest/chrono/struct.Duration.html#method.minutes), [seconds](https://docs.rs/chrono/latest/chrono/struct.Duration.html#method.seconds), [millis](https://docs.rs/chrono/latest/chrono/struct.Duration.html#method.milliseconds), [micros](https://docs.rs/chrono/latest/chrono/struct.Duration.html#method.microseconds)
```rust
// TODO: Use try_...()
let d = chrono::Duration::weeks(1);
let d = chrono::Duration::days(1);
let d = chrono::Duration::hours(1);
let d = chrono::Duration::minutes(1);
let d = chrono::Duration::seconds(1);
let d = chrono::Duration::milliseconds(1);
let d = chrono::Duration::microseconds(1);
let d = chrono::Duration::nanoseconds(1);
```
1. Standard: [seconds](https://doc.rust-lang.org/stable/std/time/struct.Duration.html#method.from_secs), [millis](https://doc.rust-lang.org/stable/std/time/struct.Duration.html#method.from_millis), [micros](https://doc.rust-lang.org/stable/std/time/struct.Duration.html#method.from_micros)
```rust
let d = std::time::Duration::from_secs(1);
let d = std::time::Duration::from_millis(1);
let d = std::time::Duration::from_micros(1);
let d = std::time::Duration::from_nanos(1);
```


# [Parse](TODO) (from string)
```rust
TODO
```


# [Format](TODO) (to string)
```rust
TODO
```


# Measure Time
1. [Chrono](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#impl-Sub%3CDateTime%3CTz%3E%3E-for-DateTime%3CTz%3E)
```rust
let start = Utc::now();
do_something();
let dur = Utc::now() - start;

// see also chrono::Duration::span
```
1. [Standard](https://doc.rust-lang.org/stable/std/time/struct.Instant.html#impl-Sub%3CInstant%3E-for-Instant)
```rust
let start = Instant::now();
do_something();
let dur = Instant::now() - start;
```


# [Sleep](https://doc.rust-lang.org/stable/std/thread/fn.sleep.html)
1. There's usually a better way structure code than sleep (see [Rayon](https://docs.rs/rayon/latest/rayon/), See [Crossbeam](https://docs.rs/crossbeam/latest/crossbeam/), See [tokio](https://docs.rs/tokio/latest/tokio/time/fn.sleep.html))
1. Standard
```rust
let d0 = std::time::Duration::from_secs(1);

// blocking
thread::sleep(d);
```


# Add/Sub
1. Chrono
```rust
TODO
```
1. Standard
```rust
TODO
```


# [Round](TODO)
1. Chrono
```rust
TODO
```
1. Standard
```rust
TODO
```


# [Truncate](TODO)
1. Chrono
```rust
TODO
```
1. Standard
```rust
TODO
```


#  [`chrono::Duration`](https://docs.rs/chrono/latest/chrono/struct.Duration.html) to/from [`std::time::Duration`](https://doc.rust-lang.org/stable/std/time/struct.Duration.html)
```rust
// to std
let chr_dur = chrono::Duration::seconds(1);
let std_d = chrono::Duration::to_std(&chr_dur)
    .map_err(anyhow::Error::msg)


// to chrono
let std_d = std::time::Duration::from_secs(1u64);
let chr_dur = chrono::Duration::from_std(std_d)
    .map_err(anyhow::Error::msg)
```
1. [`::to_std()`](https://docs.rs/chrono/latest/chrono/struct.Duration.html#method.to_std), [`::from_std()`](https://docs.rs/chrono/latest/chrono/struct.Duration.html#method.from_std)


# Idioms
1. standard lib might require `#![feature(duration_constructors)]`


# Comparison to Java
|Rust (std)|[Rust (chrono)](https://docs.rs/chrono/latest/chrono/)|Java|
|---|---|---|
|[`.as_secs() / 3600`](TODO)|[`d.num_hours()`](TODO)|[`d.toHours()`](TODO)|
|[`a + b`](TODO)|[`a + b`](TODO)<br>[`a.checked_add(&b).context("overflow")?`](TODO)|[`a.plus(b)`](TODO)|
|[`a - b`](TODO)|[`a - b`](TODO)<br>[`a.checked_sub(&b).context("overflow")`](TODO)|[`a.minus(b)`](TODO)|
|[`a == b`](TODO)|[`a == b`](TODO)|[`a.equals(b)`](TODO)|
|[`d.as_millis()`](TODO)|[`d.num_milliseconds()`](TODO)|[`d.toMillis()`](TODO)|
|[`d.as_secs()/60`](TODO)|[`d.num_minutes()`](TODO)|[`d.toMinutes()`](TODO)|
|[`d.as_secs()`](TODO)|[`d.num_seconds()`](TODO)|[`d.toSeconds()`](TODO)|
|[`d.is_zero()`](TODO)|[`d.is_zero()`](TODO)|[`.isZero()`](TODO)|
|[`Duration::from_hours(n)`](TODO)|[`TimeDelta::try_hours(n).context("invalid hours")?`](TODO)|[`Duration.ofHours(n)`](TODO)|
|[`Duration::from_millis(n)`](TODO)|[`TimeDelta::try_milliseconds(n).context("invalid millis")`](TODO)|[`Duration.ofMillis(n)`](TODO)|
|[`Duration::from_secs(60*n)`](TODO)|[`TimeDelta::try_minutes(n).context("invalid minutes")?`](TODO)|[`Duration.ofMinutes(n)`](TODO)|
|[`Duration::from_secs(n)`](TODO)|[`TimeDelta::try_seconds(n).context("invalid seconds")`](TODO)|[`Duration.ofSeconds(n)`](TODO)|


- TODO: test from here down
|[`abs_diff(...)`](TODO)|[`(a-b).abs()`](TODO)|[`between(a, b)`](TODO)|
|N/A (never negative)|[`d < Duration::zero()`](TODO)|[`.isNegative()`](TODO)|
|N/A (never negative)|[`d > Duration::zero()`](TODO)|[`.isPositive()`](TODO)|
|N/A (never negative)|[`d.abs()`](TODO)|[`d.abs()`](TODO)|
|(use number instead)|(use number instead)|[`d.toString()`](TODO)|
|(use number instead)|(use number instead)|[`Duration.parse(...)`](TODO)|

- TODO: test all
- TODO: link all


# TODO/Unorganized
- `sleep(Duration::new(30, 0));`
- https://rust-lang-nursery.github.io/rust-cookbook/datetime/duration.html#perform-checked-date-and-time-calculations


# Other Resources
1. https://doc.rust-lang.org/std/time/index.html
