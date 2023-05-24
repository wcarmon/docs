# Overview
1. Idioms for go channel pipelines 
    1. including context, error handling, timeouts, OpenTelemetry, etc.


# Idioms for frustration-free pipelines 
1. **Debugging**: 
    1. See the [debugging](/home/wcarmon/git-repos/docs/golang/concurrency.debug.md) guide
1. High level Architecture:
    1. Use One Source (streams data out to a channel)
    1. Use One Sink (consumes final results from a channel)
    1. Use multiple intermediate processors connected via channels
1. **Tools**:
    1. Use [errgroup](https://pkg.go.dev/golang.org/x/sync/errgroup) official library
        1. ...because it gives you functionality like [coroutine scope](https://kotlinlang.org/api/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines/-coroutine-scope/)
            1. Otherwise you need to manage your own [WaitGroups](https://pkg.go.dev/sync#WaitGroup)        
        1. ...because it propagates errors up to the [`group.Wait()`](https://pkg.go.dev/golang.org/x/sync/errgroup#Group.Wait)
            1. Otherwise you need to add `error` channels and `if` blocks or `select` blocks everywhere
        1. ...because it handles context **cancellation** for the whole group of tasks
        1. ...because it handles [rate limiting](https://pkg.go.dev/golang.org/x/sync/errgroup#Group.SetLimit)
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
1. **Context**: 
    1. Propagate the errGroup to subtasks using [`context.Context`](https://pkg.go.dev/context)
    1. See example below
    1. Pass `context` parameter into subtasks (not errGroup parameter)    
    1. Subtasks can get the current errGroup from `context`
        1. eg. `g := ErrGroupFromContext(ctx)`
1. **Channels**: 
    1. Ensure every channel has a closing strategy
    1. Only Sender closes the channel
    1. Only close when completely done writing
    1. Use [buffering](https://gobyexample.com/channel-buffering) so channels aren't blocked and to avoid exhausting memory
1. **Waiting**: 
    1. Let [errgroup](https://pkg.go.dev/golang.org/x/sync/errgroup#Group.Wait) manage waiting for you
    1. Do **NOT** use your own ~~[WaitGroup](https://pkg.go.dev/sync#WaitGroup)~~,     
1. **Errors**: 
    1. Let the errGroup mange errors, just check `err := g.Wait()`
    1. you can call `err := g.Wait()` multiple times 
    1. Useful if you need to `Wait()` and handle errors in different goroutines
1. **Cancellation**: 
    1. Let the errGroup manage cancellation
1. **Tracing**:
    1. Create spans inside, at the start of (some) subtasks 
    1. See [tracing doc](./tracing.md)
    1. Use [`context.Context`](https://pkg.go.dev/context) to propagate [`SpanContext`](https://pkg.go.dev/go.opentelemetry.io/otel/trace#SpanContext) 


# Example Subtask
```go
g.Go(func() error {
    // -- Start a span (for tracing)
    ctx, span := otel.Tracer("").Start(ctx, "doSomething")
    defer span.End()

    // -- sender responsible for closing channel
    defer close(outCh)
    
    // -- do a subtask, subtask might start sub-subtasks using g.Go(...)
    result, err := doSomething(ctx, arg1, arg2)
    if err != nil {
        // -- add helpful messages for tracing errors to their source
        otzap.AddErrorEvent(span, "failed to doSomething because Foo", err)
        
        // -- propagate error thru errGroup (group will handle cancellation)
        return err
    }
    
    // -- send the subtask result out on some channel
    outCh <- result
})
```


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

    
## Example func to Merge channels
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
	outCh chan<- T,
) {
	g := ErrGroupFromContext(ctx)

	taskCount := len(chs)
	doneWriting := make(chan struct{}, taskCount)

	for _, current := range chs {
		ch := current // exclusive ref
		g.Go(func() error {

			// -- consume channel
			for req := range ch {
				outCh <- req
			}

			doneWriting <- struct{}{}
			return nil
		})
	}

	// -- Cleanup
	g.Go(func() error {
		defer close(doneWriting)
        defer close(outCh)

		for i := 0; i < taskCount; i++ {
			<-doneWriting // one for each subtask
		}

		// -- Invariant: consumed all input channels
		return nil
	})
}
```


# Other resources
1. https://go.dev/blog/pipelines
1. See [concurrency.debug.md](./concurrency.debug.md)
