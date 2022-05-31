# Overview
- Using durations & periods
- See [datetime](./datetime.md) doc


# Terms
## `Duration`
1. represents hours, minutes, seconds, millis, microseconds and nanoseconds
1. stored as `int64` (nanoseconds between two instants)
1. Max value is ~290 years
1. [JVM equivalent](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/Duration.html)
1. [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601#Durations)


## `Period`
1. An amount of time meaningful to humans
1. Generally imprecise because of timezones, [daylight savings time](https://en.wikipedia.org/wiki/Daylight_saving_time), variable month lengths, ...
1. Measured in Days, Weeks, Months, Years
1. [JVM equivalent](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/Period.html)
1. TODO: `ISO-8601` parse & format
1. [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601#Durations)


# Parse (from string)
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


# Format (to string)
1. TODO: ISO 8601
1. Produces a string which can be Parsed via [time.ParseDuration]()
1. Example
```go
dur, err := time.ParseDuration("5h4m3s2ms")
...

fmt.Printf("dur: %v", dur.String())
```
1. https://pkg.go.dev/time#Duration.String


# Round
1. TODO: more here
1. [Official doc](https://pkg.go.dev/time#Duration.Round)


# Truncate
1. rounds down (toward zero)
1. Can truncate to any duration (eg. previous hour, minute, second, ... 5-minutes)
1. [Official doc](https://pkg.go.dev/time#Duration.Truncate)


# Idioms
1. Avoid `time.Since` because it hard codes `time.Now()` (better to inject a time provider)
1. Avoid `time.Until` because it hard codes `time.Now()` (better to inject a time provider)


# Other resources
1. https://pkg.go.dev/time
1.
