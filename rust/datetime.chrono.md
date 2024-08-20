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
1. chrono - [see format](https://docs.rs/chrono/latest/chrono/format/strftime/index.html)
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
- TODO: is_before/is_after
1. chrono
```rust
TODO
```
1. `std::time`
```rust
TODO
```

- TODO: replace all unwrap/expect with anyhow

# Other resources
1. TODO
