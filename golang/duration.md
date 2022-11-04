# Overview
1. Using durations & periods
1. See also [datetime](./datetime.md) doc


# Terms
## `Duration`
1. Represents hours, minutes, seconds, millis, microseconds and nanoseconds
1. [Stored as `int64`](https://cs.opensource.google/go/go/+/refs/tags/go1.19.2:src/time/time.go;l=591) (nanoseconds between two instants)
1. Max value is ~290 years
1. [Rust equivalent](https://doc.rust-lang.org/stable/std/time/struct.Duration.html)
1. [JVM equivalent](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/Duration.html)
1. [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601#Durations)


## `Period`
1. An amount of time meaningful to humans
1. Generally imprecise because of timezones, [daylight savings time](https://en.wikipedia.org/wiki/Daylight_saving_time), variable month lengths, ...
1. Measured in Days, Weeks, Months, Years
1. [JVM equivalent](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/Period.html)
1. TODO: `ISO-8601` parse & format
1. [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601#Durations)


# [Construct](TODO) (from string)
```rust
TODO
```


# [Parse](TODO) (from string)
1. TODO: ISO 8601
1. Example
```go
TODO: more here
```
1. https://pkg.go.dev/time#ParseDuration


## Units:
- `h`: hour
- `m`: minute
- `s`: second
- `ms`: millisecond
- `us` or `µs`: microsecond
- `ns`: nanosecond


# [Format](TODO) (to string)
1. TODO: ISO 8601
1. Produces a string which can be Parsed via [time.ParseDuration]()
1. Example
```go
dur, err := time.ParseDuration("5h4m3s2ms")
...
fmt.Printf("dur: %v", dur.String())
```
1. https://pkg.go.dev/time#Duration.String


# [Timing](TODO)
```go
start := time.Now()

// ... do something ...

elapsed := time.Now().Sub(start)
log.Info().
    Str("elapsed", fmt.Sprintf("%v", elapsed)).
    Msg("total time")
```


# [Sleep](TODO)
1. Probably better to wait for [channel]() or a [`WaitGroup`](https://pkg.go.dev/sync#WaitGroup.Wait)
```go
time.Sleep(100 * time.Millisecond)
time.Sleep(20 * time.Second)
time.Sleep(5 * time.Minute)
```

# Add/Sub
```go
TODO
```


# [Round](TODO)
1. TODO: more here
1. [Official doc](https://pkg.go.dev/time#Duration.Round)


# [Truncate](TODO)
1. rounds down (toward zero)
1. Can truncate to any duration (eg. previous hour, minute, second, ... 5-minutes)
1. [Official doc](https://pkg.go.dev/time#Duration.Truncate)


# Idioms
1. Avoid `time.Since` because it hard codes `time.Now()` (better to inject a time provider)
1. Avoid `time.Until` because it hard codes `time.Now()` (better to inject a time provider)


# Other Resources
1. https://pkg.go.dev/time
