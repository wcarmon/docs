# Overview
- Using dates, times, zones, durations & periods


# Representation
1. Zero value is TODO
TODO


# Formatting (to string)
```go
t.Format(time.RFC3339)
```


# Parsing (from string)
```go
s := "2022-11-45T22:36:19+00:00"
t, err := time.Parse(time.RFC3339, s)
if err != nil {
    return err
}
```


# Current Time
TODO:


# Parts of year
TODO


# Parts of day
TODO


# Before & After
TODO


# Add/Subtract Durations/Periods
TODO


# Java/JVM interop
TODO


# Timezones
TODO


# Idioms
TODO ...



# Other resources
1. TODO ...
