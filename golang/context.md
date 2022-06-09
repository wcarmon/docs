# Overview
1. How to use [context](https://pkg.go.dev/context)


# Key Concepts
1. Context is thread-safe *(safe for simultaneous use by multiple goroutines)*
1. Contexts have a parent/child relationship
    1. [Parent cancels children](https://cs.opensource.google/go/go/+/refs/tags/go1.18.3:src/context/context.go;l=16) (Propagation)
    1. [Parent keeps references to children](https://cs.opensource.google/go/go/+/refs/tags/go1.18.3:src/context/context.go;l=347)
1. [`context.Background()`](https://pkg.go.dev/context#Background)
    1. Is the root of any Context tree
    1. [no values, no deadline, never cancelled](https://pkg.go.dev/context#Background)
    1. Is the [zero value](https://go.dev/ref/spec#The_zero_value) of a context

## Purpose 1
1. Context is for [cancellation](./concurrency.cancellation.md) (Both emitting and listening)
1. Context is for Deadlines/Timeouts (even across API boundaries)
    1. [`ctx.Deadline()`](https://pkg.go.dev/context#Context) is useful for setting I/O timeouts
1. [`ctx.Done()`](https://pkg.go.dev/context#Context) `channel` is closed after a timeout or when manually closed (see examples below)
1. [`ctx.Err()`](https://pkg.go.dev/context#Context) has the reason why `ctx.Done()` is closed
1. [`ctx.Deadline()`](https://pkg.go.dev/context#Context) returns the deadline, (when present)
1. [`WithDeadline`](https://pkg.go.dev/context#WithDeadline) and [`ctx.WithCancel`](https://pkg.go.dev/context#WithCancel) return a [CancelFunc](https://pkg.go.dev/context#CancelFunc)
    1. Invoking the [CancelFunc](https://pkg.go.dev/context#CancelFunc) is the **only** way to manually cancel a context
    1. Context can only be cancelled at-most-once
    1. `context.WithDeadline(...)` can return a ctx with an **EARLIER** deadline (when parent expires earlier)

## Purpose 2
1. Context is for "small" request-scoped data
    1. [RequestId](https://pkg.go.dev/github.com/go-chi/chi/middleware#RequestID) (helps with tracing/debugging)
    1. UserUuid/UserId for Authenticated user
    1. TraceId/SpanId ([OpenTelemetry](./tracing.md), [OpenTracing](./tracing.md), ...)
1. Data you add to Context **MUST BE** safe for simultaneous use by multiple goroutines
    1. This is another reason to use immutable IDs
1. [`ctx.Value(...)`](https://pkg.go.dev/context#Context) and [`context.WithValue`](https://pkg.go.dev/context#WithValue) help get & set request-scoped values


# Idioms
1. Context is safe for simultaneous use by multiple goroutines
1. Context is the first argument, named `ctx`
1. Every `func` on the path between incoming and outgoing request accepts `ctx` as 1st argument
1. Always set a deadline for calling external systems (eg. database, http, grpc, kafka, ...)
1. Prefer [`context.WithDeadline`](https://pkg.go.dev/context#WithDeadline) to [~~`context.WithTimeout`~~](https://pkg.go.dev/context#WithTimeout)
    1. [`WithTimeout`](https://cs.opensource.google/go/go/+/refs/tags/go1.18.3:src/context/context.go;l=506) hard-codes [`time.Now()`](https://cs.opensource.google/go/go/+/refs/tags/go1.18.3:src/context/context.go;l=507), makes testing harder (eg. cannot inject clock)
    1. `WithTimeout` is just a wrapper around `WithDeadline`
1. Pass `ctx` to sql calls (So deadline/timeout/cancellation works)
    1. [`conn.PingContext`](https://pkg.go.dev/database/sql#Conn.PingContext)
    1. [`conn.PrepareContext`](https://pkg.go.dev/database/sql#Conn.PrepareContext)
    1. [`conn.QueryContext`](https://pkg.go.dev/database/sql#Conn.QueryContext)
    1. [`stmt.ExecContext`](https://pkg.go.dev/database/sql#Stmt.ExecContext)
    1. [`stmt.QueryContext`](https://pkg.go.dev/database/sql#Stmt.QueryContext)
    1. [`stmt.QueryRowContext`](https://pkg.go.dev/database/sql#Stmt.QueryRowContext)
1. `context.Value()` is **not** a replacement for func arguments
1. [Do **NOT** pass `nil` context](https://pkg.go.dev/context#pkg-overview)
    1. [Stated repeatedly in official docs](https://pkg.go.dev/context#WithValue)
1. Contexts are "mostly" immutable
    1. Only `ctx.Done` `channel` contents can change
    1. Context methods return a copy


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


## Example: Set Timeout
1. Example without hard-coding clock:
```go
func ShowTimeoutUsage(
	ctx context.Context,
	clock func() time.Time,
	timeout time.Duration) {

	childCtx, cancel := context.WithDeadline(
		ctx,
		clock().Add(timeout))
	defer cancel()

	r, err := DoSomeExpensiveIO(childCtx)
	...
}
```
1. [Official example](https://pkg.go.dev/context#example-WithTimeout) (hard-codes `time.Now()`)


## Example: Set Deadline
1. [Official example](https://pkg.go.dev/context#example-WithDeadline)


## Example: Cancel aware task
1. handles cancellation, timeout, deadline expiration
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


## Example: Request-scoped ID
1. [TraceId](https://pkg.go.dev/go.opentelemetry.io/otel/trace#TraceID)/[SpanID](https://pkg.go.dev/go.opentelemetry.io/otel/trace#SpanID) for [OpenTelemetry](https://opentelemetry.io/docs/instrumentation/go/) or [OpenTracing](https://pkg.go.dev/github.com/opentracing/opentracing-go) work the same way
1. Any [comparable](https://go.dev/ref/spec#Comparison_operators) type works as a context key
```go
package user

type Id string

// NOTE: unexported to prevent collisions in context
type key int

const (
	userUuidKey key = iota
	// other related context keys go here
)

// NewContext returns new context with passed userUuid
func NewContext(ctx context.Context, u Id) context.Context {
	// TODO: validate u here

	return context.WithValue(ctx, userUuidKey, u)
}

// FromContext returns userUuid in a context
// ok==true when returned userUuid is usable
func FromContext(ctx context.Context) (u Id, ok bool) {

    // NOTE: ctx.Value returns nil for missing value
    // NOTE: type assertion allows nil arg
	u, ok = ctx.Value(userUuidKey).(Id)
	return
}

// FromRequest returns userUuid in http.Request
// 2nd return value is true when ok to use
func FromRequest(r *http.Request) (Id, bool) {
	return FromContext(r.Context())
}
```

## Example: HTTP Client
1. Use [`http.NewRequestWithContext`](https://pkg.go.dev/net/http#NewRequestWithContext) or [`req.WithContext`](https://pkg.go.dev/net/http#Request.WithContext)
1. [`client.Do(req)`](https://pkg.go.dev/net/http#Client.Do) automatically handles context cancellation
    1. `client.Do(...)` is invoked indirectly by all the "convenient" methods
1. See [examples in http-client](./io.http.client.md) doc


## Example: HTTP Server
1. Server [automatically cancels](https://pkg.go.dev/net/http#Request.Context) context when connection closed
1. Use [`req.Context()`](https://pkg.go.dev/net/http#Request.Context) to pass into other context aware functions (eg. sql)
1. See [examples in http-client](./io.http.server.md) doc


## Example: SQL Database client
1. See [database](./database.md) doc


## Example: Kafka client
1. See [kafka](./kafka.md) doc


## Example: gRPC client
1. See [gRPC client](./io.grpc.client.md) doc

## Example: gRPC server
1. See [gRPC server](./io.grpc.server.md) doc


# Other resources
1. https://www.practical-go-lessons.com/chap-37-context
1. https://pkg.go.dev/context
1. https://www.digitalocean.com/community/tutorials/how-to-use-contexts-in-go
1. http://p.agnihotry.com/post/understanding_the_context_package_in_golang/
