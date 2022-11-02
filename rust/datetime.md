# Overview
1. Using dates, times, zones
1. See [durations & periods](./duration.md) doc
1. Using [chrono](https://docs.rs/chrono/latest/chrono/) lib


# Key Concepts
1. [Wall/Realtime Clock](https://doc.rust-lang.org/std/time/struct.SystemTime.html):
    1. machine's best-guess as to the current time of day
    1. Can jump back and forth due to many factors (eg. [NTP](https://wiki.archlinux.org/title/Network_Time_Protocol_daemon), laptop suspend, etc)
    1. Seconds & nanos since [Epoch](https://en.wikipedia.org/wiki/Unix_time)
    1. [Can be set/updated](https://man7.org/linux/man-pages/man3/clock_settime.3.html) by code/user
1. [Monotonic Clock](https://doc.rust-lang.org/std/time/struct.Instant.html):
    1. only has meaning within the process
    1. current value not that important, only useful for comparisons
    1. Cannot be set by code/user
1. [`chrono::DateTime`](https://docs.rs/chrono/0.4.22/chrono/struct.DateTime.html): Date + time + timezone
    1. Java equivalent: [`OffsetDateTime`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/OffsetDateTime.html)
    1. Golang equivalent is [`time.Time`](https://pkg.go.dev/time#Time)
1. [`time::SystemTime`](https://doc.rust-lang.org/std/time/struct.SystemTime.html): system clock
    1. Golang equivalent: [`time.Now().UTC()`](https://pkg.go.dev/time#Time.UTC) (handles both [wall](https://pkg.go.dev/time) and [monotonic](https://pkg.go.dev/time#hdr-Monotonic_Clocks))
    1. Java equivalent: [`Clock.systemUTC()`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/Clock.html#systemUTC())
1. [`std::time::Duration`](https://doc.rust-lang.org/std/time/struct.Duration.html): seconds + nanoseconds
    1. Golang equivalent: [`time.Duration`](https://pkg.go.dev/time#Duration)
    1. Java equivalent: [`Duration`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/Duration.html)
1. [`std::time::Instant`](https://doc.rust-lang.org/std/time/struct.Instant.html): [monotonic](https://doc.rust-lang.org/std/time/struct.Instant.html#monotonicity), nondecreasing, useful only for calculating [Durations](https://doc.rust-lang.org/std/time/struct.Duration.html)
    1. Golang equivalent is [`time.Time`](https://pkg.go.dev/time#Time) (handles both [wall](https://pkg.go.dev/time) and [monotonic](https://pkg.go.dev/time#hdr-Monotonic_Clocks))
    1. Java equivalent: [time4j / SystemClock](http://time4j.net/javadoc-en/net/time4j/SystemClock.html)
1. [`chrono_tz`](https://github.com/chronotope/chrono-tz/) helps with more advanced timezone cases


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
let now1 = SystemTime::now();  // std
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
