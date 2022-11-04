# Overview
1. Idioms for logging
1. See also [tracing doc](./tracing.md)


# Summary of key ideas
1. Prefer [`tracer`]() or [`opentelemetry`](TODO)
1. If you must use logging directly, prefer the [log crate](https://docs.rs/log/latest/log/)
1. Add logs where you **handle** an [`Error`](https://docs.rs/anyhow/latest/anyhow/struct.Error.html), not where you propagate (`?`)


# Other Resources
1. https://docs.rs/log/latest/log/