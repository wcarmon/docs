# Overview
1. Using dates, times, zones
1. See [durations & periods](./duration.md) doc
1. See [Epoch time doc](../common/epoch_time.md)
1. See [chrono crate doc](./datetime.chrono.md)
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


# Libs
1. [chrono crate doc](./datetime.chrono.md)
1. [time-rs crate doc](./datetime.time-rs.md)


# Run periodically
```rust
TODO
```


# Other Resources
1. https://doc.rust-lang.org/std/time/index.html
1. https://docs.rs/chrono/latest/chrono/
1. https://docs.rs/chrono/latest/chrono/struct.DateTime.html
1. https://doc.rust-lang.org/std/time/struct.Instant.html
1. https://doc.rust-lang.org/std/time/struct.SystemTime.html
1. https://docs.rs/time/latest/time/
