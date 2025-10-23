# Overview
1. Key points about time in C++20+


# TL;DR:
- Just use [`system_clock`](https://en.cppreference.com/w/cpp/chrono/system_clock.html) (logs, unix timestamps) and
[`steady_clock`](https://en.cppreference.com/w/cpp/chrono/steady_clock.html) for local benchmarks.


# Precision Time Protocol (PTP) with Hardware Timestamping
- sub-microsecond accuracy (Nanoseconds accuracy)
- Useful for timestamping market data events
- Records time on the Network Interface Card (NIC)
- No OS jitter since it bypasses the software stack


# [`std::chrono::system_clock`](https://en.cppreference.com/w/cpp/chrono/system_clock.html)
- **wall clock** time from the system-wide realtime clock
- Useful for human readable time, like logs
- unix time
- GOTCHA: Time can jump due to NTP adjustments
- Millisecond resolution (or tens of microseconds)
- Rust equivalent: `chrono::Utc::now()`
- Java equivalent: `java.time.Instant` or `Clock.systemUTC()`


# [`std::chrono::gps_clock`](https://en.cppreference.com/w/cpp/chrono/gps_clock.html)
- Not as useful for HFT because GPS receivers have unpredictable overhead
- Monotonic, Continuous, Never jumps
- high-precision time (nanoseconds)
- Better than `steady_clock` if time must be globally verifiable
- no leap seconds
- epoch in 1980


# [`std::chrono::tai_clock`](https://en.cppreference.com/w/cpp/chrono/tai_clock.html)
- Prefer `gps_clock`
- Useful for HFT
- Monotonic, Continuous, Never jumps
- high-precision time
- Better than `steady_clock` if time must be globally verifiable
- no leap seconds
- epoch in 1958


# [`std::chrono::steady_clock`](https://en.cppreference.com/w/cpp/chrono/steady_clock.html)
- Useful for benchmarks, measuring intervals/durations (local only)
- Useful for measuring latency in short code-paths
- In general, prefer `gps_clock`
- **monotonic** clock that will never be adjusted (never decreases)
- Intuition: stopwatch
- GOTCHA: Subject to OS Jitter (delays from context switching, interrupts, kernel processing).
- Rust equivalent: `std::time::SystemTime`
- Java equivalent: `System.nanoTime()`


# [`std::chrono::utc_clock`](https://en.cppreference.com/w/cpp/chrono/utc_clock.html)
- Useful for regulatory reporting, but not for HFT
- high-precision time
- Includes leap seconds (unlike system_clock)
- Rust equivalent: TODO
- Java equivalent: TODO


# [`std::chrono::file_clock`](https://en.cppreference.com/w/cpp/chrono/file_clock.html)
- Abstracts away platform-specific details of file modification times (portability)
- Useful for File system interaction
- Convert to/from `system_clock` when needed
- Rust equivalent: TODO
- Java equivalent: TODO


# [`std::chrono::high_resolution_clock`](https://en.cppreference.com/w/cpp/chrono/high_resolution_clock.html)
- Avoid
- clock with the smallest tick period provided by the implementation
- might just be an alias for another clock listed here, but this comes with resolution guarantees
- Hard to rely on because no guarantees about monotinicity


# Conversion
```c++
long long unix_ts = system_clock::now().time_since_epoch() / std::chrono::seconds(1);
long long unix_ts = system_clock::now().time_since_epoch().count();
```

# TODO: unorganized
- `std::chrono::clock_cast`
- `std::chrono::duration_cast`


# Other resources
1. https://en.cppreference.com/w/cpp/chrono.html#Clocks
