# Overview
1. Idioms for frustration-free go channel pipelines 
    1. including [context](https://pkg.go.dev/context), error handling, timeouts, [OpenTelemetry](https://opentelemetry.io/docs/instrumentation/go/), etc.


# Idioms for frustration-free pipelines 
1. **Debugging** 
    1. See the [debugging](./concurrency.debug.md) guide
1. High-level Architecture
    1. One Source (first step/stage, streams data out to a channel)
    1. One Sink (last step/stage, consumes final results from a channel)
    1. Multiple intermediate processors connected via channels
    1. Everything running at the same time :-)
1. **Tools**
    1. Use [errgroup](https://pkg.go.dev/golang.org/x/sync/errgroup) (an Official library)
        1. ... because it gives you functionality like Kotlin's [coroutine scope](https://kotlinlang.org/api/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines/-coroutine-scope/)
            1. Otherwise, you must manage your own ~~[WaitGroups](https://pkg.go.dev/sync#WaitGroup)~~        
        1. ... because it propagates `error`s up to [`group.Wait()`](https://pkg.go.dev/golang.org/x/sync/errgroup#Group.Wait)
            1. Otherwise you must add `error` channels and `if` blocks or `select` blocks everywhere
        1. ... because it handles context [**cancellation**](./concurrency.cancellation.md) for the whole group of tasks
        1. ... because it handles [rate limiting](https://pkg.go.dev/golang.org/x/sync/errgroup#Group.SetLimit)
        1. ... because the source code is simple, correct, tested, well documented, recommended in several books 
            1. [like this](https://www.amazon.com/Mastering-Go-professional-utilities-concurrent/dp/1801079315) and [this](https://www.amazon.com/100-Mistakes-How-Avoid-Them/dp/1617299596/)
1. **Control**
    1. Make **one** control-flow-managing `func`
    1. Construct & setup the errGroup here
    1. Use [`g.Go(...)`](https://pkg.go.dev/golang.org/x/sync/errgroup#Group.Go) to start and to wait for subtasks
    1. See [example below](#example-subtask)
1. **Subtasks**
    1. See [example below](#example-subtask)
    1. Spawn tasks using [`g.Go(...)`](https://pkg.go.dev/golang.org/x/sync/errgroup#Group.Go), not [~~`go`~~](https://go.dev/ref/spec#Go_statements)
    1. The only counter-case is when you `Wait()` on the errGroup, like this:
        ```go
        go func() {  // <-- only time you must use 'go' keyword directly
            err := g.Wait()
            // ... either handle the error here, or call g.Wait() again outside this goroutine
            
            close(finalChannelWhichSinkReads)
        }()
        ```
    1. Most of your functions should be "regular" go functions 
        1. meaning they *neither* accept nor return a channel
        1. Counter-examples:
            1. functions that produce values **slowly** (meaning slow IO)
            1. functions that produce too many values to keep in memory
            1. These functions should accept the `outCh` and `errCh` as parameters (and return nothing)
1. **Context**
    1. Propagate the errGroup to subtasks using [`context.Context`](https://pkg.go.dev/context)    
    1. Pass `context` parameter into subtasks (not errGroup parameter)    
    1. Subtasks get the current errGroup from the `context` argument
        1. eg. `g := ErrGroupFromContext(ctx)`
    1. See [example below](#example-subtask)
1. **Channels** 
    1. Ensure every channel has a closing strategy
    1. Only Sender closes the channel (never the reader/consumer)
    1. Only `close` when completely done writing, use `defer`
    1. Use [buffering](https://gobyexample.com/channel-buffering) so channels aren't blocked and to avoid exhausting memory
1. **Waiting**
    1. Let [errgroup](https://pkg.go.dev/golang.org/x/sync/errgroup#Group.Wait) manage waiting for you
    1. Do **NOT** use your own ~~[WaitGroup](https://pkg.go.dev/sync#WaitGroup)~~,     
1. **Errors**
    1. Let the errGroup mange errors, just check `err := g.Wait()`
    1. you can call `err := g.Wait()` multiple times 
        1. Useful if you need to `Wait()` and handle errors in different goroutines
1. **Cancellation** 
    1. Let the errGroup manage cancellation
    1. You can [bind the errGroup to a context with a deadline](./concurrency.timeout.md)
1. **Tracing**
    1. Create spans inside, at the start of (some) subtasks     
    1. Use [`context.Context`](https://pkg.go.dev/context) to propagate [`SpanContext`](https://pkg.go.dev/go.opentelemetry.io/otel/trace#SpanContext)
    1. See [tracing doc](./tracing.md)
    1. See [example below](#example-subtask) 


# Example Subtask
```go
g.Go(func() error {

    // -- start a span (for tracing)
    ctx, span := otel.Tracer("").Start(ctx, "doSomethingInteresing")
    defer span.End()

    // -- sender (me) responsible for closing outCh channel
    defer close(outCh)
    
    // -- do a subtask, subtask might start sub-subtasks using g.Go(...)
    result, err := doASubtaskHere(ctx, arg1, arg2, ...)
    if err != nil {

        // -- add helpful messages for tracing errors to their source
        otzap.AddErrorEvent(span, "failed to doSomething because Foo", err)
        
        // -- propagate error thru errGroup (errGroup handles cancellation)
        return err
    }
    
    // -- send the subtask result
    outCh <- result
})
```


# Example: Propagate errGroup thru `context.Context`
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
     
    
# Example: Merge channels
```go
// MergeChannels consumes all input channels,
// merges messages into single output channel
//
// use ctx for timeout, cancellation, pipeline termination
func MergeChannels[T any](
    ctx context.Context,
    chs []<-chan T,        
    outCh chan<- T,
) {
    g := ErrGroupFromContext(ctx)

    taskCount := len(chs)
    done := make(chan struct{}, taskCount)

    for _, current := range chs {
        ch := current // exclusive ref
        g.Go(func() error {

            // -- consume channel
            for req := range ch {
                outCh <- req
            }

            done <- struct{}{}
            return nil
        })
    }

    // -- Cleanup
    g.Go(func() error {
        defer close(doneWriting)
        defer close(outCh)

        for i := 0; i < taskCount; i++ {
            <-done // wait for signal on each subtask
        }

        // -- Invariant: consumed all input channels
        return nil
    })
}
```


# Other Resources
1. https://go.dev/blog/pipelines
1. See [concurrency.debug.md](./concurrency.debug.md)
