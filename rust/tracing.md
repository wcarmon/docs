# Overview
1. Idioms for [Tracing](https://opentelemetry.io/docs/concepts/signals/traces/) (and associated Logging)
1. How to use [tracing](https://docs.rs/tracing/latest/tracing/) and [OpenTelemetry](https://opentelemetry.io/docs/instrumentation/rust/)


# Summary of key ideas
1. [tracing](https://docs.rs/tracing/latest/tracing) lib handles both tracing and [logging](./logging.md)
1. [tracing](https://docs.rs/tracing/latest/tracing) API is close enough to OpenTracing
    1. [compatiblity lib](https://crates.io/crates/tracing-opentelemetry)
        1. [tracing::`Span`](https://docs.rs/tracing/latest/tracing/#spans-1) -> [OpenTelemetry::`Span`](https://docs.rs/opentelemetry/latest/opentelemetry/trace/trait.Span.html)
        1. [tracing::`Event`](https://docs.rs/tracing/latest/tracing/event/struct.Event.html) -> [OpenTelemetry::`Event`](https://docs.rs/opentelemetry/latest/opentelemetry/trace/struct.Event.html)
    1. Differences:
        1. OpenTelemetry spans lack level


# Dependencies (Cargo.toml)
```toml
[dependencies]
opentelemetry = "..."
tracing = "..."
tracing-opentelemetry = "..."
tracing-subscriber = "..."
```


# [tracing](https://docs.rs/tracing/latest/tracing/) lib
1. Concepts
    1. Subscriber
1. TODO


# [opentelemetry](https://opentelemetry.io/docs/instrumentation/rust/) lib
1. [Concepts](../common/observability/tracing.md)

```
let tracer = ....

.with_tracer(tracer)
```


# Other resources
1. TODO
