# Overview
1. TODO
1. Data parallelism


# With Rayon
1. Works with tracing (propagates for Jaeger)
1. Uses [crossbeam::channel](https://docs.rs/crossbeam/latest/crossbeam/channel/index.html)
```rust
fn do_something_for_one_input(input: &Quux) -> Result<Foo, MyError> {
    // do something with the input, return result
}


fn wrap_in_parallel(inputs: &Vec<Quux>) -> Result<Vec<Foo>, MyError> {

    let parent = tracing::info_span!("some_nice_operation").entered();
    let parent_cx = parent.context();

    let (results_tx, results_rx) = crossbeam::channel::bounded(input.len());

    //TODO: do I need prelude
    rayon::scope(move |sc| {
        let parent_cx = parent_cx; // closure

        for input in inputs {
            let results_tx = results_tx.clone();
            let parent_cx = parent_cx.clone();

            sc.spawn(move |_| {
                let span = tracing::debug_span!("parallel_thread").entered();
                span.set_parent(parent_cx);
                
                let res = do_something_for_one_input(&input);

                results_tx.send(res).expect("should not fail on send")
            });
        }
    });

    let mut outputs = Vec::with_capacity(inputs.len());
    for results in results_rx {
        match results {
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
