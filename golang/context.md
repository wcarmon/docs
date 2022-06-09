# Overview
1. How to use [context](https://pkg.go.dev/context)


# Key Concepts
1. Context is thread-safe *(safe for simultaneous use by multiple goroutines)*
1. Contexts have a parent/child relationship
    1. [Parent cancels children](https://cs.opensource.google/go/go/+/refs/tags/go1.18.3:src/context/context.go;l=16) (Propagation)
1. [`context.Background()`](https://pkg.go.dev/context#Background)
    1. Is the root of any Context tree
    1. [no values, no deadline, never cancelled](https://pkg.go.dev/context#Background)
    1. Is the [zero value](https://go.dev/ref/spec#The_zero_value) of a context

## Purpose 1
1. Context is for [cancellation](./concurrency.cancellation.md)
1. Context is for Deadlines/Timeouts (even across API boundaries)
    1. [`ctx.Deadline()`](https://pkg.go.dev/context#Context) is useful for setting I/O timeouts
1. [`ctx.Done()`](https://pkg.go.dev/context#Context) `channel` is closed after a timeout or when manually closed (see examples below)
1. [`ctx.Err()`](https://pkg.go.dev/context#Context) has the reason why `ctx.Done()` is closed
1. [`ctx.Deadline()`](https://pkg.go.dev/context#Context) returns the deadline, (when present)
1. [`WithDeadline`](https://pkg.go.dev/context#WithDeadline) and [`ctx.WithCancel`](https://pkg.go.dev/context#WithCancel) return a [CancelFunc](https://pkg.go.dev/context#CancelFunc)
    1. Invoking the [CancelFunc](https://pkg.go.dev/context#CancelFunc) is the **only** way to manually cancel a context
    1. Context can only be cancelled at-most-once

## Purpose 2
1. Context is for "small" request-scoped data
    1. [RequestId](https://pkg.go.dev/github.com/go-chi/chi/middleware#RequestID) (helps with tracing/debugging)
    1. UserUuid/UserId for Authenticated user
    1. TraceId/SpanId ([OpenTelemetry](./tracing.md), [OpenTracing](./tracing.md), ...)
1. Data you add to Context **MUST BE** safe for simultaneous use by multiple goroutines
    1. This is another reason to use immutable IDs
1. [`ctx.Value(...)`](https://pkg.go.dev/context#Context) and [`context.WithValue`](https://pkg.go.dev/context#WithValue) help get & set request-scoped values


# Idioms
1. Context is the first argument, named `ctx`
1. Every `func` on the path between incoming and outgoing request accepts `ctx` as 1st argument
1. Always set a deadline for calling external systems (eg. database, http, grpc, kafka, ...)
1. Prefer [`context.WithDeadline`](https://pkg.go.dev/context#WithDeadline) to [~~`context.WithTimeout`~~](https://pkg.go.dev/context#WithTimeout)
    1. [`WithTimeout`](https://cs.opensource.google/go/go/+/refs/tags/go1.18.3:src/context/context.go;l=506) hard-codes [`time.Now()`](https://cs.opensource.google/go/go/+/refs/tags/go1.18.3:src/context/context.go;l=507), makes testing harder (eg. cannot inject clock)
1. Pass `ctx` to sql calls (So deadline/timeout/cancellation works)
    1. [`conn.PingContext`](https://pkg.go.dev/database/sql#Conn.PingContext)
    1. [`conn.PrepareContext`](https://pkg.go.dev/database/sql#Conn.PrepareContext)
    1. [`conn.QueryContext`](https://pkg.go.dev/database/sql#Conn.QueryContext)
    1. [`stmt.ExecContext`](https://pkg.go.dev/database/sql#Stmt.ExecContext)
    1. [`stmt.QueryContext`](https://pkg.go.dev/database/sql#Stmt.QueryContext)
    1. [`stmt.QueryRowContext`](https://pkg.go.dev/database/sql#Stmt.QueryRowContext)
1. `context.Value()` is **not** a replacement for func arguments


# Patterns
## Manual cancellation
```go
func foo() {
    ...
    parentCtx := context.Background()

    ctx, cancel = context.WithCancel(parentCtx)
    defer cancel() // Guarantee children are cleaned up

    // pass ctx to other func (eg. http client, grpc client, sql, kafka, rabbitmq, ...)
}
```


## Set Deadline
```go
//TODO
```


## Set Timeout
```go
//TODO
```


## Deadline/Cancel aware task
```go
type FooResult int // arbitrary

func CallSomeService(ctx context.Context) (FooResult, error) {

	// result of "real" call goes here
	// sender not blocked because buffer is 1
	resultChan := make(chan FooResult, 1)

	go func() {
		// -- send result on resultChan
		resultChan <- doRealWork()
	}()

	// -- wait for first of [cancellation/timeout] or [a result]
	select {
	case <-ctx.Done():
		return 0, ctx.Err()

	case r := <-resultChan:
		return r, nil
	}
}
```


## Request scoped data
1. Assuming a useruuid package
```go
type UserUuid string

// NOTE: unexported to prevent collisions
type key int

const (
	userUuidKey key = iota
	// other keys go here
)

// Build a new context with passed userUuid
func NewContext(ctx context.Context, u UserUuid) context.Context {
	// TODO: validate u here

	return context.WithValue(ctx, userUuidKey, u)
}

// Lookup the userUuid from an http request
// 2nd return value is true when ok to use
func FromRequest(r *http.Request) (UserUuid, bool) {
	return FromContext(r.Context())
}

// Lookup the userUuid from a context
// 2nd return value is true when ok to use
func FromContext(ctx context.Context) (u UserUuid, ok bool) {
	u, ok = ctx.Value(userUuidKey).(UserUuid)
	return
}
```



- TODO: http client
- TODO: http server
- TODO: grpc client
- TODO: grpc server
- TODO: database
- TODO: kafka
- TODO: opentracing/opentelemetry


# Other resources
1. https://www.practical-go-lessons.com/chap-37-context
1. https://pkg.go.dev/context
1. https://www.digitalocean.com/community/tutorials/how-to-use-contexts-in-go
1. http://p.agnihotry.com/post/understanding_the_context_package_in_golang/
