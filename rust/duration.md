# Overview
1. Using durations
1. See also [datetime](./datetime.md) doc
1. See also [durations](../common/durations.md) doc


# Terms
## `Duration` [(`std::time::Duration`)](https://doc.rust-lang.org/std/time/struct.Duration.html)
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
1. Internally stored as [seconds + nanos](https://doc.rust-lang.org/stable/src/core/time.rs.html#86) (which is elegant :-)
    - [Same as Java](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/time/Duration.html)
    - `Duration.sec` part is `u64`, can represent between `1 sec` and `4 billion centuries`
    - `Duration.nanos` part is `u32`, can represent between `1 nanosecond` and `4.2 seconds`



# Construct
1. Chrono
```rust
let d = TimeDelta::try_weeks(1).context("invalid weeks")?;
let d = TimeDelta::try_days(1).context("invalid days")?;
let d = TimeDelta::try_hours(1).context("invalid hours")?;
...   = TimeDelta::try_minutes(1).context(...)?;
...   = TimeDelta::try_seconds(1).context(...)?;
...   = TimeDelta::try_milliseconds(1).context(...)?;
...   = TimeDelta::try_microseconds(1).context(...)?;
...   = TimeDelta::try_nanoseconds(1).context(...)?;
```
1. `std::time::Duration`: [seconds](https://doc.rust-lang.org/stable/std/time/struct.Duration.html#method.from_secs), [millis](https://doc.rust-lang.org/stable/std/time/struct.Duration.html#method.from_millis), [micros](https://doc.rust-lang.org/stable/std/time/struct.Duration.html#method.from_micros)
```rust
let d = Duration::from_secs(1);
let d = Duration::from_millis(1);
let d = Duration::from_micros(1);
let d = Duration::from_nanos(1);
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
1. chrono `TimeDelta` is easier to use `std::time::Duration`
1. Standard lib might require `#![feature(duration_constructors)]` and `#![feature(duration_abs_diff)]`


# Comparison to Java
|[Rust (chrono)](https://docs.rs/chrono/latest/chrono)|Rust (std)|Java|
|---|---|---|
|[`(ts0 - ts1).abs()`](https://docs.rs/chrono/latest/chrono/struct.TimeDelta.html#method.abs)|[`ts0.duration_since(ts1)?`](TODO) (`Err` when order wrong)|[`Duration.between(ts0, ts1).abs()`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/time/Duration.html#between(java.time.temporal.Temporal,java.time.temporal.Temporal))|
|[`a + b`](https://docs.rs/chrono/latest/chrono/struct.TimeDelta.html#impl-Add-for-TimeDelta) or<br>[`a.checked_add(&b).context("overflow")?`](https://doc.rust-lang.org/nightly/core/time/struct.Duration.html#method.checked_add)|[`a + b`](https://doc.rust-lang.org/std/time/struct.Duration.html#method.checked_add)|[`a.plus(b)`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/time/Duration.html#plus(java.time.Duration))|
|[`a - b`](https://docs.rs/chrono/latest/chrono/struct.TimeDelta.html#impl-Sub-for-TimeDelta) or<br>[`a.checked_sub(&b).context("overflow")`](https://doc.rust-lang.org/nightly/core/time/struct.Duration.html#method.checked_sub)|[`a - b`](https://doc.rust-lang.org/std/time/struct.Duration.html#method.checked_sub)|[`a.minus(b)`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/time/Duration.html#minus(java.time.Duration))|
|[`a == b`](https://docs.rs/chrono/latest/chrono/struct.TimeDelta.html#impl-PartialEq%3CTimeDelta%3E-for-ArchivedTimeDelta)|[`a == b`](https://doc.rust-lang.org/std/time/struct.Duration.html#impl-PartialEq-for-Duration)|[`a.equals(b)`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/time/Duration.html#equals(java.lang.Object))|
|[`d < TimeDelta::zero()`](https://docs.rs/chrono/latest/chrono/struct.TimeDelta.html#impl-Ord-for-TimeDelta)|N/A (never negative)|[`d.isNegative()`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/time/Duration.html#isNegative())|
|[`d > TimeDelta::zero()`](https://docs.rs/chrono/latest/chrono/struct.TimeDelta.html#impl-Ord-for-TimeDelta)|N/A (never negative)|[`d.isPositive()`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/time/Duration.html#isPositive())|
|[`d.abs()`](https://docs.rs/chrono/latest/chrono/struct.TimeDelta.html#method.abs)|N/A (never negative)|[`d.abs()`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/time/Duration.html#abs())|
|[`d.is_zero()`](https://docs.rs/chrono/latest/chrono/struct.TimeDelta.html#method.is_zero)|[`d.is_zero()`](https://doc.rust-lang.org/std/time/struct.Duration.html#method.is_zero)|[`d.isZero()`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/time/Duration.html#isZero())|
|[`d.num_hours()`](https://docs.rs/chrono/latest/chrono/struct.TimeDelta.html#method.num_hours)|[`d.as_secs() / 3600`](https://doc.rust-lang.org/std/time/struct.Duration.html#method.as_secs)|[`d.toHours()`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/time/Duration.html#toHours())|
|[`d.num_milliseconds()`](https://docs.rs/chrono/latest/chrono/struct.TimeDelta.html#method.num_milliseconds)|[`d.as_millis()`](https://doc.rust-lang.org/std/time/struct.Duration.html#method.as_millis)|[`d.toMillis()`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/time/Duration.html#toMillis())|
|[`d.num_minutes()`](https://docs.rs/chrono/latest/chrono/struct.TimeDelta.html#method.num_minutes)|[`d.as_secs()/60`](https://doc.rust-lang.org/std/time/struct.Duration.html#method.as_secs)|[`d.toMinutes()`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/time/Duration.html#toMinutes())|
|[`d.num_seconds()`](https://docs.rs/chrono/latest/chrono/struct.TimeDelta.html#method.num_seconds)|[`d.as_secs()`](https://doc.rust-lang.org/std/time/struct.Duration.html#method.as_secs)|[`d.toSeconds()`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/time/Duration.html#toSeconds())|
|[`TimeDelta::try_hours(n).context("invalid hours")?`](https://docs.rs/chrono/latest/chrono/struct.TimeDelta.html#method.try_hours)|[`Duration::from_hours(n)`](TODO)|[`Duration.ofHours(n)`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/time/Duration.html#ofHours(long))|
|[`TimeDelta::try_milliseconds(n).context("invalid millis")`](https://docs.rs/chrono/latest/chrono/struct.TimeDelta.html#method.try_milliseconds)|[`Duration::from_millis(n)`](https://doc.rust-lang.org/std/time/struct.Duration.html#method.from_millis)|[`Duration.ofMillis(n)`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/time/Duration.html#ofMillis(long))|
|[`TimeDelta::try_minutes(n).context("invalid minutes")?`](https://docs.rs/chrono/latest/chrono/struct.TimeDelta.html#method.try_minutes)|[`Duration::from_secs(60*n)`](https://doc.rust-lang.org/std/time/struct.Duration.html#method.from_secs) or<br>[`Duration::from_secs_f64(...)`](https://doc.rust-lang.org/std/time/struct.Duration.html#method.from_secs_f64)|[`Duration.ofMinutes(n)`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/time/Duration.html#ofMinutes(long))|
|[`TimeDelta::try_seconds(n).context("invalid seconds")`](https://docs.rs/chrono/latest/chrono/struct.TimeDelta.html#method.try_seconds)|[`Duration::from_secs(n)`](https://doc.rust-lang.org/std/time/struct.Duration.html#method.from_secs)|[`Duration.ofSeconds(n)`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/time/Duration.html#ofSeconds(long))|
|(use number instead)|(use number instead)|[`d.toString()`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/time/Duration.html#toString())|
|(use number instead)|(use number instead)|[`Duration.parse(...)`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/time/Duration.html#parse(java.lang.CharSequence))|


# TODO/Unorganized
- `sleep(Duration::new(30, 0));`
- https://rust-lang-nursery.github.io/rust-cookbook/datetime/duration.html#perform-checked-date-and-time-calculations


# Other Resources
1. https://doc.rust-lang.org/std/time/index.html
