# Overview
1. How to handle cancellation
1. See also [context](./context.md) doc


# Key Concepts
1. Use [`context`](./context.md) for cancellation
1. [Parent `context` cancels children](https://cs.opensource.google/go/go/+/refs/tags/go1.18.3:src/context/context.go;l=16) (Propagation)
    1. child `context` does **NOT** cancel parent `context`
    1. eg. `context.Background()` is never cancelled
1. HTTP Server: [automatically cancels](https://pkg.go.dev/net/http#Request.Context) context when connection closed
1. HTTP Client: Use [`http.NewRequestWithContext`](https://pkg.go.dev/net/http#NewRequestWithContext) or [`req.WithContext`](https://pkg.go.dev/net/http#Request.WithContext) to handle cancellation
1. Cancellation is cooperative, cancellation does **NOT** kill a goroutine
1. `go vet` [checks that CancelFuncs](https://pkg.go.dev/cmd/vet#pkg-overview) are used on all control-flow paths.


# Idioms
1. Call `cancel()` func in `defer` statement
1. Always call `cancel()` func returned by [`WithDeadline`](https://pkg.go.dev/context#WithDeadline) or [`WithCancel`](https://pkg.go.dev/context#WithCancel)


# Examples

## Example: Cancel manually
```go
func foo() {
    parentCtx := context.Background()
    ...

    ctx, cancel = context.WithCancel(parentCtx) // context.WithDeadline is similar
    defer cancel() // Guarantee child cancellation

    // pass ctx to another func or use below
    // (eg. pass to http client, grpc client, sql client, kafka, rabbitmq client, ...)
}
```

## Example: Listen for cancellation (Cancel aware task)
1. To handle cancellation, timeout, deadline expiration:
```go
type FooResult int // or a struct with both result & error

func DoSomeExpensiveIO(ctx context.Context) (FooResult, error) {

    // result of "real" call goes into channel
    // sender not blocked since buffer is 1
    resultCh := make(chan FooResult, 1)

    go func() {
        // send returned result to channel
        resultCh <- doRealIOWork()

        // -- alternative: func writes result to channel (instead of returning)
        // doRealIOWork(resultCh)
    }()

    // wait for first of [a result] or [cancellation/timeout]
    select {
    case <-ctx.Done():
        return 0, ctx.Err()

    case out := <-resultCh:
        return out, nil
    }
}
```


# Other Resources
1. https://go.dev/doc/database/cancel-operations
1. https://www.prakharsrivastav.com/posts/golang-context-and-cancellation/
1. https://www.sohamkamani.com/golang/context-cancellation-and-values/
1. https://medium.com/a-journey-with-go/go-context-and-cancellation-by-propagation-7a808bbc889c
