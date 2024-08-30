# Overview
1. Using durations
1. See also [datetime](./datetime.md) doc
1. See also [durations](../common/durations.md) doc


# `Duration`: a span of time
1. Can represent hours, minutes, seconds, millis, microseconds and nanoseconds
    1. Max representable value is ~1 Billion Centuries
    1. Not as useful for days, weeks, months, years since they vary in length
1. Standard library: [`std::time::Duration`](https://doc.rust-lang.org/stable/std/time/struct.Duration.html)
    1. Internally stored as [`secs: u64, sub_second_nanos: u32`](https://doc.rust-lang.org/stable/src/core/time.rs.html#86)
    1. Must be non-negative (unlike chrono)
1. chrono crate: [`TimeDelta`](https://docs.rs/chrono/latest/chrono/struct.TimeDelta.html)
    1. chrono has more convenience methods
    1. Allows negative duration (unlike std)
    1. [`Duration`](https://docs.rs/chrono/latest/chrono/struct.Duration.html) is an [alias for `TimeDelta`](https://docs.rs/chrono/latest/chrono/type.Duration.html)
    1. Internally stored as [`secs: i64, sub_second_nanos: u32`](https://docs.rs/chrono/latest/src/chrono/time_delta.rs.html#60-63)
1. Golang equivalent: [`time.Duration`](https://pkg.go.dev/time#Duration)
    1. [roughly equivalent](https://github.com/wcarmon/docs/blob/main/golang/duration.md), but a golang uses a narrower type, so less expressive
1. JVM equivalent: [`java.time.Duration`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/time/Duration.html)
    1. Internally stored as [seconds + nanos](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/time/Duration.html)
        - `Duration.sec` part is `u64`, and can represent between `1 sec` and `4 billion centuries`
        - `Duration.nanos` part is `u32`, and can represent between `1 nanosecond` and `4.2 seconds`
1. See [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601#Durations)


# Create/Construct/Build
1. `chrono::TimeDelta`
```rust
// -- On invalid input, panic
let d = TimeDelta::hours(1);
let d = TimeDelta::minutes(60);
let d = TimeDelta::seconds(3_600);
let d = TimeDelta::milliseconds(3_600_000);

// -- On invalid input, Option::None (no panic)
let d = TimeDelta::try_weeks(1).context("invalid weeks")?;
let d = TimeDelta::try_days(1).context("invalid days")?;

let d = TimeDelta::try_hours(1).context("invalid hours")?;
...   = TimeDelta::try_minutes(1).context(...)?;
...   = TimeDelta::try_seconds(1).context(...)?;
...   = TimeDelta::try_milliseconds(1).context(...)?;
...   = TimeDelta::try_microseconds(1).context(...)?;
...   = TimeDelta::try_nanoseconds(1).context(...)?;
```
1. `std::time::Duration`: [from seconds](https://doc.rust-lang.org/stable/std/time/struct.Duration.html#method.from_secs), [from millis](https://doc.rust-lang.org/stable/std/time/struct.Duration.html#method.from_millis), [from micros](https://doc.rust-lang.org/stable/std/time/struct.Duration.html#method.from_micros)
```rust
#![feature(duration_constructors)]   // enables the functions below

...

let d = std::time::Duration::from_hours(1);
...   = std::time::Duration::from_mins(60);
...   = std::time::Duration::from_secs(3_600);

let d = std::time::Duration::from_millis(3_600_000);
...   = std::time::Duration::from_micros(3_600_000_000);
...
```


# Read to primitive type
1. `chrono::TimeDelta`
```rust
    let d = chrono::TimeDelta::hours(1);
    assert_eq!(d.num_hours(), 1);
    assert_eq!(d.num_minutes(), 60);
    assert_eq!(d.num_seconds(), 3_600);
    assert_eq!(d.num_milliseconds(), 3_600_000);
```
1. `std::time::Duration`
```rust
    let d = std::time::Duration::from_hours(2);

    assert_eq!(d.as_secs() / 3600, 2); // hours (awkward)
    assert_eq!(d.as_secs() / 60, 120); // minutes (awkward)
    assert_eq!(d.as_secs(), 7_200);
    assert_eq!(d.as_millis(), 7_200_000);
```


# Measure Time (Diff two timestamps)
1. [chrono](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#impl-Sub%3CDateTime%3CTz%3E%3E-for-DateTime%3CTz%3E)
```rust
let start = chrono::Utc::now();
do_something();
let dur = chrono::Utc::now() - start;

// see also chrono::Duration::span
```
1. [`std::time`](https://doc.rust-lang.org/stable/std/time/struct.Instant.html#impl-Sub%3CInstant%3E-for-Instant)
```rust
let start = std::time::Instant::now();
do_something();
let dur = std::time::Instant::now() - start;
```


# Add/Subtract Durations
1. chrono
```rust
    let d = TimeDelta::hours(1) + TimeDelta::minutes(30);
    assert_eq!(d.num_minutes(), 90);

    let d = TimeDelta::hours(1) - TimeDelta::minutes(30);
    assert_eq!(d.num_minutes(), 30);
```
1. `std::time`
```rust
    use std::time::Duration;

    let d = Duration::from_hours(1) + Duration::from_mins(15);
    assert_eq!(d.as_secs(), 4_500);
    assert_eq!(d.as_secs() / 60, 75); // minutes (awkward)

    let d = Duration::from_hours(1) - Duration::from_mins(15);
    assert_eq!(d.as_secs(), 2700);
    assert_eq!(d.as_secs() / 60, 45);
```


# Add Duration to Timestamps (or Subtract from)
1. chrono
```rust
let ts: DateTime<Utc> = Utc::now() + TimeDelta::minutes(10);
println!("{:?}", ts);
...
```
1. `std::time`
```rust
use std::time::Duration;
use std::time::SystemTime;
...

let ts: SystemTime = SystemTime::now() + Duration::from_mins(10);
// GOTCHA: printing is remarkably difficult!
```


# Round/Truncate
1. chrono
```rust
    let d = TimeDelta::milliseconds(123_456_789);

    assert_eq!(d.num_days(), 1);
    assert_eq!(d.num_hours(), 34);
    assert_eq!(d.num_minutes(), 2_057);
    assert_eq!(d.num_seconds(), 123_456);
    assert_eq!(d.num_milliseconds(), 123_456_789);
```
1. `std::time`
```rust
    let d = Duration::from_millis(123_456_789);

    assert_eq!(d.as_secs() / 60, 2_057); // minutes (awkward)
    assert_eq!(d.as_secs(), 123_456);
    assert_eq!(d.as_millis(), 123_456_789);
```


# Comparing
1. chrono
```rust
assert!(TimeDelta::minutes(99) > TimeDelta::minutes(1));
```
1. `std::time`
```rust
assert!(Duration::from_mins(99) > Duration::from_mins(1));
```


#  Convert [`chrono::TimeDelta`](https://docs.rs/chrono/latest/chrono/struct.TimeDelta.html) to/from [`std::time::Duration`](https://doc.rust-lang.org/stable/std/time/struct.Duration.html)
```rust
// -- chrono to std
let c_dur = TimeDelta::seconds(1);
let s_dur = TimeDelta::to_std(&c_dur)
    .map_err(anyhow::Error::msg)


// -- std to chrono
let s_dir = std::time::Duration::from_secs(1u64);
let c_dir = TimeDelta::from_std(s_dur)
    .map_err(anyhow::Error::msg)
```
1. [`::to_std()`](https://docs.rs/chrono/latest/chrono/struct.Duration.html#method.to_std), [`::from_std()`](https://docs.rs/chrono/latest/chrono/struct.Duration.html#method.from_std)


# [Sleep](https://doc.rust-lang.org/stable/std/thread/fn.sleep.html)
1. There's usually a better way structure code than sleep (see [Rayon](https://docs.rs/rayon/latest/rayon/), See [Crossbeam](https://docs.rs/crossbeam/latest/crossbeam/), See [tokio](https://docs.rs/tokio/latest/tokio/time/fn.sleep.html))
1. Standard
```rust
let d0 = std::time::Duration::from_secs(1);

// -- blocking
thread::sleep(d);

// -- Non-blocking/Asynchronous
tokio::time::sleep(d);
```


# Idioms
1. `chrono::TimeDelta` is much easier to use `std::time::Duration`
1. Standard lib might require `#![feature(duration_constructors)]` and `#![feature(duration_abs_diff)]`


# Serde

## chrono
1. See [serde module examples](./serde/chrono_timedelta.rs)
```rust
pub struct Foo {

    #[serde(with = "crate::chrono_timedelta_millis")]
    pub dur: chrono::TimeDelta,

    #[serde(with = "crate::chrono_timedelta_millis_opt")]
    pub maybe_dur: Option<chrono::TimeDelta>,
}
```

## `std::time`
1. See [serde module examples](./serde/std_time_duration.rs)
```rust
pub struct Bar {
    #[serde(with = "crate::std_duration_millis")]
    pub std_dur: std::time::Duration,
}
```


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
- https://rust-lang-nursery.github.io/rust-cookbook/datetime/duration.html#perform-checked-date-and-time-calculations


# Other Resources
1. https://doc.rust-lang.org/std/time/index.html
