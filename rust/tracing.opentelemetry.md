# Overview

1. Rust OpenTelemetry support (Using OpenTelemetry API directly)
1. See first: [tracing doc](./tracing.md)

# Summary of key ideas

1. Using the [tracing api](https://docs.rs/tracing/latest/tracing) is simpler and more idiomatic for rust
    1. See macro usage
    1. See span/context propagation, both single and multi-threaded
1. tracing api can forward spans to OpenTelemetry

# [OpenTelemetry](https://opentelemetry.io/docs/instrumentation/rust/) lib

1. [Concepts](../common/observability/tracing.md)
1. More verbose than [`tracing`](https://docs.rs/tracing/latest/tracing) lib
1. Requires passing [`Context`](https://docs.rs/opentelemetry/latest/opentelemetry/struct.Context.html) manually to propagate spans

## Span usage (OpenTelemetry)

```rust
    let mut span = tracer.span_builder("doSomeOperation")
        .start(&tracer);

    // ...

    let parent_ctx = Context::current_with_span(tracer("").start("do_parent_stuff"));
    let parent_span = parent_ctx.span();

    parent_span.set_attribute(KeyValue::new("foo", true));

    // -- maybe a fn boundary here: pass &parent_ctx
    let mut child_ctx =
        Context::current_with_span(tracer("").start_with_context("do_child_stuff", &parent_ctx));
    let child_span = child_ctx.span();

    child_span.set_attribute(KeyValue::new("foo", 1));
    child_span.add_event("something happened", vec![]); // log
    
    parent_span.set_attribute(KeyValue::new("foo", 2));


    // -- Error reporting requires a few steps
    child_span.record_error(&anyhow!("boom").into());
    child_span.set_attribute(KeyValue::new("error", true));    
    child_span.end(); // YES, this is necessary


    //TODO: how to associate logs via log!(...) macros

    span.end(); // or drop(span) or let it happen automatically
```

# Other resources

1. https://docs.rs/opentelemetry/
1. https://opentelemetry.io/
1. https://docs.rs/opentelemetry/latest/opentelemetry/
1. https://opentelemetry.io/docs/instrumentation/go/getting-started/
1. https://opentelemetry.io/docs/instrumentation/rust/
