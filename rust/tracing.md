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


# Dependencies for library crate (Cargo.toml)
```toml
[dependencies]
opentelemetry-semantic-conventions = "..."
tracing = "..."
```


# Dependencies for binary crate (Cargo.toml)
```toml
[dependencies]
opentelemetry = "..."
opentelemetry-jaeger = "..."
opentelemetry-semantic-conventions = "..."

tracing = "..."
tracing-opentelemetry = "..."
tracing-subscriber = "..."
```


# [tracing](https://docs.rs/tracing/latest/tracing/) lib
1. Concepts
    1. Span: TODO
    1. [Event](https://docs.rs/tracing-core/0.1.30/tracing_core/struct.Event.html) struct: a log associated with a `Span`
    1. [Subscriber trait](https://docs.rs/tracing-core/0.1.30/tracing_core/subscriber/trait.Subscriber.html): TODO
        1. Subscriber responsible for associating spans with threads
    1. [Layer trait](https://docs.rs/tracing-subscriber/0.3.16/tracing_subscriber/layer/trait.Layer.html): TODO
1. Idiomatic rust
1. Compatible with [`Future`](https://doc.rust-lang.org/nightly/core/future/trait.Future.html)s, [example](https://docs.rs/tracing/latest/tracing/trait.Instrument.html)
1. Compatible with [tokio](https://tokio.rs/)
1. [Has convenient macros](https://docs.rs/tracing/latest/tracing/#macros)
1. Sometimes unintuitive
    1. eg. https://docs.rs/tracing-core/0.1.30/tracing_core/trait.Subscriber.html#tymethod.record 
1. Non-standard (compared to OpenTelemetry which works across coding languages)
1. Different [span lifecycle](https://docs.rs/tracing/latest/tracing/span/index.html#the-span-lifecycle) than [OpenTelemetry](TODO)
1. Includes thread attributes by default


# [OpenTelemetry](https://opentelemetry.io/docs/instrumentation/rust/) lib
1. See [otel doc](./tracing.opentelemetry.md)


## Setup (in binary crate)
```rust
use tracing_subscriber::layer::SubscriberExt;
...

// -- Build Tracers (OpenTelemetry concept)
let console_tracer = stdout::new_pipeline().install_simple();
let jaeger_tracer = opentelemetry_jaeger::new_agent_pipeline()
    .with_service_name("whatever-this-service-does")
    .install_simple() // use batch in prod
    .expect("failed to build jaeger tracer");

// -- Build OpenTelemetry Layers for tracing lib
let console_layer = tracing_opentelemetry::layer().with_tracer(console_tracer);
let jaeger_layer = tracing_opentelemetry::layer().with_tracer(jaeger_tracer);

// -- Add Layers to Subscriber (tracing lib concepts)
let subscriber = Registry::default()
    .with(console_layer)
    .with(jaeger_layer);

// -- Apply globally (tracing lib concept)
//    only in main.rs, never for a library
tracing::subscriber::set_global_default(subscriber);

```


## Span usage
```rust
    let span = span!(Level::INFO, "my_span"); // or better, info_span!("my_span");
    let guard = span.enter();
    
    // or: let span = span!(Level::INFO, "my_span").entered();

    span.record("foo", "bar");

    // auto associated with span
    info!("something happened"); // or warn!(...) or error!(...) or debug!(...)

    span.record("error", anyhow!("something went wrong").into());

    let current_span = Span::current(); // in case you didn't have a reference

    drop(guard); // or let it happen automatically
```


## Wrap a function in a Span
- not as flexible as code
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


# Attributes
## record extra span attributes (after span created)
- TODO: add attributes using record: https://docs.rs/tracing/latest/tracing/span/struct.Span.html#method.record
- TODO: must use `Empty`: https://docs.rs/tracing/latest/tracing/#recording-fields
- TODO: silent failure for attributes that aren't predefined


# Associating logs with spans, adding attributes
```rust
use tracing::{debug, error, info, info_span, warn};
...

let span = info_span!("do_something").entered();

...
debug!(message = "example debug msg", aa = 7);
info!(message = "example info msg", b = true);
warn!(message = "example warn log event", f = 3.2);
```

    
## Recording errors
1. https://opentelemetry.io/docs/reference/specification/trace/semantic_conventions/exceptions/#attributes
```
//TODO: simplify:
span.error = true
span.attr[exception].type = "..."
span.attr[exception.message] = "..."
span.attr[exception.stacktrace] = "..."
event.name = "exception"

status = ?
exception = ?

            let attributes = vec![KeyValue::new("exception.message", err.to_string())];
            self.add_event("exception", attributes);
```


# Other Resources
1. https://docs.rs/tracing-opentelemetry/latest/tracing_opentelemetry/
1. https://docs.rs/tracing/latest/tracing/
1. https://docs.rs/log/latest/log/
1. https://crates.io/crates/opentelemetry-jaeger


