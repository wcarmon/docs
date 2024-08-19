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

## Now
1. chrono
```rust
- TODO
```
1. `std::time`
```rust
- TODO
```


## To/From epoch millis
- date +%s%3N  # produces epoch millis
1. chrono
```rust
- TODO
```
1. `std::time`
```rust
- TODO
```


## To/From epoch seconds
- `date '+%s'` produces epoch seconds
1. chrono
```rust
- TODO
```
1. `std::time`
```rust
- TODO
```

## yyyy-mm-dd hh:mm:ss
```rust
- TODO
```


# [Truncate](TODO)
1. chrono
```rust
TODO
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


# Other resources
1. TODO
