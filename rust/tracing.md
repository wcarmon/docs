# Overview
1. Idioms for [Tracing](https://opentelemetry.io/docs/concepts/signals/traces/) (and associated Logging)
1. How to use [tracing](https://docs.rs/tracing/latest/tracing/) and [OpenTelemetry](https://opentelemetry.io/docs/instrumentation/rust/)


# Summary of key ideas
1. [tracing](https://docs.rs/tracing/latest/tracing) lib handles both tracing and [logging](./logging.md)
    1. [Migration from log lib](https://docs.rs/tracing/latest/tracing/#for-log-users)
    1. [Migration from slog](https://github.com/slog-rs/slog#slog-rs---the-logging-for-rust)
1. [tracing](https://docs.rs/tracing/latest/tracing) API is close enough to OpenTelemetry
    1. [Compatiblity lib](https://crates.io/crates/tracing-opentelemetry)
        1. [tracing::`Span`](https://docs.rs/tracing/latest/tracing/struct.Span.html) -> [OpenTelemetry::`Span`](https://docs.rs/opentelemetry/latest/opentelemetry/trace/trait.Span.html)
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
    1. Span: TODO
    1. Event: TODO
    1. Subscriber: TODO
    1. Layer: TODO


# [OpenTelemetry](https://opentelemetry.io/docs/instrumentation/rust/) lib
1. [Concepts](../common/observability/tracing.md)


## Setup
```rust
    // -- Build Tracers (OpenTelemetry concept)
    let tracer0 = stdout::new_pipeline().install_simple();
    let tracer1 = opentelemetry_jaeger::new_agent_pipeline()
        .with_service_name("whatever-this-service-does")
        .install_simple() // use batch in prod
        .expect("failed to build jaeger tracer");

    // -- Build OpenTelemetry Layers
    let layer0 = tracing_opentelemetry::layer().with_tracer(tracer0);
    let layer1 = tracing_opentelemetry::layer().with_tracer(tracer1);

    // -- Add Layers to Subscriber (tracing lib concepts)
    let subscriber = Registry::default()
        .with(layer0)
        .with(layer1);

    // -- Apply globally (tracing lib concept)
    //    only in main.rs, never for a library
    tracing::subscriber::set_global_default(subscriber);

    ...
```


## Span usage (tracing lib)
```rust
    let span = span!(Level::INFO, "my_span"); // or info_span!("my_span");
    let guard = span.enter();

    span.record("foo", "bar");

    // auto associated with span
    info!("something happened"); // or warn!(...) or error!(...) or debug!(...)

    span.record("error", anyhow!("something went wrong").into());

    drop(guard); // or let it happen automatically
```


## Wrap a function in a Span (tracing lib)
```rust
    #[tracing::instrument]
    fn do_something(foo: &str) -> anyhow::Result<String> {

        // these are automatically associated with the span
        debug!(aa = 7, "not that important");
        info!("interesting");
        warn!("hm...");
        error!("ooh no!");

        //GOTCHA: you cannot add span attributes/fields (unless you make child span)

        Ok("output".to_owned())
    }
```


## Span usage (OpenTelemetry)
```rust
    let mut span = tracer.span_builder("doSomeOperation")
        .start(&tracer);

    // ...

    span.set_attribute(KeyValue::new("foo", "bar"));

    span.add_event("something happened", vec![]); // log

    span.record_error(&anyhow!("boom").into());

    //TODO: how to associate logs via log!(...) macros

    // ...

    span.end(); // or drop(span) or let it happen automatically
```


# Other resources
1. https://docs.rs/opentelemetry/latest/opentelemetry/
1. https://docs.rs/tracing-opentelemetry/latest/tracing_opentelemetry/
1. https://docs.rs/tracing/latest/tracing/
1. https://opentelemetry.io/docs/instrumentation/go/getting-started/
1. https://opentelemetry.io/docs/instrumentation/rust/
1. https://docs.rs/log/latest/log/
1. https://crates.io/crates/opentelemetry-jaeger


