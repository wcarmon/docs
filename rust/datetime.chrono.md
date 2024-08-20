# Overview
1. Using dates, times, zones with chrono crate
1. See [Epoch time doc](../common/epoch_time.md)


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
    1. Error handling (incompatible with `?` operator, how they use panic, etc)
    1. fn naming scheme
1. Does NOT use standard types for failure (like `Result`, `Option`)
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
        .expect("Failed to parse datetime");

    let ts: DateTime<Utc> = Utc.from_utc_datetime(&naive);
    ...
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


# To Epoch millis
- `date +%s%3N;`  # bash command produces Epoch millis
1. chrono
```rust
    let ts = ...
    let epoch_millis = ts.timestamp_millis(); // eg. 1724092128110
```
1. `std::time`
```rust
    let ts = ...
    let epoch_millis = ts
        .duration_since(UNIX_EPOCH)
        .expect("failed to get epoch millis")
        .as_millis();
```


# To Epoch seconds
- `date '+%s';`  # bash command produces Epoch seconds
1. chrono
```rust
    let ts = ...
    let epoch_seconds = ts.timestamp_millis() / 1000;  // eg. 1724092
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
- `DateTime<Utc>` implements [`Ord`](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#impl-Ord-for-DateTime%3CTz%3E) and [`PartialOrd`](https://docs.rs/chrono/latest/chrono/struct.DateTime.html#impl-PartialOrd%3CDateTime%3CTz2%3E%3E-for-DateTime%3CTz%3E), so ...
1. chrono
```rust
    let ts0 = Utc.with_ymd_and_hms(2024, 1, 1, 0, 0, 0)
                       .single()
                       .ok_or_else(|| anyhow!("Invalid datetime"))?;
    let ts1 = Utc.with_ymd_and_hms(2024, 12, 31, 0, 0, 0)
                       .single()
                       .ok_or_else(|| anyhow!("Invalid datetime"))?;

    if ts0 < ts1 {
        // ...
    }
```
1. `std::time`
```rust
TODO
```


# Formatting
- See [`format` syntax](https://docs.rs/chrono/latest/chrono/format/strftime/index.html#specifiers)
1. `chrono`
```rust
    let ts = DateTime::from_timestamp_millis(1724182159339).unwrap();

    assert_eq!(ts.to_rfc3339(), ts.format("%+").to_string());

    assert_eq!("2024-08-20",            ts.format("%Y-%m-%d").to_string());
    assert_eq!("2024-08-20T19:29:19",   ts.format("%Y-%m-%dT%H:%M:%S").to_string());
    assert_eq!("2024-Aug-20",           ts.format("%Y-%b-%d").to_string());
    assert_eq!("August 20, 2024",       ts.format("%B %d, %Y").to_string());
    assert_eq!("2024-08-20T19:29:19.339+00:00", ts.to_rfc3339());

    // -- truncated to nearest second
    let nearest_sec = ts
        .with_nanosecond(0)
        .ok_or_else(|| anyhow!("Failed to remove nanos"))?;
    assert_eq!("2024-08-20T19:29:19+00:00", nearest_sec.to_rfc3339());
```
1. `std::time`
```rust
TODO
```

# Change timezone
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


# Time in a Timezone
```rust
// A time "Today" (from the time zone's perspective)
//
// @param hour: 0-24
// @param minute: 0-59
// @param sec: 0-59
// @param tz: chrono_tz::Tz ref
//
// eg. 8am "today" in Tokyo:  build_time_in_zone(8, 0, 0, &Tokyo)?
// eg. 4pm "today" in NYC:    build_time_in_zone(16, 0, 0, &New_York)?
fn build_time_in_zone(
    hour: u8,
    minute: u8,
    second: u8,
    tz: &Tz,
) -> Result<DateTime<Tz>, anyhow::Error> {
    ensure!(hour < 24, "invalid hour");
    ensure!(minute < 60, "invalid minute");
    ensure!(second < 60, "invalid second");

    let now_in_zone = Utc::now().with_timezone(tz);

    tz.with_ymd_and_hms(
        now_in_zone.year(),
        now_in_zone.month(),
        now_in_zone.day(),
        hour as u32,
        minute as u32,
        second as u32,
    )
        .single()
        .ok_or_else(|| anyhow!("failed to calculate time in tz={}", tz))
}
```


# Parts of datetime
1. `chrono`
```rust
    let ts = DateTime::from_timestamp_millis(1724182159339).unwrap();

    assert_eq!(ts.timezone(), Utc);

    assert_eq!(ts.year(), 2024);
    assert_eq!(ts.month(), 8);
    assert_eq!(ts.day(), 20);

    assert_eq!(ts.hour(), 19);
    assert_eq!(ts.minute(), 29);
    assert_eq!(ts.second(), 19);
```


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


# TODO/Unorganized

- TODO: replace all unwrap/expect with anyhow


# Other resources
1. TODO
