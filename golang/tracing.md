# Overview
1. Golang specific tracing setup


# General overview
1. See [common/tracing doc](../common/observability/tracing.md)


# Dependency injection
- Build [`jaeger.Exporter`](https://pkg.go.dev/go.opentelemetry.io/otel/exporters/jaeger#Exporter), [`trace.TracerProvider`](https://pkg.go.dev/go.opentelemetry.io/otel/trace#TracerProvider), [`ZapSpanProcessor`](https://pkg.go.dev/github.com/wcarmon/otzap#ZapSpanProcessor)
```go
import (
    texporter "github.com/GoogleCloudPlatform/opentelemetry-operations-go/exporter/trace"
    "github.com/wcarmon/otzap"
    "go.opentelemetry.io/otel/attribute"
    "go.opentelemetry.io/otel/exporters/jaeger"
    "go.opentelemetry.io/otel/sdk/resource"
    tracesdk "go.opentelemetry.io/otel/sdk/trace"
    semconv "go.opentelemetry.io/otel/semconv/v1.12.0"
    "go.opentelemetry.io/otel/trace"
    "go.uber.org/zap"
)

func NewTracerProvider(
    cfg *appConf,
    jaegerExporter *jaeger.Exporter,
    zapProcessor *otzap.ZapSpanProcessor,
    // TODO: add cloudExporter here (eg. Google cloud or AWS)
) (trace.TracerProvider, error) {

    attrs := otzap.CollectResourceAttributes()
    attrs = append(attrs, attribute.String("gitCommitHash", gitCommitHash)) // See ./git_version_info.md
    attrs = append(attrs, semconv.ServiceNameKey.String(cfg.Tracing.ServiceName))

    // Jaeger UI shows as Span.Process
    rsc := resource.NewWithAttributes(semconv.SchemaURL, attrs...)

    var realExporter tracesdk.SpanExporter = jaegerExporter
    if otzap.IsInAWS() || otzap.IsInGoogleCloud() {
        realExporter = cloudExporter
    }

    opts := make([]tracesdk.TracerProviderOption, 0, 8)
    opts = append(opts, tracesdk.WithBatcher(realExporter))
    opts = append(opts, tracesdk.WithResource(rsc))
    opts = append(opts, tracesdk.WithSampler(tracesdk.AlwaysSample())) // TODO: tune to meet your requirements
    opts = append(opts, tracesdk.WithSpanProcessor(zapProcessor))

    provider := tracesdk.NewTracerProvider(opts...)
    return provider, nil
}

func NewJaegerExporter(cfg *appConf) (*jaeger.Exporter, error) {
    // eg. http://localhost:14268/api/traces
    url := cfg.Tracing.Jaeger.EndpointUrl

    exporter, err := jaeger.New(jaeger.WithCollectorEndpoint(
        jaeger.WithEndpoint(url)))
    if err != nil {
        zap.L().Error("failed to create Jaeger exporter",
            zap.Error(err),
            zap.String("url", url),
        )

        return nil, err
    }

    return exporter, nil
}
```


# Register Global [TracerProvider](https://pkg.go.dev/go.opentelemetry.io/otel/trace#TracerProvider) & [TextMapPropagator](https://pkg.go.dev/go.opentelemetry.io/otel/propagation#TextMapPropagator)
```go
// in main.go

    ...
    otel.SetTracerProvider(app.tracerProvider)
    otel.SetTextMapPropagator(propagation.TraceContext{})
    ...
```


# If using [zap](./logging.zap.md) ...
```go
func NewZapSpanEventProcessor(cfg *appConf) (*otzap.ZapSpanProcessor, error) {
    p := &otzap.ZapSpanProcessor{
        // ... set fields here from cfg
    }

    err := p.Validate()
    if err != nil {
        zap.L().Error("failed to validate ZapSpanProcessor",
            zap.Error(err))

        return nil, err
    }

    return p, nil
}
```

# Graceful shutdown
```go
    // ... setup & register tracer here

    // https://opentelemetry.io/docs/instrumentation/go/manual/#initializing-a-new-tracer
    defer func() {
        type canShutdown interface {
            Shutdown(ctx context.Context) error
        }

        tp, ok := app.tracerProvider.(canShutdown)
        if ok {
            _ = tp.Shutdown(context.Background())
        } else {
            zap.L().Error("failed to shutdown tracer, lacks Shutdown() method")
        }
    }()

    // ... business logic here
}
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
        remoteCtx := r.Context()

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

## Run Jaeger container
- See [../bash/examples/restart.jaeger.sh](https://github.com/wcarmon/docs/blob/main/bash/examples/restart.jaeger.sh)



# Viewing traces

## Jaeger
1. TODO


## Google Cloud
1. TODO


## AWS
1. TODO


# Other Resources
1. https://github.com/open-telemetry/opentelemetry-go (obsoletes open-tracing)
1. https://opentelemetry.io/docs/instrumentation/go/
1. https://opentelemetry.io/docs/reference/specification/error-handling/
1. https://github.com/opentracing/opentracing-go (Legacy, obsoleted by open-telemetry)
