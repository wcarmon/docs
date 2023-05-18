# Overview
1. Idioms for go channel pipelines 
    1. including context, error handling, timeouts, OpenTelemetry, etc.


# Idioms
1. One Source `func`
1. One Sink `func`
1. Multiple processor `func`s

# Source `func`
1. Accept ... 
    1. [`context.Context`](./context.md) argument
1. Return `(<-chan MyResult, error)` or just `<-chan MyResult`  
    1. Return `error` only when channel setup fails
    1. Message processing errors go into the `Result` (on output channel)     
1. `defer close` the returned/output channel
1. Only use [`ctx.Done`](https://pkg.go.dev/context#Context) to exit early (eg. cancellation, timeout, pipeline terminal errors)
1. Only use [buffering](TODO) on the output channel, (to avoid exhausting memory)
1. Tracing
    1. Start the [SpanContext](TODO)

# Sink `func`
1. Accept ... 
    1. [`context.Context`](./context.md) argument
    1. Exactly-one channel argument
    1. `maxParallel uint` argument
1. Return `(<-chan MyResult, error)` or just `<-chan MyResult`
    1. Return `error` only when channel setup fails
    1. Message processing errors go into the `Result` (on output channel)     
1. `defer close` the returned/output channel
1. Start at least one goroutine to consume the input channel (in a for loop)
    1. at most `maxParallel` goroutines
1. Only use [`ctx.Done`](https://pkg.go.dev/context#Context) to exit early (eg. cancellation, timeout, pipeline terminal errors)
1. Only use [buffering](TODO) on the output channel, (to avoid exhausting memory)
1. Tracing
    1. TODO ...


# Processor `func`s
1. Accept ... 
    1. [`context.Context`](./context.md) argument
    1. Exactly-one channel argument
    1. `maxParallel uint` argument
1. Return `(<-chan MyResult, error)` or just `<-chan MyResult`
    1. Return `error` only when channel setup fails
    1. Message processing errors go into the `Result` (on output channel)     
1. `defer close` the returned/output channel
1. Start at least one goroutine to consume the input channel (in a for loop)
    1. at most `maxParallel` goroutines
1. Only use [`ctx.Done`](https://pkg.go.dev/context#Context) to exit early (eg. cancellation, timeout, pipeline terminal errors)
1. Only use [buffering](TODO) on the output channel, (to avoid exhausting memory)
1. Tracing
    1. Get [`SpanContext`](https://pkg.go.dev/go.opentelemetry.io/otel/trace#SpanContext) in-band (from input messages on the channel, not from `ctx` argument)
    1. If you create a span, [Link](https://pkg.go.dev/go.opentelemetry.io/otel/trace#WithLinks) output messages to input message [SpanContext](https://pkg.go.dev/go.opentelemetry.io/otel/trace#SpanContext)
    1. End any spans you create (they have a link relationship, not parent-child)    
    1. If you don't create a span, just propagate [SpanContext](https://pkg.go.dev/go.opentelemetry.io/otel/trace#SpanContext) in the request [`context.Context`](https://pkg.go.dev/context#Context) to output messages

    
## Example merge Processor `func`
1. Useful for fan-in, fan-out across channels
```go
// MergeChannels consumes all input channels,
// merges messages into single output channel
//
// use ctx for timeout, cancellation, pipeline termination
// use outputBufSize=0 for unbuffered output ch
func MergeChannels[T any](
    ctx context.Context,
    chs []<-chan T,
    outputBufSize uint,
) <-chan T {

    wg := &sync.WaitGroup{}
    wg.Add(len(chs))

    out := make(chan T, outputBufSize)

    for _, current := range chs {
        ch := current // exclusive ref
        go func() {
            defer wg.Done()

            // -- Consume channel
            for req := range ch {
                select {
                case out <- req: // -- merge
                case <-ctx.Done(): // -- leave early
                    return
                }
            }
        }()
    }

    // -- Cleanup
    go func() {
        wg.Wait()
        // -- Invariant: consumed all input channels
        close(out)
    }()

    return out
}
```

1. Example usage of merge func
```go
	chs := []<-chan Foo{
		make(chan Foo),
		make(chan Foo),
		...		
    }

	mergedCh := MergeChannels(ctx, chs, 0)

	for foo := range mergedCh {
        ...use foo here...
	}
```


# Other resources
1. https://go.dev/blog/pipelines
