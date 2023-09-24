# Overview

1. Java specific tracing setup (Java 17+)

# General overview

1. See [common/tracing doc](../common/observability/tracing.md)

# build.gradle.kts

```build.gradle.kts
        ...
        implementation("io.opentelemetry:opentelemetry-api")
        implementation("io.opentelemetry:opentelemetry-context")
        implementation("io.opentelemetry:opentelemetry-exporter-otlp")
        implementation("io.opentelemetry:opentelemetry-exporters-jaeger")
        implementation("io.opentelemetry:opentelemetry-sdk")
        implementation("io.opentelemetry:opentelemetry-sdk-logs")
        implementation("io.opentelemetry:opentelemetry-sdk-trace")
        implementation("io.opentelemetry:opentelemetry-semconv")
        ...
```

# Depencency Injection

```java
    private static final String DEFAULT_JAEGER_ENDPOINT = "http://localhost:4317";
    
    private final String serviceName = "...";  // TODO: pass into this guice module

    ...

    @Provides
    @Singleton
    OpenTelemetry openTelemetry() {
        OtlpGrpcSpanExporter jaegerOtlpExporter =
                OtlpGrpcSpanExporter.builder()
                        .setEndpoint(jaegerEndpoint) // eg. you can default to DEFAULT_JAEGER_ENDPOINT
                        .setTimeout(30, TimeUnit.SECONDS)
                        .build();

        Resource serviceNameResource =
                Resource.create(Attributes.of(ResourceAttributes.SERVICE_NAME, serviceName));

        SdkTracerProvider tracerProvider =
                SdkTracerProvider.builder()
                        .addSpanProcessor(BatchSpanProcessor.builder(jaegerOtlpExporter).build())
                        .setResource(Resource.getDefault().merge(serviceNameResource))
                        .build();

        OpenTelemetrySdk openTelemetry =
                OpenTelemetrySdk.builder()
                        .setPropagators(
                                ContextPropagators.create(W3CTraceContextPropagator.getInstance()))
                        .setTracerProvider(tracerProvider)
                        .build();

        Runtime.getRuntime().addShutdownHook(new Thread(tracerProvider::close));

        return openTelemetry;
    }
    
    @Provides
    @Singleton
    Tracer tracer(OpenTelemetry openTelemetry) {
        return openTelemetry.getTracer(tracerName);
    }
```

# Register Global

1. TODO

# If using OkHTTP

```java
    @Provides
    @Singleton
    ContextPropagators contextPropagators(OpenTelemetry openTelemetry) {
        return openTelemetry.getPropagators();
    }

    @Provides
    @Singleton
    OkTracingInterceptor okTracingInterceptor(
            ContextPropagators contextPropagators, Tracer tracer) {

        return OkTracingInterceptor.builder()
                .propagators(contextPropagators)
                .tracer(tracer)
                .build();
    }
```

## Run Jaeger container

- See [../bash/examples/restart.jaeger.sh](https://github.com/wcarmon/docs/blob/main/bash/examples/restart.jaeger.sh)

# Other Resources

1. https://github.com/open-telemetry/opentelemetry-java-docs#java-opentelemetry-examples
1. https://github.com/open-telemetry/opentelemetry-java
1. https://opentelemetry.io/docs/instrumentation/java/#status-and-releases
