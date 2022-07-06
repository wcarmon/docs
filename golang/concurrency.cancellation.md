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


# Idioms
1. Always call `cancel()` in `defer` statement
1. Always call `cancel()` func returned by [`WithDeadline`](https://pkg.go.dev/context#WithDeadline) or [`WithCancel`](https://pkg.go.dev/context#WithCancel)


# Examples

## Example: Cancel manually
```go
func foo() {
    ...
    parentCtx := context.Background()

    ctx, cancel = context.WithCancel(parentCtx)
    defer cancel() // Guarantee child cancellation

    // pass ctx to another func, or use with another pattern below
    // (eg. pass to http client, grpc client, sql client, kafka, rabbitmq, ...)
}
```

## Example: Listen for cancellation (Cancel aware task)
1. To handle cancellation, timeout, deadline expiration:
```go
type FooResult int // or a struct with both result & error

func DoSomeExpensiveIO(ctx context.Context) (FooResult, error) {

	// result of "real" call goes into channel
	// sender not blocked since buffer is 1
	resultChan := make(chan FooResult, 1)

	go func() {
		// send returned result to channel
		resultChan <- doRealIOWork()

		// -- alternative: func writes result to channel (instead of returning)
		// doRealIOWork(resultChan)
	}()

	// wait for first of [a result] or [cancellation/timeout]
	select {
	case <-ctx.Done():
		return 0, ctx.Err()

	case out := <-resultChan:
		return out, nil
	}
}
```


# Other resources
1. TODO
