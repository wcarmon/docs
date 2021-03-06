# Overview
- Using dates, times, zones
- See [durations & periods](./duration.md) doc
- [JVM equivalent](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/Instant.html)


# Representation
1. Zero value is TODO
TODO


# Formatting (to string)
1. To standard [rfc3339](https://datatracker.ietf.org/doc/html/rfc3339)
```go
t.Format(time.RFC3339)
```
1. To other formats, use the [reference time of January 2, 15:04:05, 2006, in time zone seven hours west of GMT](https://pkg.go.dev/time#pkg-constants)
```go
t.Format("3:04PM")
t.Format("2006-01-02T15:04:05Z07:00") // rfc3339
t.Format("Mon Jan _2 15:04:05 MST 2006")
```
1. [Official doc](https://pkg.go.dev/time#Time.Format)
1. https://www.practical-go-lessons.com/chap-28-dates-and-time#format-the-time


# Parsing (from string)
1. From standard [rfc3339](https://datatracker.ietf.org/doc/html/rfc3339)
```go
s := "2022-11-45T22:36:19+00:00"
t, err := time.Parse(time.RFC3339, s)
if err != nil {
    return err
}
```
1. TODO: other formats (magic string)
1. [Official doc](https://pkg.go.dev/time#Parse)
1. https://www.practical-go-lessons.com/chap-28-dates-and-time#how-to-parse-a-datetime-contained-in-a-string


# Current Time
1. Better to inject a clock (`func ()`)
```go
type Clock func() time.Time
...
c := func() time.Time {
    return time.Now()
}
```


# Equality & Comparison
1. Use [t0.Equal(t1)](https://pkg.go.dev/time#Time.Equal) because it compares the instant
    1. (normalizes to same timezone before comparing)
1. Don't use `==` because it compares location
```go
```


# Parts of year
TODO


# Parts of day
TODO


# Before & After
TODO


# Add/Subtract Durations/Periods
- See [duration](./duration.md) doc


# Java/JVM interop
TODO


# Timezones
TODO


# Months
1. January == 1


# Sleep
1. See [Duration](./duration.md) doc

# Idioms
1. Avoid `time.Since` because it hard codes `time.Now()` (better to inject a time provider)
1. Avoid `time.Until` because it hard codes `time.Now()` (better to inject a time provider)


- TODO: t.Before & t.After
- TODO: t.AddDate
- TODO: t.Round & t.Truncate
- TODO: t.Sleep
- TODO: t.In
- TODO: t.UTC
- TODO: time.After (chan)



# Other resources
1. https://www.practical-go-lessons.com/chap-28-dates-and-time

