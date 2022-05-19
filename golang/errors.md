# Overview
1. Idioms for error handling
1. Error handling improvements since v1.13


# Custom error
1. Not always required, keep it simple
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
1. Add context variables to errors to simplify debugging
1. Errors should identify there origin (eg. prefix with package name)
1. Most functions/methods should return `error` as final value
    1. This helps avoid the [Silent failure anti-pattern](https://en.wikipedia.org/wiki/Error_hiding)
1. Avoid using `_` (blank identifier) for ignoring errors
    1. This helps avoid the [Silent failure anti-pattern](https://en.wikipedia.org/wiki/Error_hiding)
1. [errors are just values](https://go.dev/blog/errors-are-values)
1. Almost any type can implement [error](https://pkg.go.dev/errors)
1. Minimize usage of `panic`


# Official examples
1. [os.PathError](https://pkg.go.dev/os#PathError)


- TODO: errors.Is - obsoletes comparing error with ==
- TODO: errors.As - obsoletes type assertion on error
- TODO: fmt.Errorf with %w
- TODO: structured logging
- TODO: wrapping


# Other resources
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