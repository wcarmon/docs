# Overview
1. Using dates, times, zones with chrono crate
1. See [Epoch time doc](../common/epoch_time.md)
1. See [Duration doc](../duration.md)

# Key Concepts
1. [`chrono::DateTime`](https://docs.rs/chrono/latest/chrono/struct.DateTime.html): Date + time + timezone
    1. More like a [Wall/Realtime clock](https://doc.rust-lang.org/std/time/struct.SystemTime.html)
    1. Implemented as [`NaiveDateTime`](https://docs.rs/chrono/latest/chrono/naive/struct.NaiveDateTime.html) + [`Tz::Offset`](https://docs.rs/chrono/latest/chrono/offset/trait.Offset.html)
    1. [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601)
    1. Golang equivalent: [`time.Time`](https://pkg.go.dev/time#Time)
    1. Java equivalent: [`OffsetDateTime`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/OffsetDateTime.html)
    1. Rust time-rs crate: [`OffsetDateTime`](https://docs.rs/time/latest/time/struct.OffsetDateTime.html)
1. [`chrono_tz`](https://github.com/chronotope/chrono-tz/) helps with more advanced timezone cases


## Without Timezone
1. [`chrono::NaiveDateTime`](https://docs.rs/chrono/latest/chrono/naive/struct.NaiveDateTime.html): Date and time (no timezone)
    1. Java equivalent: [`LocalDateTime`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/LocalDateTime.html)
    1. internally stored as pair of `NaiveDate` and `NaiveTime`
1. [`chrono::NaiveDate`](https://docs.rs/chrono/latest/chrono/naive/struct.NaiveDate.html): Date (no timezone)
    1. internally stored as bits representing year, month, date (no timezone)
    1. Java equivalent: [`LocalDate`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/LocalDate.html)
1. [`chrono::NaiveTime`](https://docs.rs/chrono/latest/chrono/naive/struct.NaiveTime.html): Time (no timezone)
    1. internally stored as `# seconds into the day` (`u32`) + `fraction of second` (`u32`)
    1. Java equivalent: [`LocalTime`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/LocalTime.html)


# Cons of Chrono library
1. Not very ergonomic/idiomatic in rust
    1. Error handling uses `Option` and [`MappedLocalTime`](https://docs.rs/chrono/latest/chrono/offset/type.MappedLocalTime.html) (incompatible with `?` operator, etc)
    1. fn naming scheme & deprecations
1. Does NOT use standard types for failure (like `Result`)
    1. Compare to time-rs crate
1. Larger memory representations than time-rs crate


# Equivalents in time-rs crate
|chrono crate|time-rs crate|
|---|---|
|[`DateTime`](https://docs.rs/chrono/latest/chrono/struct.DateTime.html)|[`time::OffsetDateTime`](https://docs.rs/time/latest/time/struct.OffsetDateTime.html)|
|[`NaiveDate`](https://docs.rs/chrono/latest/chrono/naive/struct.NaiveDate.html)|[`time::Date`](https://docs.rs/time/latest/time/struct.Date.html)|
|[`NaiveDateTime`](https://docs.rs/chrono/latest/chrono/naive/struct.NaiveDate.html)|[`time::PrimitiveDateTime`](https://docs.rs/time/latest/time/struct.PrimitiveDateTime.html)|
|[`NaiveTime`](https://docs.rs/chrono/latest/chrono/naive/struct.NaiveTime.html)|[`time::Time`](https://docs.rs/time/latest/time/struct.Time.html)|
|[`TimeDelta`](https://docs.rs/chrono/latest/chrono/struct.TimeDelta.html)|[`time::Duration`](https://docs.rs/time/latest/time/struct.Duration.html)|
|[`UTC`](https://docs.rs/chrono/latest/chrono/struct.Utc.html)|[`UtcOffset::UTC`](https://time-rs.github.io/api/time/struct.UtcOffset.html)|


# Create/Construct/Build

## From Now
1. chrono
```rust
    let now = chrono::Utc::now();
```
1. `std::time`
```rust
    let now = std::time::SystemTime::now();
```


## From Epoch millis
1. chrono
```rust
    let epoch_millis = 1724092128110;
    let ts = DateTime::from_timestamp_millis(epoch_millis)
        .context("failed to parse epoch millis")?;
    ...
```
1. `std::time`
```rust
    let epoch_millis = 1724092128110;
    let ts = UNIX_EPOCH + Duration::from_millis(epoch_millis);
    ...
```


## From Epoch seconds (unix timestamp)
1. chrono
```rust
    let epoch_seconds = 1734093128;
    let ts = DateTime::from_timestamp(epoch_seconds, 0)
        .context("failed to parse epoch seconds")?;
    ...
```
1. `std::time`
```rust
    let epoch_seconds = 1734093128;
    let ts = UNIX_EPOCH + Duration::from_secs(epoch_seconds);
    ...
```


## From string in [iso8601](https://en.wikipedia.org/wiki/ISO_8601) format (`yyyy-mm-dd hh:mm:ss`)
1. `chrono` - [see format](https://docs.rs/chrono/latest/chrono/format/strftime/index.html)
```rust

    // -- Alternative format example
    // let s = "2024-08-20 12:34:56";
    // let fmt = "%Y-%m-%d %H:%M:%S";

    let s = "2024-03-14T12:34:56";
    let fmt = "%Y-%m-%dT%H:%M:%S";

    // let first_19_chars = &s.chars().take(19).collect::<String>();

    let naive = NaiveDateTime::parse_from_str(s, fmt)
        .context("Failed to parse datetime")?;

    let ts: DateTime<Utc> = Utc.from_utc_datetime(&naive);
    ...


    // -- TODO: evaluate these:
    // let ts0 = "2022-09-27T13:41:59Z"
    //         .parse::<DateTime<Utc>>()
    //         .map_err(anyhow::Error::msg)
    //
    // let ts1 = DateTime::parse_from_rfc3339("2022-11-19T23:39:51-07:00")
    //     .map(|ts| ts.with_timezone(&Utc))
    //     .map_err(anyhow::Error::msg)
    //
    // let ts2 = DateTime::parse_from_str(
    //     "2023 Sep 21 12:39:14.294 +0000",
    //     "%Y %b %d %H:%M:%S%.3f %z")
    // .map(|ts| ts.with_timezone(&Utc))
    // .map_err(anyhow::Error::msg)
```
1. `std::time`
```rust
TODO
```


## From parts
```rust
    // -- Meaning 2024-Sep-13 11:33:44 UTC
    let ts = Utc.with_ymd_and_hms(2024, 9, 13, 11, 33, 44)
        .single()
        .ok_or_else(|| anyhow!("Invalid datetime"))?;
```


## Parse `NaiveDate`
```rust
    let date_str = "2024-09-17";
    let d = NaiveDate::parse_from_str(date_str, "%Y-%m-%d")?;

    assert_eq!(2024, d.year());
    assert_eq!(9, d.month());
    assert_eq!(8, d.month0());
    assert_eq!(17, d.day());
```

## Parse `NaiveTime`
```rust
    let time_str = "11:22:33";
    let t = NaiveTime::parse_from_str(time_str, "%H:%M:%S")?;

    assert_eq!(11, t.hour());
    assert_eq!(22, t.minute());
    assert_eq!(33, t.second());
```


# Convert to Epoch millis
- `date +%s%3N;`  # bash command produces Epoch millis
1. chrono
```rust
    let ts = ...
    let epoch_millis = ts.timestamp_millis(); // eg. 1724092128110
```
1. `std::time`
```rust
    let ts: std::time::SystemTime = ...

    let epoch_millis = if ts >= UNIX_EPOCH {
        ts.duration_since(UNIX_EPOCH)
            .context("failed to diff two std::time::SystemTimes")?
            .as_millis() as i64
    } else {
        // -- GOTCHA: duration_since only works for post epoch times, so we must flip
        -1 * UNIX_EPOCH.duration_since(*ts)
            .context("failed to diff two std::time::SystemTimes")?
            .as_millis() as i64
    };
```
- See https://doc.rust-lang.org/std/time/struct.SystemTime.html#method.duration_since


# Convert to Epoch seconds
- `date '+%s';`  # bash command produces Epoch seconds
1. chrono
```rust
    let ts = ...
    let epoch_seconds = ts.timestamp();  // eg. 1724092
```
1. `std::time`
```rust
    let ts = ...
    let epoch_seconds = ts
        .duration_since(UNIX_EPOCH)
        .expect("failed to get epoch millis")
        .as_secs();
```


# Truncate to the nearest ...
1. chrono
```rust
    let ts = ...

    let nearest_second = ts
        .with_nanosecond(0)
        .ok_or_else(|| anyhow!("failed to remove nanos"))?;

    // -- meaning: first second of same minute
    let nearest_minute = ts
        .with_second(0)
        .ok_or_else(|| anyhow!("failed to remove seconds"))?
        .with_nanosecond(0)
        .ok_or_else(|| anyhow!("failed to remove nanos"))?;

    // -- alternative
    let nearest_minute = Utc.with_ymd_and_hms(
            ts.year(), ts.month(), ts.day(), ts.hour(), ts.minute(), 0)
        .single()
        .ok_or_else(|| anyhow!("Invalid datetime"))?;


    // -- meaning: first minute of same hour
    let nearest_hour = ts
        .with_minute(0)
        .ok_or_else(|| anyhow!("failed to remove minutes"))?
        .with_second(0)
        .ok_or_else(|| anyhow!("failed to remove seconds"))?
        .with_nanosecond(0)
        .ok_or_else(|| anyhow!("failed to remove nanos"))?;

    // -- alternative
    let nearest_hour = Utc.with_ymd_and_hms(
            ts.year(), ts.month(), ts.day(), ts.hour(), 0, 0)
        .single()
        .ok_or_else(|| anyhow!("Invalid datetime"))?;


    // -- meaning: first hour of same day in UTC
    let nearest_day = ts
        .with_hour(0)
        .ok_or_else(|| anyhow!("failed to remove hours"))?
        .with_minute(0)
        .ok_or_else(|| anyhow!("failed to remove minutes"))?
        .with_second(0)
        .ok_or_else(|| anyhow!("failed to remove seconds"))?
        .with_nanosecond(0)
        .ok_or_else(|| anyhow!("failed to remove nanos"))?;

    // -- alternative:
    let nearest_day = Utc.with_ymd_and_hms(
            ts.year(), ts.month(), ts.day(), 0, 0, 0)
        .single()
        .ok_or_else(|| anyhow!("Invalid datetime"))?;
```
1. `std::time`
```rust
TODO
```


# Comparing
- `DateTime<Utc>` implements [`Ord`](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#impl-Ord-for-DateTime%3CTz%3E) and [`PartialOrd`](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#impl-PartialOrd%3CDateTime%3CTz2%3E%3E-for-DateTime%3CTz%3E), and [`Eq`](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#method.eq) so ...
1. chrono
```rust
    let ts0 = Utc.with_ymd_and_hms(2024, 1, 1, 0, 0, 0)
                       .single()
                       .ok_or_else(|| anyhow!("Invalid datetime"))?;

    let ts1 = Utc.with_ymd_and_hms(2024, 12, 31, 0, 0, 0)
                       .single()
                       .ok_or_else(|| anyhow!("Invalid datetime"))?;

    if ts0 == ts1 {
        // ...
    }

    if ts0 <= ts1 {
        // ...
    }
```
1. `std::time`
```rust
TODO
```


# Formatting
- See [`format`](https://docs.rs/chrono/latest/chrono/format/strftime/index.html#specifiers) syntax
1. `chrono`
```rust
    let ts = DateTime::from_timestamp_millis(1724182159339)
        .ok_or_else(|| anyhow!("Invalid timestamp"))?;

    assert_eq!(ts.to_rfc3339(), ts.format("%+").to_string());

    assert_eq!("2024-08-20",            ts.format("%Y-%m-%d").to_string());
    assert_eq!("2024-Aug-20",           ts.format("%Y-%b-%d").to_string());
    assert_eq!("August 20, 2024",       ts.format("%B %d, %Y").to_string());
    assert_eq!("2024-08-20T19:29:19.339+00:00", ts.to_rfc3339());

    // -- RFC Truncated to nearest second
    assert_eq!("2024-08-20T19:29:19",   ts.format("%Y-%m-%dT%H:%M:%S").to_string());

    let nearest_sec = ts
        .with_nanosecond(0)
        .ok_or_else(|| anyhow!("Failed to remove nanos"))?;
    assert_eq!("2024-08-20T19:29:19+00:00", nearest_sec.to_rfc3339());
```
1. `std::time`
```rust
TODO
```


## Format `NaiveDate`
```rust
let d: NaiveDate = ...
println!("formatted: {d}");
```



# Change Timezone
1. `chrono`
    1. need [`chrono-tz`](https://docs.rs/chrono-tz/latest/chrono_tz/) crate
```rust
    let utc = DateTime::from_timestamp_millis(1724182159339).unwrap();

    let chicago = utc.with_timezone(&chrono_tz::America::Chicago);
    let london = utc.with_timezone(&chrono_tz::Europe::London);
    let los_angeles = utc.with_timezone(&chrono_tz::America::Los_Angeles);
    let moscow = utc.with_timezone(&chrono_tz::Europe::Moscow);
    let nyc = utc.with_timezone(&chrono_tz::America::New_York);
    let paris = utc.with_timezone(&chrono_tz::Europe::Paris);
    let tokyo = utc.with_timezone(&chrono_tz::Asia::Tokyo);

    let fmt = "%Y-%m-%dT%H:%M:%S";
    assert_eq!("2024-08-20T12:29:19", los_angeles.format(fmt).to_string());
    assert_eq!("2024-08-20T14:29:19", chicago.format(fmt).to_string());
    assert_eq!("2024-08-20T15:29:19", nyc.format(fmt).to_string());
    assert_eq!("2024-08-20T20:29:19", london.format(fmt).to_string());
    assert_eq!("2024-08-20T21:29:19", paris.format(fmt).to_string());
    assert_eq!("2024-08-20T22:29:19", moscow.format(fmt).to_string());
    assert_eq!("2024-08-21T04:29:19", tokyo.format(fmt).to_string());
```
1. `std::time`
```rust
TODO
```
1. [See also](https://rust-lang-nursery.github.io/rust-cookbook/datetime/duration.html#convert-a-local-time-to-another-timezone)



# Time in a Timezone
```rust
// A time "Today" (from the time zone's perspective)
//
// let eight_am = NaiveTime::from_hms_opt(8, 0, 0).ok_or_else(|| anyhow!("Invalid time"))?;
// let four_pm = NaiveTime::from_hms_opt(16, 0, 0).ok_or_else(|| anyhow!("Invalid time"))?;
// let ... = build_time_in_zone(eight_am, &Tokyo)?;
// let ... = build_time_in_zone(four_pm, &New_York)?;
fn build_time_in_zone(
    time: NaiveTime,
    tz: &Tz,
) -> Result<DateTime<Tz>, anyhow::Error> {
    let now_in_zone = Utc::now().with_timezone(tz);

    tz.with_ymd_and_hms(
        now_in_zone.year(),
        now_in_zone.month(),
        now_in_zone.day(),
        time.hour(),
        time.minute(),
        time.second(),
    )
        .single()
        .ok_or_else(|| anyhow!("failed to calculate time in tz={}", tz))
}
```


# Get parts of datetime
1. [Hour](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#method.hour), [Minute](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#method.minute), [Second](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#method.second)
1. `chrono`
```rust
    let ts = DateTime::from_timestamp_millis(1724182159339).unwrap();

    assert_eq!(ts.timezone(), Utc);

    assert_eq!(ts.year(), 2024);
    assert_eq!(ts.month(), 8);      // Jan=1, Feb=2, ... Dec=12
    assert_eq!(ts.month0(), 7);     // Jan=0, Feb=1, ... Dec=11
    assert_eq!(ts.day(), 20);

    assert_eq!(ts.hour(), 19);      // 0-23
    assert_eq!(ts.minute(), 29);    // 0-59
    assert_eq!(ts.second(), 19);    // 0-59
```
1. See also [`hour12()`](https://docs.rs/chrono/latest/chrono/trait.Timelike.html#method.hour12)


# n Days Ago
1. `chrono`
```rust
    // -- Sept 13th
    let ts = Utc.with_ymd_and_hms(2024, 9, 13, 0, 0, 1)
        .single()
        .ok_or_else(|| anyhow!("Invalid datetime"))?;

    // -- Sept 8th
    let want = Utc.with_ymd_and_hms(2024, 9, 8, 0, 0, 1)
        .single()
        .ok_or_else(|| anyhow!("Invalid datetime"))?;

    let got = ts - TimeDelta::days(5);
    assert_eq!(want, got);
```


# Inject a clock
```rust
fn do_something(clock: fn() -> DateTime<Utc>) {
    let now = clock();
    ...
}
```


#  Convert [`chrono::DateTime`](https://docs.rs/chrono/latest/chrono/struct.DateTime.html) to/from [`std::time::SystemTime`](https://doc.rust-lang.org/std/time/struct.SystemTime.html)
```rust
// to std
let std_ts: SystemTime = Utc::now().into();

// to chrono
let chrono_ts: DateTime<Utc> = SystemTime::now().into();
```
1. [Official doc](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#impl-From%3CSystemTime%3E-for-DateTime%3CUtc%3E)


# Add/Subtract Durations/Periods
- See [duration](./duration.md) doc


# Timing operations
1. See [Duration](./duration.md) doc


# Sleep
1. See [Duration](./duration.md) doc


# Idioms
1. Avoid [~~`elapsed`~~](https://doc.rust-lang.org/std/time/struct.Instant.html#method.elapsed) since it hard codes [`Instant::now()`](https://doc.rust-lang.org/std/time/struct.Instant.html#method.now)


# Serde
1. TODO: DateTime -> epoch_millis


# Other resources
1. https://doc.rust-lang.org/std/time/index.html
1. https://docs.rs/chrono/latest/chrono/
1. https://docs.rs/chrono/latest/chrono/struct.DateTime.html
1. https://doc.rust-lang.org/std/time/struct.Instant.html
1. https://doc.rust-lang.org/std/time/struct.SystemTime.html

