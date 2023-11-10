# Overview
1. Idioms for error handling
1. Error handling improvements since v1.13
1. Robust Error handling is verbose
    1. This is also true in other languages like [rust](https://www.youtube.com/watch?v=jpVzSse7oJ4), java, js, ...


# Custom error
1. Not always required, keep it simple
1. Prefer structured logging over custom errors
1. If you make a custom error, include helpful properties
1. Example
```go
// -- Define your custom error
type ErrInvalidHTTPRequest struct {
    Received     time.Time
    ResponseCode int32
    UserUuid     string
}

// -- Implement the interface
func (e ErrInvalidHTTPRequest) Error() string {
    return fmt.Sprintf("Invalid HTTP request: %#v", e)
}

func doWhatever() error {
    // ...

    // -- Example: Build your custom error
    return &ErrInvalidHTTPRequest{
        Received:     time.Now(),
        ResponseCode: 400,
        UserUuid:     userUuid,
    }
}
```


# Idioms
1. Use [errorx](https://pkg.go.dev/github.com/joomcode/errorx) `Decorate` for clean stacktraces
1. Use a [structured logger]() instead of wrapping errors
    1. See [Logging](./logging.md) doc
    1. Pass errors up to caller
    1. Use Structured logger to add context
    1. Add context variables to Structured logger to simplify debugging
    1. Structured logger simplifies interaction with OpenTracing/OpenTelemetry tools
1. When using `errors.New` or `fmt.Errorf` prefix with package name, then colon
    1. Alternative: use structured logger to capture caller info
1. Most functions/methods should return `error` as final value
    1. Helps avoid the [Silent failure anti-pattern](https://en.wikipedia.org/wiki/Error_hiding)
1. Avoid using `_` (blank identifier) for ignoring errors
    1. Helps avoid the [Silent failure anti-pattern](https://en.wikipedia.org/wiki/Error_hiding)
1. [errors are just values](https://go.dev/blog/errors-are-values)
1. Almost any type can implement [error](https://pkg.go.dev/errors)
1. Minimize usage of `panic`
1. [Official code review feedback](https://github.com/golang/go/wiki/CodeReviewComments#error-strings)
1. Write a little log statement with context before returning err.  Simplifies debugging
```go
...
if err != nil {
    log.Error().Err(err).Msg("failed to eat tacos")
    return nil, err
}
```

# Official examples
1. [os.PathError](https://pkg.go.dev/os#PathError)


- TODO: https://pkg.go.dev/gopkg.in/errgo.v2@v2.1.0/errors
- TODO: errors.Is - obsoletes comparing error with ==
- TODO: errors.As - obsoletes type assertion on error
- TODO: fmt.Errorf with %w  <--- pattern for wrapping, fails when you prefix package :-(
- TODO: only use `os.Exit` in main function
- TODO: only use `log.Fatalf` in main function


# Other Resources
1. https://www.practical-go-lessons.com/chap-40-design-recommendations#error-handling
1. https://www.practical-go-lessons.com/chap-23-errors
1. https://go.dev/blog/go1.13-errors
1. https://go.dev/doc/effective_go#errors
1. https://pkg.go.dev/errors
1. https://opentelemetry.io/docs/reference/specification/error-handling/
1. https://go.dev/blog/error-handling-and-go
1. https://github.com/golovers/effective-go#error-strings
1. https://gobyexample.com/errors
1. https://go.dev/doc/tutorial/handle-errors
1. https://github.com/charlax/antipatterns/blob/master/error-handling-antipatterns.md
1. https://github.com/golovers/effective-go#handle-errors
