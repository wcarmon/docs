# Overview
1. How to use context


# Key Concepts
1. Context is thread-safe (safe for simultaneous use by multiple goroutines
1. Contexts have a parent/child relationship
    1. Parent cancels children
1. `context.Background()`
    1. is the root of any Context tree
    1. no values, no deadline, never cancelled

## Purpose 1
1. Context is for [cancellation](./concurrency.cancellation.md)
1. Context is for Deadlines (even across API boundaries)
    1. [`ctx.Deadline()`](https://pkg.go.dev/context#Context) is useful for setting I/O timeouts
1. `ctx.Done()` channel closes on timeout or when manually closed
1. [`ctx.Err()`](https://pkg.go.dev/context#Context) has the reason why `ctx.Done()` is closed
1. [`ctx.Deadline()`](https://pkg.go.dev/context#Context) returns the deadline, (when present)
1. [`WithDeadline`](https://pkg.go.dev/context#WithDeadline) and [`ctx.WithCancel`](https://pkg.go.dev/context#WithCancel) return a [CancelFunc](https://pkg.go.dev/context#CancelFunc)
    1. invoking the [CancelFunc](https://pkg.go.dev/context#CancelFunc) is the only way to manually cancel a context
    1. Context can only be cancelled once

## Purpose 2
1. Context is for "small" request scoped data
1. [`ctx.Value(...)`](https://pkg.go.dev/context#Context) and [`context.WithValue`](https://pkg.go.dev/context#WithValue) help get & set request scoped values
1. Data you add to Context **MUST BE** safe for simultaneous use by multiple goroutines


# Idioms
1. Context is the first argument, named `ctx`
1. Always set a deadline for calling external systems (database, http, grpc, kafka, ...)
1. Prefer [`context.WithDeadline`](https://pkg.go.dev/context#WithDeadline) to [~~`context.WithTimeout`~~](https://pkg.go.dev/context#WithTimeout)
    1. `WithTimeout` hard-codes `time.Now()`, which makes it harder to test (eg. cannot inject clock)
1. Pass `context` to sql calls
    1. [`conn.PingContext`](https://pkg.go.dev/database/sql#Conn.PingContext)
    1. [`conn.PrepareContext`](https://pkg.go.dev/database/sql#Conn.PrepareContext)
    1. [`conn.QueryContext`](https://pkg.go.dev/database/sql#Conn.QueryContext)
    1. [`stmt.ExecContext`](https://pkg.go.dev/database/sql#Stmt.ExecContext)
    1. [`stmt.QueryContext`](https://pkg.go.dev/database/sql#Stmt.QueryContext)
    1. [`stmt.QueryRowContext`](https://pkg.go.dev/database/sql#Stmt.QueryRowContext)

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

## Deadline
```go
```

## Timeout
```go
```

## Request scoped data
```go
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
