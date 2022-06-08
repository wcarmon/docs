# Overview
1. How to setup an http server
1. How to choose a router/mux


# Server
1. https://gobyexample.com/http-servers
1. https://yourbasic.org/golang/http-server-example/
1. https://go.dev/doc/articles/wiki/


# [http.Handler](https://pkg.go.dev/net/http#Handler) and [http.HandlerFunc](https://pkg.go.dev/net/http#HandlerFunc)
1. Signature: `func (w http.ResponseWriter, r *http.Request)`
1. [`http.Handler`](https://pkg.go.dev/net/http#Handler) is the interface for handling HTTP requests
1. [`http.HandlerFunc`](https://pkg.go.dev/net/http#HandlerFunc) converts any func with the signature above to a [`http.Handler`](https://pkg.go.dev/net/http#Handler)
1. *Almost* any type can have a `ServeHTTP` method
    1. Examples in [Effective Go doc](https://go.dev/doc/effective_go#interface_methods)
    1. See [`http.Handler`](https://pkg.go.dev/net/http#Handler) interface


## Example: Named func
```go
func myHandler(w http.ResponseWriter, r *http.Request) {
	io.WriteString(w, "Hi\n")
}

func main() {
	svr := &http.Server{
		// -- See net.Dial for Addr syntax
		Addr:    ":8080",

		// -- Adapter converts your func to a http.Handler
		Handler: http.HandlerFunc(myHandler),
	}

	log.Info().
		Str("addr", svr.Addr).
		Msg("Server listening")

	log.Fatal().
		// -- This line blocks goroutine while server runs
		Err(svr.ListenAndServe()).
		Msg("Server terminated")
}
```

## Example: Anonymous func
```go
func main() {

	fn := func(w http.ResponseWriter, r *http.Request) {
		io.WriteString(w, "Hi\n")
	}

	svr := &http.Server{
		// -- See net.Dial for Addr syntax
		Addr:    ":8080",

		// -- Adapter converts your func to a http.Handler
		Handler: http.HandlerFunc(fn),
	}

	log.Info().
		Str("addr", svr.Addr).
		Msg("Server listening")

	log.Fatal().
	    // -- This line blocks goroutine while server runs
	    Err(svr.ListenAndServe()).
	    Msg("Server terminated")
}
```

## Example: method on a type
```go
type Foo int32

// -- Implements http.Handler
func (n *Foo) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Value is: %v\n", *n)
}

func main () {
	foo := Foo(34)

	svr := &http.Server{
		Addr:    ":8080",
		Handler: &foo,
	}

	log.Info().
		Str("addr", svr.Addr).
		Msg("Server listening")

	log.Fatal().
	    Err(svr.ListenAndServe()).
	    Msg("Server terminated")
}
```


# Router/Mux
1. A Router/Mux maps a uri (or pattern) to your function
1. All libs below accept standard [`http.Handler`](https://pkg.go.dev/net/http#Handler)
1. Avoid `http.HandleFunc` and `http.Handle` functions (unless using DefaultServeMux)

## Chi
1. https://github.com/go-chi/chi
1. Why?
    - Small
    - Has tests
    - Has benchmarks
    - Aligned with core-go http api (http.Handler, http.HandlerFunc, ...)
    - [context support](https://pkg.go.dev/context)
    - [go.mod](https://go.dev/ref/mod#go-mod-file)
    - [Middleware support](TODO)
    - Actively maintained
    - Modular
    - No external deps
    - [Subrouter support](TODO)
    - [Supports named url params](TODO)
    - Used in production
    - [Well documented](TODO)


## Gorilla
1. https://github.com/gorilla/mux
1. Why? Similar to [Chi](https://github.com/go-chi/chi)


## core [`http.ServeMux`](https://pkg.go.dev/net/http#ServeMux)
1. Pro: no external dependencies
1. Pro: Fast
1. Pro: Well Documented
1. Pro: Overlapping url support
1. Con: No support for url params


# Avoid
1. [Pat](https://github.com/bmizerany/pat): unmaintained, no go-modules support, slower than competition, no regex matching
1. TODO: others


# TODO/Organize
- TODO: ListenAndServe always returns non-nil error
- TODO: swagger/openapi
- TODO: context
- TODO: opentelemetry


# Other resources
1. https://www.alexedwards.net/blog/which-go-router-should-i-use
1. https://github.com/gorilla/mux
1. https://benhoyt.com/writings/go-routing/
1. https://gobyexample.com/http-servers
1. https://www.digitalocean.com/community/tutorials/how-to-make-an-http-server-in-go
1. https://go.dev/doc/articles/wiki/
1. https://gowebexamples.com/http-server/
1. https://drstearns.github.io/tutorials/gomiddleware/
1. https://www.alexedwards.net/blog/making-and-using-middleware
1. https://go.dev/doc/effective_go#interface_methods
