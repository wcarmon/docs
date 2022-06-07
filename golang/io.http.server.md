# Overview
1. How to setup an http server
1. How to choose a router/mux


# Server
- TODO

# Router/Mux
1. Maps a uri (or pattern) to your function


## Chi
1. https://github.com/go-chi/chi
1. Why?
    - small
    - Has tests
    - Has benchmarks
    - aligned with core-go http api (http.Handler, http.HandlerFunc, ...)
    - [context support](https://pkg.go.dev/context)
    - [go.mod](https://go.dev/ref/mod#go-mod-file)
    - no external deps
    - named url params
    - modular
    - [Middleware support](TODO)
    - Well documented
    - Actively maintained
    - Used in production


## Gorilla
1. https://github.com/gorilla/mux
1. Why? A lot of the same benefits of Chi


## core http.ServeMux
1. Pro: no external dependencies
1. Pro: Fast
1. Pro: Well Documented
1. Pro: Overlapping url support
1. Con: No support for url params


# Avoid
1. [Pat](https://github.com/bmizerany/pat): unmaintained, no go-modules support, slower than competition, no regex matching
1. TODO: others


# Other resources
1. https://www.alexedwards.net/blog/which-go-router-should-i-use
1. https://github.com/gorilla/mux
1. https://benhoyt.com/writings/go-routing/
