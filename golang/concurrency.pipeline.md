# Overview
1. Idioms for go channel pipelines 
    1. including context, error handling, timeouts, OpenTelemetry, etc.


# Idioms for frustration-free pipelines 
1. See the [debugging](/home/wcarmon/git-repos/docs/golang/concurrency.debug.md) guide
1. Use One Source (streams data out to a channel)
1. Use One Sink (consumes final results from a channel)
1. Use multiple intermediate processors connected via channels
1. Use [errgroup](https://pkg.go.dev/golang.org/x/sync/errgroup) official library
    1. ...because it gives you functionality like [coroutine scope](https://kotlinlang.org/api/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines/-coroutine-scope/)
        1. Otherwise you need to manage your own [WaitGroups](TODO)        
    1. ...because it propagates errors up to the [`group.Wait()`](https://pkg.go.dev/golang.org/x/sync/errgroup#Group.Wait)
        1. Otherwise you need to add `error` channels and `if` blocks or `select` blocks everywhere
    1. ...because it handles context **cancellation** for the whole group of tasks
1. Spawn tasks using [`g.Go(...)`](https://pkg.go.dev/golang.org/x/sync/errgroup#Group.Go), not [~~`go`~~](https://go.dev/ref/spec#Go_statements)
    1. The only counter-case is when you `Wait()` on the errGroup, like this:
    ```go
    go func() {
        err := g.Wait()
        
        close(finalChannelWhichFeedsSink)
    }()
    ```
1. Make one control-flow-managing function
    1. Setup the errGroup
    1. use [`g.Go(...)`](https://pkg.go.dev/golang.org/x/sync/errgroup#Group.Go) to spawn and wait for subtasks
1. Most of your functions should be "regular" (meaning the don't produce nor accept channels)
    1. Counter-examples:
        1. functions that **slowly** produce values
        1. functions that produce too many values to keep in memory
        1. These functions should accept the `outCh` and `errCh` as parameters
1. **Context**: Propagate the errGroup to subtasks using [`context.Context`](https://pkg.go.dev/context)
    1. See example below
    1. Pass `context` parameter into subtasks (not errGroup parameter)    
    1. Subtasks can get the current errGroup from `context`
        1. eg. `g := ErrGroupFromContext(ctx)`
1. **Close**: Make sure every channel has a closing strategy
    1. Only Sender closes the channel
    1. Only close when completely done writing
1. **Waiting**: Do **NOT** use your own ~~[WaitGroup](https://pkg.go.dev/sync#WaitGroup)~~, let [errgroup](https://pkg.go.dev/golang.org/x/sync/errgroup#Group.Wait) manage waiting for you
1. **Errors**: Let the errGroup mange errors, just check `err := g.Wait()`
    1. you can call `err := g.Wait()` multiple times 
    1. Useful if you need to `Wait()` and handle errors in different goroutines
1. **Cancellation**: Let the errGroup manage cancellation
1. **Tracing**: Create spans



# Example of errGroup propagation thru [`context.Context`](https://pkg.go.dev/context)
```go

type errGroupContextKeyType int

const currentErrGroupKey errGroupContextKeyType = iota

// ErrGroupFromContext returns the errGroup associated with the context, or nil.
func ErrGroupFromContext(ctx context.Context) *errgroup.Group {
	if g, ok := ctx.Value(currentErrGroupKey).(*errgroup.Group); ok {
		return g
	}

	return nil
}

// WithErrGroup returns a new context containing the given errgroup.Group.
func WithErrGroup(parent context.Context, g *errgroup.Group) context.Context {
	return context.WithValue(parent, currentErrGroupKey, g)
}

// NewErrGroup simplifies linking the errGroup and context.
func NewErrGroup(parent context.Context) (*errgroup.Group, context.Context) {
	g, ctx := errgroup.WithContext(parent)
	return g, WithErrGroup(ctx, g)
}
```
     

# ======================----===----====


# Source `func`
1. Accept ... 
    1. [`context.Context`](./context.md) argument
1. Return `(<-chan MyResult, error)` or just `<-chan MyResult`  
    1. Return `error` only when channel setup fails
    1. Message processing errors go into the `Result` (on output channel)     
1. `defer close` the returned/output channel
1. Only use [`ctx.Done`](https://pkg.go.dev/context#Context) to exit early (eg. cancellation, timeout, pipeline terminal errors)
1. Only use [buffering](https://go.dev/tour/concurrency/3) on the output channel, (to avoid exhausting memory)
1. Tracing
    1. Start the [SpanContext](https://pkg.go.dev/go.opentelemetry.io/otel/trace#SpanContext)


# Sink `func`
1. Accept ... 
    1. [`context.Context`](./context.md) argument
    1. Exactly-one channel argument
    1. `maxParallel uint` argument
1. Return at most one result or just error
1. Start at least one goroutine to consume the input channel (in a for loop)
    1. at most `maxParallel` goroutines
1. Only use [`ctx.Done`](https://pkg.go.dev/context#Context) to exit early (eg. cancellation, timeout, pipeline terminal errors)
1. Tracing
    1. End any spans created internally 
    1. End any spans in the request context


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


# Debugging
1. See [concurrency.debug.md](./concurrency.debug.md)


# Other resources
1. https://go.dev/blog/pipelines
