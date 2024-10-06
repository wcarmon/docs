# Overview

1. Idioms for [Tracing](https://opentelemetry.io/docs/concepts/signals/traces/) (and associated Logging)
1. How to use [tracing](https://docs.rs/tracing/latest/tracing/) and [OpenTelemetry](https://opentelemetry.io/docs/instrumentation/rust/)

# Setup
- [`Cargo.toml`, initialization, etc](./tracing.setup.md)


# Summary of key ideas

1. [tracing](https://docs.rs/tracing/latest/tracing) lib handles both tracing and [logging](./logging.md)
    1. [Migration from log lib](https://docs.rs/tracing/latest/tracing/#for-log-users)
    1. [Migration from slog](https://github.com/slog-rs/slog#slog-rs---the-logging-for-rust)
1. [tracing](https://docs.rs/tracing/latest/tracing) API is close enough to OpenTelemetry
    1. [Compatibility lib](https://crates.io/crates/tracing-opentelemetry)
        1. [tracing::`Span`](https://docs.rs/tracing/latest/tracing/struct.Span.html) -> [OpenTelemetry::`Span`](https://docs.rs/opentelemetry/latest/opentelemetry/trace/trait.Span.html)
        1. [tracing::`Event`](https://docs.rs/tracing/latest/tracing/event/struct.Event.html) -> [OpenTelemetry::`Event`](https://docs.rs/opentelemetry/latest/opentelemetry/trace/struct.Event.html)
    1. Differences:
        1. OpenTelemetry spans lack level


# Gotchas
1. Performance overhead for instrumentation
1. Performance overhead for reporting spans over the network (or even local disk IO
1. OpenTelemetry regularly breaks semver guarantees
1. OpenTelemetry libs can version lock you into old dependencies
1. Types & traits with the same name in different packages (designed for frustration/confusion)
1. Jaeger UI didn't support auth
1. Jaeger: Sustainable external storage is either very complex or expensive (Cassandra, Elastic, ...)
1. Correct internal Propagation is hard (async, threads, ...)
1. Propagation at servers and clients is hard


# [tracing](https://docs.rs/tracing/latest/tracing/) lib (part of Tokio)

1. Concepts
    1. Span: TODO
    1. [Event](https://docs.rs/tracing-core/0.1.30/tracing_core/struct.Event.html) struct: a log associated with a `Span`
    1. [Subscriber trait](https://docs.rs/tracing-core/0.1.30/tracing_core/subscriber/trait.Subscriber.html): TODO
        1. Subscriber responsible for associating spans with threads
    1. [Layer trait](https://docs.rs/tracing-subscriber/0.3.16/tracing_subscriber/layer/trait.Layer.html): TODO
1. `Pro`: Uses idiomatic rust
1. `Pro`: Compatible with [`Future`](https://doc.rust-lang.org/nightly/core/future/trait.Future.html)s, [example](https://docs.rs/tracing/latest/tracing/trait.Instrument.html)
1. `Pro`: Compatible with [tokio](https://tokio.rs/)
1. `Pro`: [Has convenient macros](https://docs.rs/tracing/latest/tracing/#macros)
1. `Pro`: Includes thread attributes by default
1. `Cons`: Sometimes unintuitive
    1. eg. https://docs.rs/tracing-core/0.1.30/tracing_core/trait.Subscriber.html#tymethod.record
1. `Cons`: Non-standard when compared to OpenTelemetry usage in other coding languages
1. `Cons`: Different [span lifecycle](https://docs.rs/tracing/latest/tracing/span/index.html#the-span-lifecycle) than [OpenTelemetry](TODO)


# Setup `tracing`

- See [setup doc](./tracing.setup.md)

# Usage

```rust
use tracing::{instrument, Span};
...

    let span = info_span!("my_span");
    let guard = span.enter();

    /* -- alternative:
        let span = info_span!("my_span").entered();
        defer! { drop(span) }  // See https://github.com/rodrigocfd/defer-lite/
    */

    // let _ = info_span!(...) // GOTCHA: DON'T DO THIS, immediately drops your span, so the hierarchy breaks

    span.record("foo", "bar"); // must be defined in the span macro

    // auto associated with span
    info!("something happened"); // or warn!(...) or error!(...) or debug!(...)

    span.record("error", anyhow!("something went wrong").into());

    // If required, reference the current span (last entered span on this thread):
    // tracing::Span::current()
    let current_span = Span::current();

    // manually set parent span
    //TODO: verify
    let _ = info_span!(parent: span.id(), "foo_bar");

    // -- Either drop or use https://github.com/rodrigocfd/defer-lite/
    // drop(guard); // if you don't drop, rustc might drop your span early
```

1. See https://docs.rs/tracing/latest/tracing/macro.span.html

## Wrap a function in a Span

1. Not as flexible as code, but often convenient
1. See https://docs.rs/tracing/latest/tracing/attr.instrument.html

```rust
use tracing_attributes::instrument;
...


#[instrument]
fn do_something(foo: &str) -> Result<String, anyhow::Error> {

    // these are automatically associated with the span
    debug!(aa = 7, "not that important");
    info!("interesting");
    warn!("hm...");
    error!("ooh no!");

    //GOTCHA: attributes/fields must be declared in the attribute

    Ok("output".to_owned())
}

#[instrument(err)]
fn do_something_dangerous() -> Result<String, anyhow::Error> {
    todo!("boo")
}
```

# Attributes

## record extra span attributes (after span created)

1. 32 fields/attributes max
    1. Standard fields/attributes: https://opentelemetry.io/docs/specs/semconv/attributes-registry/http/

- TODO: add attributes using record: https://docs.rs/tracing/latest/tracing/span/struct.Span.html#method.record
- TODO: must use `tracing::field::Empty`: https://docs.rs/tracing/latest/tracing/#recording-fields
- TODO: silent failure for attributes that aren't predefined

# Get current span

```rust
info_span!("...", foo = tracing::field::Empty).entered();  // not .enter()
// allocate field `foo`, so we can set later
...

Span::current().record("foo", 88); // record field previously allocated
```

# Set current span

```rust
let _ = span.entered();

// ... do some work

// _ is dropped at the end
```

# Associating logs with spans, adding attributes

```rust
use tracing::{debug, error, info, info_span, warn};
...

let span = info_span!("do_something").entered();

...
// attributes do NOT need to be declared on span first
debug!(message = "example debug msg", aa = 7);
info!(message = "example info msg", b = true);
warn!(message = "example warn log event", f = 3.2);

error!("ooh no!");  // This marks span as error (in Jaeger too)

// -- or put the message last
info!(cc = "cheese", "something happened");
info!(dd = %foo1, "whatever") // use fmt::Display
info!(ee = ?foo2, "something") // use fmt::Debug
```

1. `?` sigil prefix means record with [`fmt::Debug`](https://doc.rust-lang.org/nightly/core/fmt/trait.Debug.html)
1. `%` prefix means record with [`fmt::Display`](https://doc.rust-lang.org/nightly/core/fmt/trait.Display.html)

## Recording errors

```
error!(err = ?some_err, "failed to ...")
```

1. See also https://docs.rs/tracing/latest/tracing/index.html#recording-fields
1. See also: https://opentelemetry.io/docs/reference/specification/trace/semantic_conventions/exceptions/#attributes

# Propagation: HTTP client

1. TODO

# Propagation: HTTP server

1. TODO

# Reporting delay in main fn

1. Add a brief delay at the end of your program to report any outstanding spans

```rust
root_span.exit();

// -- Give the last span time to report to Jaeger
//sleep(Duration::from_millis(300));
opentelemetry::global::shutdown_tracer_provider();
```

# Propagation (child function within process)

1. Single-threaded: This is automatic
1. Multi-threaded: (see below)

## Example propagating span across threads

1. tokio::tracing [relies on thread-local](https://github.com/tokio-rs/tracing/blob/master/tracing-subscriber/src/registry/sharded.rs#L94), so we must manually propagate the span

```rust
use tracing_opentelemetry::OpenTelemetrySpanExt;
...

fn outer() -> Result<(), anyhow::Error> {
    let parent = info_span!("outer-fn").entered();
    let parent_cx = parent.context();

    for i in 0..3 {
        let parent_cx = parent_cx.clone();

        thread::spawn(move || {
            let inner = info_span!("inner-fn", the_index = i).entered();
            inner.set_parent(parent_cx); // link to parent
        })
        .join()
        .expect("failed to join");
    }

    Ok(())
}
```

# Flow from source to jaeger

1. [`::`](TODO)
1. [`tracing::dispatcher::get_default(...)`](https://docs.rs/tracing/latest/tracing/dispatcher/fn.get_default.html) ([src in `tracing-core`](https://github.com/tokio-rs/tracing/blob/master/tracing-core/src/dispatch.rs#L414))
1. [`tracing::Span::new(...)`](https://docs.rs/tracing/latest/tracing/struct.Span.html#method.new) ([src in`tracing`](https://github.com/tokio-rs/tracing/blob/master/tracing/src/span.rs#L427))
1. `tracing::Span::new_with(...)` ([src in `tracing`](https://github.com/tokio-rs/tracing/blob/master/tracing/src/span.rs#L433))
1. [`tracing::Dispatch::new_span(...)`](https://docs.rs/tracing/latest/tracing/struct.Dispatch.html#method.new_span) ([src in `tracing-core`](https://github.com/tokio-rs/tracing/blob/tracing-subscriber-0.3.16/tracing-core/src/dispatcher.rs#L532))
    1. thin wrapper around [`Subscriber`](https://docs.rs/tracing/latest/tracing/subscriber/trait.Subscriber.html)
    1. returns new [`tracing::Id`](TODO)
1. [`Subscriber::new_span(...)`](https://docs.rs/tracing/latest/tracing/trait.Subscriber.html#tymethod.new_span) ([src in`tracing-core`](https://github.com/tokio-rs/tracing/blob/tracing-subscriber-0.3.16/tracing-core/src/subscriber.rs#L807))
    1. seems like they are renaming to "Collector"
1. `Layered::new_span(...)` as [`Subscriber`](https://docs.rs/tracing/latest/tracing/subscriber/trait.Subscriber.html) ([src in `tracing-subscriber`](https://github.com/tokio-rs/tracing/blob/master/tracing-subscriber/src/subscribe/layered.rs#L126))
1. [`Registry::new_span(...)`](https://docs.rs/tracing-subscriber/latest/tracing_subscriber/registry/struct.Registry.html) as [`Subscriber`](https://docs.rs/tracing/latest/tracing/subscriber/trait.Subscriber.html) ([src in `tracing-subscriber`](https://github.com/tokio-rs/tracing/blob/master/tracing-subscriber/src/registry/sharded.rs#L237))
    1. Checks for parent
    1. Ensures local span ids are unique
1. [`OpenTelemetryLayer::on_new_span(...)`](https://docs.rs/tracing-subscriber/latest/tracing_subscriber/layer/trait.Layer.html#method.on_new_span) as [`Layer`](https://docs.rs/tracing-subscriber/latest/tracing_subscriber/layer/trait.Layer.html) ([src in `tracing-opentelemetry`](TODO))
    1. checks parent context for active span
    1. stores extra data in [span extension](https://opentelemetry.io/docs/instrumentation/java/extensions/) (mutates extensions)
1. [`SimpleSpanProcessor::on_end(...)`](https://docs.rs/opentelemetry/latest/opentelemetry/sdk/trace/struct.SimpleSpanProcessor.html#method.on_end) as [`SimpleSpanProcessor`](https://docs.rs/opentelemetry/latest/opentelemetry/sdk/trace/trait.SpanProcessor.html) ([src in `opentelemetry_sdk`](https://github.com/open-telemetry/opentelemetry-rust/blob/v0.18.0/opentelemetry-sdk/src/trace/span_processor.rs#L143))
1. [`SimpleSpanProcessor`](TODO) [`crossbeam_channel`](https://docs.rs/crossbeam-channel/latest/crossbeam_channel/) with [`SpanData`](TODO)
    1. [`BatchSpanProcessor`](TODO) is similar
1. [`Exporter::export`](TODO) as [`trace::SpanExporter`](TODO)
1. [`convert_otel_span_into_jaeger_span(...)`](TODO)  ([src in `opentelemetry-jaeger`](TODO))
1. [`Uploader::upload(jaeger::Batch)`](TODO) ([src in `opentelemetry-jaeger`](TODO))


# TODO/Unorganized
- Env vars
    - `RUST_LOG=debug|info|warn|trace`
    - `RUSTFLAGS=--cfg tokio_unstable`

# Other Resources

1. https://docs.rs/tracing-opentelemetry/latest/tracing_opentelemetry/
1. https://docs.rs/tracing/latest/tracing/
1. https://docs.rs/log/latest/log/
1. https://crates.io/crates/opentelemetry-jaeger


