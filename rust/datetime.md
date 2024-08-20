# Overview
1. Using dates, times, zones
1. See [durations & periods](./duration.md) doc
1. See [Epoch time doc](../common/epoch_time.md)
1. See [chrono crate doc](./datetime.chrono.md)
1. Using [chrono](https://docs.rs/chrono/latest/chrono/) lib


# Key Concepts
1. [Wall/Realtime Clock](https://doc.rust-lang.org/std/time/struct.SystemTime.html):
    1. Useful for communicating outside the process (eg. network, file, another process, etc)
    1. **Not** useful for calculating [Durations](https://doc.rust-lang.org/stable/std/time/struct.Duration.html)
    1. Machine's best-guess as to the current time of day
    1. Can jump back and forth due to many factors (eg. [NTP](https://wiki.archlinux.org/title/Network_Time_Protocol_daemon), laptop suspend, etc)
    1. Seconds & nanos since [Epoch](https://doc.rust-lang.org/std/time/constant.UNIX_EPOCH.html)
    1. User/Code can [set/updated](https://man7.org/linux/man-pages/man3/clock_settime.3.html)
1. [Monotonic Clock](https://doc.rust-lang.org/std/time/struct.Instant.html):
    1. Useful for calculating [Durations](https://doc.rust-lang.org/stable/std/time/struct.Duration.html)
    1. Only useful/meaningful within the [process](https://en.wikipedia.org/wiki/Process_(computing))
    1. Current value not that important, only useful for comparisons (eg. [`add`](https://doc.rust-lang.org/std/time/struct.Instant.html#method.checked_add), [`sub`](https://doc.rust-lang.org/std/time/struct.Instant.html#method.sub), etc)
    1. User/Code cannot set/update
1. [`std::time::SystemTime`](https://doc.rust-lang.org/std/time/struct.SystemTime.html): system clock, wall clock, realtime clock
    1. Lacks parse & format features
    1. Golang equivalent: [`time.Now().UTC()`](https://pkg.go.dev/time#Time.UTC) (handles both [wall](https://pkg.go.dev/time) and [monotonic](https://pkg.go.dev/time#hdr-Monotonic_Clocks))
    1. Java equivalent: [`Clock.systemUTC()`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/Clock.html#systemUTC())
1. [`std::time::Instant`](https://doc.rust-lang.org/std/time/struct.Instant.html): [monotonic](https://doc.rust-lang.org/std/time/struct.Instant.html#monotonicity), nondecreasing, useful only for calculating [Durations](https://doc.rust-lang.org/std/time/struct.Duration.html)
    1. Golang equivalent: [`time.Time`](https://pkg.go.dev/time#Time) (handles both [wall](https://pkg.go.dev/time) and [monotonic](https://pkg.go.dev/time#hdr-Monotonic_Clocks))
    1. Java equivalent: [time4j / SystemClock](http://time4j.net/javadoc-en/net/time4j/SystemClock.html)
1. [`std::time::Duration`](https://doc.rust-lang.org/std/time/struct.Duration.html): Seconds + nanoseconds
    1. Golang equivalent: [`time.Duration`](https://pkg.go.dev/time#Duration)
    1. Java equivalent: [`Duration`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/Duration.html)


# Libs
1. [chrono crate doc](./datetime.chrono.md)
1. [time-rs crate doc](./datetime.time-rs.md)


# Usage: Construct
```rust
// GOTCHA: this will panic!(...) if invalid
// This is fine for test code, not for prod
let dt = Utc.ymd(2014, 7, 8).and_hms(9, 10, 11); // `2014-07-08T09:10:11Z`
```
1. See also [Parse](datetime.md#parse-from-string)

## From Epoch millis
```rust
let epoch_millis: i64 = ... ;

let utc = DateTime::from_timestamp_millis(epoch_millis)
        .ok_or(anyhow!("failed to build DateTime"))?

// -- inverse: utc.timestamp_millis()
```

## ~~From Epoch seconds~~
1. You don't gain much over millis, in terms of representable dates
```rust
let epoch_seconds: i64 = ... ;

let nanos = (epoch_seconds % 1000) * 1_000_000;
let utc = DateTime::from_timestamp(
    epoch_seconds,
    nanos as u32,
).ok_or(anyhow!("failed to build DateTime"))
```

## From Epoch nanos
```rust
let epoch_nanos: i64 = ... ;

let secs = epoch_nanos / 1_000_000_000;
let nanos = (epoch_nanos % 1_000_000_000) as u32;
let utc = DateTime::from_timestamp(
    secs, nanos as u32
).ok_or(anyhow!("failed to build DateTime"))
```


# [Parse](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#impl-FromStr-for-DateTime%3CFixedOffset%3E) (from string)
1. From standard [rfc3339](https://datatracker.ietf.org/doc/html/rfc3339)
```rust
let ts0 = "2022-09-27T13:41:59Z"
        .parse::<DateTime<Utc>>()
        .map_err(anyhow::Error::msg)

let ts1 = DateTime::parse_from_rfc3339("2022-11-19T23:39:51-07:00")
        .map(|ts| ts.with_timezone(&Utc))
        .map_err(anyhow::Error::msg)
```
1. From [other formats](https://docs.rs/chrono/latest/chrono/format/strftime/index.html#specifiers) using [`parse_from_str`](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#method.parse_from_str)
```rust
let ts1 = DateTime::parse_from_str(
        "2023 Sep 21 12:39:14.294 +0000",
        "%Y %b %d %H:%M:%S%.3f %z")
    .map(|ts| ts.with_timezone(&Utc))
    .map_err(anyhow::Error::msg)
```

## Parse NaiveDate
```rust
let date_str = "2024-09-17";
let d = NaiveDate::parse_from_str(date_str, "%Y-%m-%d")
    .or(Err(format!("failed to parse date: {date_str}")))?;
    // TODO: how to make this work with ?
```


# Run periodically
```rust
TODO
```


# Interop
## [From Epoch Seconds](https://docs.rs/chrono/latest/chrono/naive/struct.NaiveDateTime.html#method.from_timestamp)
```rust
let ndt = NaiveDateTime::from_timestamp(ux_sec, 0);
let ts = DateTime::<Utc>::from_utc(ndt, Utc);
```

## [From Epoch Millis]()
- TODO: DateTime::from_timestamp_millis(1711557020035)
```rust
// time-rs
let ts = OffsetDateTime::UNIX_EPOCH + Duration::milliseconds(ux_millis)

// Chrono
let nanos = ((ux_millis % 1000) * 1_000_000) as u32;
let ndt = NaiveDateTime::from_timestamp(ux_millis / 1000, nanos);
let ts = DateTime::<Utc>::from_utc(ndt, Utc);
```

## [To Epoch Millis](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#method.timestamp_millis)
```rust
let ts = OffsetDateTime::now_utc();
let epoch_millis = ts.timestamp_millis()  // TODO: fix this
```

## [To Epoch Seconds](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#method.timestamp)
```rust
let epoch_sec = ts.timestamp()
```

#  [`chrono::DateTime`](https://docs.rs/chrono/latest/chrono/struct.DateTime.html) to/from [`std::time::SystemTime`](https://doc.rust-lang.org/std/time/struct.SystemTime.html)
```rust
// to std
let std_ts: SystemTime = Utc::now().into();

// to chrono
let chrono_ts: DateTime<Utc> = SystemTime::now().into();
```
1. [Official doc](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#impl-From%3CSystemTime%3E-for-DateTime%3CUtc%3E)


# Idioms
1. Avoid [~~`elapsed`~~](https://doc.rust-lang.org/std/time/struct.Instant.html#method.elapsed) since it hard codes [`Instant::now()`](https://doc.rust-lang.org/std/time/struct.Instant.html#method.now)


- TODO: consider https://docs.rs/time/latest/time/
- TODO: convert DateTime between time zones (UTC, NYC, AZ, Chicago)


# Other Resources
1. https://doc.rust-lang.org/std/time/index.html
1. https://docs.rs/chrono/latest/chrono/
1. https://docs.rs/chrono/latest/chrono/struct.DateTime.html
1. https://doc.rust-lang.org/std/time/struct.Instant.html
1. https://doc.rust-lang.org/std/time/struct.SystemTime.html
1. https://docs.rs/time/latest/time/
