# Overview
1. Key points about time in C++20+


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


# [`std::chrono::steady_clock`](https://en.cppreference.com/w/cpp/chrono/steady_clock.html)
- **monotonic** clock that will never be adjusted (never decreases)
- Intuition: stopwatch
- Useful for benchmarks, measuring intervals/durations
- Useful for measuring latency in short code-paths
- GOTCHA: Subject to OS Jitter (delays from context switching, interrupts, kernel processing).
- Rust equivalent: `std::time::SystemTime`
- Java equivalent: `System.nanoTime()`


# [`std::chrono::utc_clock`](https://en.cppreference.com/w/cpp/chrono/utc_clock.html)
- high-precision time
- TODO: desc
- Includes leap seconds
- Useful for TODO
- Rust equivalent: TODO
- Java equivalent: TODO


# [`std::chrono::tai_clock`](TODO)
- high-precision time
- Continuous, Never jumps
- system_clock but without leap seconds? TODO
- Useful for TODO
- Rust equivalent: TODO
- Java equivalent: TODO


# [`std::chrono::gps_clock`](TODO)
- high-precision time
- Continuous, Never jumps
- Useful for TODO
- Rust equivalent: TODO
- Java equivalent: TODO


# [`std::chrono::file_clock`](TODO)
- Abstracts away platform-specific details of file modification times (portability)
- Useful for TODO
- Rust equivalent: TODO
- Java equivalent: TODO


# [`std::chrono::high_resolution_clock`](https://en.cppreference.com/w/cpp/chrono/high_resolution_clock.html)
- Avoid
- clock with the smallest tick period provided by the implementation
- might just be an alias for another clock listed here, but this comes with resolution guarantees
- Hard to rely on because no guarantees about monotinicity


# TODO: unorganized
- std::chrono::clock_cast


# Other resources
1. https://en.cppreference.com/w/cpp/chrono.html#Clocks
