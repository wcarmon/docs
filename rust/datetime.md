# Overview
1. Using dates, times, zones
1. See [durations & periods](./duration.md) doc
1. Using [chrono](https://docs.rs/chrono/latest/chrono/) lib


# Key Concepts
1. [`chrono::DateTime`](https://docs.rs/chrono/0.4.22/chrono/struct.DateTime.html): Date + time + timezone
1. [`std::time::Duration`](https://doc.rust-lang.org/std/time/struct.Duration.html): seconds + nanoseconds
    1. Golang equivalent is [`time.Duration`](https://pkg.go.dev/time#Duration)
    1. Java equivalent is [`Duration`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/Duration.html)
1. [`std::time::Instant`](https://doc.rust-lang.org/std/time/struct.Instant.html): TODO
    1. Golang equivalent is[`time.Time`](https://pkg.go.dev/time#Time)
    1. Java equivalent is [`Instant`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/Instant.html)
1. [`time::SystemTime`](https://doc.rust-lang.org/std/time/struct.SystemTime.html): system clock
    1. Golang equivalent is [`time.Now().UTC()`](https://pkg.go.dev/time#Time.UTC)
    1. Java equivalent is [`Clock.systemUTC()`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/Clock.html#systemUTC())

## No timezone
1. [`chrono::NaiveDate`](https://docs.rs/chrono/0.4.22/chrono/naive/struct.NaiveDate.html): date (no timezone)
    1. Java equivalent is [`LocalDate`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/LocalDate.html)
1. [`chrono::NaiveDateTime`](https://docs.rs/chrono/0.4.22/chrono/naive/struct.NaiveDateTime.html): Date and time (no timezone)
    1. Java equivalent is [`LocalDateTime`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/LocalDateTime.html)
1. [`chrono::NaiveTime`](https://docs.rs/chrono/0.4.22/chrono/naive/struct.NaiveTime.html): time (no timezone)
    1. Java equivalent is [`LocalTime`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/LocalTime.html)


# Construct
```rust
// TODO: this will panic!(...) if invalid
let dt = Utc.ymd(2014, 7, 8).and_hms(9, 10, 11); // `2014-07-08T09:10:11Z`

```


# [Current Time](https://doc.rust-lang.org/std/time/struct.Instant.html#method.now)
```rust
let now0 = Utc::now();      // chrono
let now1 = Instant::now();  // std
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
