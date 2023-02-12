# Overview
1. TODO
1. Data parallelism


# With Rayon
1. Works with tracing (propagates for Jaeger)
1. Uses [crossbeam::channel](https://docs.rs/crossbeam/latest/crossbeam/channel/index.html)
```rust
// -- Required for span.context() and span.set_parent(...)
use tracing_opentelemetry::OpenTelemetrySpanExt;


fn do_something_for_one_input(input: &Quux) -> Result<Foo, MyError> {
    // do something with the input, return result
}


fn wrap_in_parallel(inputs: &Vec<Quux>) -> Result<Vec<Foo>, MyError> {

    let parent = tracing::info_span!("some_nice_operation").entered();

    // -- For Span::context, See: https://docs.rs/tracing-opentelemetry/latest/tracing_opentelemetry/trait.OpenTelemetrySpanExt.html#tymethod.context
    // -- For opentelemetry::Context, See: https://docs.rs/opentelemetry/latest/opentelemetry/struct.Context.html
    // --       opentelemetry::Context wraps a Map<u64, Arc<Send+Sync>>
    let parent_cx = parent.context();

    let (results_tx, results_rx) = crossbeam::channel::bounded(inputs.len());

    rayon::scope(move |sc| {
        let parent_cx = parent_cx; // closure

        for input in inputs {
            let results_tx = results_tx.clone();
            let parent_cx = parent_cx.clone();

            sc.spawn(move |_| {
                let span = debug_span!("parallel_thread").entered();

                // -- See https://docs.rs/tracing-opentelemetry/latest/tracing_opentelemetry/trait.OpenTelemetrySpanExt.html#tymethod.set_parent
                span.set_parent(parent_cx);

                let res = do_something_for_one_input(&input);

                results_tx.send(res).expect("should not fail on send")
            });
        }
    });

    let mut outputs = Vec::with_capacity(inputs.len());
    for result in results_rx {
        match result {
            Ok(value) => outputs.push(value),
            Err(e) => {
                error!("failed to load ... ref: {e:?}");
                return Err(e);
            }
        }
    }

    Ok(outputs)
}
```


# Other Resources
1. https://rust-lang-nursery.github.io/rust-cookbook/concurrency/parallel.html
