# Overview
1. Golang specific tracing setup


# General overview
1. See [common/tracing doc](../common/observability/tracing.md)


# Setup
1. TODO


# Viewing traces
1. TODO


# Register Global [TracerProvider](https://pkg.go.dev/go.opentelemetry.io/otel/trace#TracerProvider) & [TextMapPropagator](https://pkg.go.dev/go.opentelemetry.io/otel/propagation#TextMapPropagator)
```go
// in main.go

    ...	
	otel.SetTracerProvider(app.tracerProvider)
	otel.SetTextMapPropagator(propagation.TraceContext{})
	...
```


# Example [Chi Middleware](https://github.com/go-chi/chi)
```go
func TracingMiddleware(next http.Handler) http.Handler {

	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		// -- Ensure propagator
		propagator := otel.GetTextMapPropagator()
		if propagator == nil {
			propagator = propagation.TraceContext{}
		}

		// -- Build remote ctx
		remoteCtx := context.Background()

		// -- See https://www.w3.org/TR/trace-context/#design-overview
		traceParent := r.Header.Get("traceparent")
		if strings.TrimSpace(traceParent) != "" {
			remoteCtx = propagator.Extract(r.Context(), propagation.HeaderCarrier(r.Header))
		}

		// -- Start span
		rootCtx, span := otel.Tracer("").
			Start(remoteCtx, ">> http-request",
				trace.WithSpanKind(trace.SpanKindServer))
		defer span.End()

		span.SetAttributes(
			semconv.HTTPMethodKey.String(r.Method),
			semconv.HTTPURLKey.String(r.URL.Path),
		)

		// -- Next handler
		next.ServeHTTP(w, r.WithContext(rootCtx))
	})
}
```

## Usage
```go
    ...
	r.Use(middleware.RequestID)                 // 1
	r.Use(middleware.RealIP)                    // 2
	r.Use(handler.TracingMiddleware)            // 3
	r.Use(middleware.Logger)                    // 4
	r.Use(authMiddleware.Intercept)             // 5: after tracer setup
	r.Use(middleware.Recoverer)                 // 6
	r.Use(middleware.Timeout(90 * time.Second)) // 7
    ...
```


# Other Resources
1. https://github.com/open-telemetry/opentelemetry-go (obsoletes open-tracing)
1. https://opentelemetry.io/docs/instrumentation/go/
1. https://opentelemetry.io/docs/reference/specification/error-handling/
1. https://github.com/opentracing/opentracing-go (Legacy, obsoleted by open-telemetry)
