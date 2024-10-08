# Overview
- Using dates, times, zones
- See [durations & periods](./duration.md) doc
- [JVM equivalent](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/time/Instant.html)


# Key Concepts
1. TODO: more here


# Representation
1. Zero value is TODO
TODO


# Construct
```go
TODO
```


# [Current Time](TODO)
1. Better to inject a clock (`func () time`)
```go
type Clock func() time.Time
...
c := func() time.Time {
    return time.Now()
}
```


# [Format](TODO) (to string)
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


# [Parse](TODO) (from string)
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



# Inject a clock
```go
func DoSomething(clock func() time) {

    ...
    now := clock()
    ...
}
```


# [Equality](https://pkg.go.dev/time#Time)
1. Use [`t0.Equal(t1)`](https://pkg.go.dev/time#Time.Equal) because it compares the instant
    1. (normalizes to same timezone before comparing)
1. **GOTCHA**: Don't use `==` because it compares location
```go
t0.Equal(t1)
```


# [Before](https://pkg.go.dev/time#Time.Before) & [After](https://pkg.go.dev/time#Time.After)
```go
t0.After(t1)
t1.Before(t0)
```


# Add/Subtract Durations/Periods
- See [duration](./duration.md) doc


# [Parts of day](https://pkg.go.dev/time#Time.Clock)
```go
h, m, s := t.Clock()

// or
h := t.Hour()    // 0-23
m := t.Minute()  // 0-59
s := t.Second()  // 0-59
```


# Timezones
```go
TODO
```


# [Months](https://pkg.go.dev/time#Time.Month)
1. [January == 1](https://pkg.go.dev/time#Month)
```
t.Month()
```


# Timing operations
1. See [Duration](./duration.md) doc


# Sleep
1. See [Duration](./duration.md) doc


# Run periodically
```go
    go func() {
        for range time.Tick(3 * time.Second) {
            print("it's me again")
        }
    }()
```


# Interop
## [From Unix Seconds](https://pkg.go.dev/time#Unix) (Epoch seconds)
```go
ts := time.Unix(uxSec, 0).UTC()
```

## [To Unix Seconds](https://pkg.go.dev/time#Time.Unix) (Epoch seconds)
```go
uxSec := ts.Unix()
```

## [From Unix Millis](https://pkg.go.dev/time#UnixMilli) (Epoch millis)
```go
ts := time.UnixMilli(uxMillis).UTC()
```

## [To Unix Millis](https://pkg.go.dev/time#Time.UnixMilli) (Epoch millis)
```go
uxMillis := t.UnixMilli()
```


# Idioms
1. Avoid [`time.Since`](TODO) because it hard codes `time.Now()` (better to inject a time provider)
1. Avoid [`time.Until`](TODO) because it hard codes `time.Now()` (better to inject a time provider)


# TODO/Unorganized
- TODO: t.AddDate
- TODO: t.Round & t.Truncate
- TODO: t.In
- TODO: t.UTC
- TODO: time.After (chan)


# Other Resources
1. https://www.practical-go-lessons.com/chap-28-dates-and-time
