# Overview
1. Using dates, times, zones
1. See [durations & periods](./duration.md) doc
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
1. [`chrono::DateTime`](https://docs.rs/chrono/latest/chrono/struct.DateTime.html): Date + time + timezone
    1. More like a [Wall/Realtime clock](https://doc.rust-lang.org/std/time/struct.SystemTime.html)
    1. Implemented as [`NaiveDateTime`](https://docs.rs/chrono/latest/chrono/naive/struct.NaiveDateTime.html) + [`Tz::Offset`](https://docs.rs/chrono/latest/chrono/offset/trait.Offset.html)
    1. [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601)
    1. Golang equivalent: [`time.Time`](https://pkg.go.dev/time#Time)
    1. Java equivalent: [`OffsetDateTime`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/OffsetDateTime.html)
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
1. [`chrono_tz`](https://github.com/chronotope/chrono-tz/) helps with more advanced timezone cases


## No Timezone
1. [`chrono::NaiveDateTime`](https://docs.rs/chrono/latest/chrono/naive/struct.NaiveDateTime.html): Date and time (no timezone)
    1. Java equivalent: [`LocalDateTime`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/LocalDateTime.html)
    1. internally stored as pair of `NaiveDate` and `NaiveTime`
1. [`chrono::NaiveDate`](https://docs.rs/chrono/latest/chrono/naive/struct.NaiveDate.html): Date (no timezone)
    1. internally stored as bits representing year, month, date (no timezone) 
    1. Java equivalent: [`LocalDate`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/LocalDate.html)    
1. [`chrono::NaiveTime`](https://docs.rs/chrono/latest/chrono/naive/struct.NaiveTime.html): Time (no timezone)
    1. internally stored as `# seconds into the day` (`u32`) + `fraction of second` (`u32`)
    1. Java equivalent: [`LocalTime`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/LocalTime.html)    


# Construct
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
```

## From Epoch seconds
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


# [Current Time](https://doc.rust-lang.org/std/time/struct.Instant.html#method.now)
```rust
let wall0 = Utc::now();      // chrono
let wall1 = SystemTime::now();  // std

let monotonic0 = Instant::now(); // std
```


# [Format](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#method.format) (to string)
1. To standard [rfc3339](https://datatracker.ietf.org/doc/html/rfc3339)
```rust
let ts = Utc::now();
let s = format!("{}", ts.format("%+")); // rfc3339
print!("{}", s);
```
1. To [other formats](https://docs.rs/chrono/latest/chrono/format/strftime/index.html#specifiers)
```rust
let ts = Utc::now();
let s = format!("{}", ts.format("%d/%m/%Y %H:%M"));
print!("{}", s);
```

## Format `NaiveDate`
```rust
let d: NaiveDate = ... ;
println!("formatted: {d}");
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
    // TODO: how to use with ?
```


# Inject a clock
```rust
fn do_something(clock: fn() -> DateTime<Utc>) {
    let now = clock();
    ...
}
```


# [Equality](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#method.eq)
```rust
ts0 == ts1
```


# [Before & After](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#impl-PartialOrd%3CDateTime%3CTz2%3E%3E-for-DateTime%3CTz%3E)
```rust
ts0 < ts1
ts0 >= ts1

// or

match ts0.cmp(&ts1){
    Ordering::Less => println!("Before"),
    Ordering::Equal => println!("Same"),
    Ordering::Greater => println!("After"),
}
```


# Add/Subtract Durations/Periods
- See [duration](./duration.md) doc


# Parts of day ([Hour](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#method.hour), [Minute](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#method.minute), [Second](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#method.second))
```rust
let h = ts.hour()   // 0-23
let m = ts.minute() // 0-59
let s = ts.second() // 0-59
```
1. see also [`hour12()`](https://docs.rs/chrono/latest/chrono/trait.Timelike.html#method.hour12)


# Timezones
1. [change timezone](https://rust-lang-nursery.github.io/rust-cookbook/datetime/duration.html#convert-a-local-time-to-another-timezone)


# [Months](https://docs.rs/chrono/latest/chrono/trait.Datelike.html#tymethod.month)
```rust
ts.month()  // Jan=1, Feb=2, ... Dec=12
ts.month0() // Jan=0, Feb=1, ... Dec=11
```


# Timing operations
1. See [Duration](./duration.md) doc


# Sleep
1. See [Duration](./duration.md) doc


# Run periodically
```rust
TODO
```


# Interop
## [From Unix Seconds](https://docs.rs/chrono/latest/chrono/naive/struct.NaiveDateTime.html#method.from_timestamp)
```rust
let ndt = NaiveDateTime::from_timestamp(ux_sec, 0);
let ts = DateTime::<Utc>::from_utc(ndt, Utc);
```

## [From Unix Millis]()
- TODO: DateTime::from_timestamp_millis(1711557020035)
```rust
let nanos = ((ux_millis % 1000) * 1_000_000) as u32;
let ndt = NaiveDateTime::from_timestamp(ux_millis / 1000, nanos);
let ts = DateTime::<Utc>::from_utc(ndt, Utc);
```

## [To Unix Seconds](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#method.timestamp)
```rust
let ux_sec = ts.timestamp()
```

## [To Unix Millis](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#method.timestamp_millis)
```rust
let ux_millis = ts.timestamp_millis()
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
