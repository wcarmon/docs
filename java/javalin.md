# Overview

1. How to standup [Javalin](https://javalin.io/) server quickly
1. NOTE: Javalin will auto-prefer virtual threads for JDK 21+

# build.gradle.kts

```kts
dependencies {

    // ...
    implementation("io.javalin:javalin")  // 5.3.x is (currently) the latest
    // ...
}
```

# Routes

- [Handler info](https://javadoc.io/doc/io.javalin/javalin/latest/io/javalin/http/Handler.html)
- [Route info](https://javadoc.io/doc/io.javalin/javalin/latest/io/javalin/apibuilder/ApiBuilder.html)
- [server config info](https://javadoc.io/doc/io.javalin/javalin/latest/io/javalin/config/JavalinConfig.html)

```java
@Provides
@Singleton
public Javalin javalin(
    FooHandler fooHandler,
    // ... other handlers ...
) {

    final Javalin server = Javalin.create();

    // -- Config
    server.updateConfig(cfg -> cfg.showJavalinBanner = false);

    // -- Routes
    server.get("/api/vi/foo",
            ctx -> {
                ctx.result("bar");
            });
    // ... other routes

    return server;
}
```

# main method

```java

public static void main(String... args) {
    final int port = 8080; // or from args, config file, etc

    final Javalin server = injector.getInstance(Javalin.class);
    server.start(port);
}
```

# Interceptors

## Global Exception Handler

```java
    final Javalin svr = Javalin.create(cfg -> {
        cfg.showJavalinBanner = false;
        cfg.bundledPlugins.enableDevLogging(); // request logging
        // ...
    });

    svr.exception(Exception.class, exceptionHandler);
```

```java
package com.wcarmon;

import io.javalin.http.Context;
import io.javalin.http.ExceptionHandler;
import lombok.Builder;
import lombok.extern.slf4j.Slf4j;

import static java.util.Objects.requireNonNull;

@Slf4j
public final class GlobalExceptionHandler implements ExceptionHandler<Exception> {

    private final ObjectMapper objectMapper;
    
    @Builder
    private GlobalExceptionHandler(ObjectMapper objectMapper) {
        requireNonNull(objectMapper, "objectMapper is required and null.");
        
        this.objectMapper = objectMapper;
    }

    @Override
    public void handle(Exception ex, Context ctx) {
        requireNonNull(ex, "ex is required and null.");
        requireNonNull(ctx, "ctx is required and null.");

        log.warn("Request failed", ex);
        ctx.contentType("text/plain");

        if (ex instanceof WebException wex) {
            
            final String contentType;
            final String responseBody;
        
            if (wex.fieldValidationErrors().isEmpty()) {
                contentType = "text/plain";
                responseBody = wex.publicMessage();
            } else {
                contentType = "application/json";
                responseBody = objectMapper.writeValueAsString(wex.fieldValidationErrors());
            }
            
            ctx.contentType(contentType);
            ctx.status(wex.statusCode());
            ctx.result(responseBody);
            return;
        }

        ctx.status(500);
        ctx.result("Error");
    }
}
```

### Example `WebException` class
- allows sending correct statusCode & payload back to client 
```java
package com.wcarmon.web;

import lombok.Builder;
import org.apache.commons.lang3.StringUtils;
import org.jetbrains.annotations.Nullable;

import java.util.Map;

import static com.google.common.base.Preconditions.checkArgument;

/**
 * Exception thrown by any class in the request path, converted to an appropriate HTTP error response
 */
public final class WebException extends RuntimeException {

    /**
     * Sensitive info goes here.
     * context is logged, never send to client.
     */
    private final Map<String, Object> context;

    /** Map[FieldName, ErrorMessage] */
    private final Map<String, String> fieldValidationErrors;

    /**
     * No sensitive information here
     */
    private final String publicMessage;

    private final int statusCode;

    @Builder
    private WebException(
            int statusCode,
            @Nullable String publicMessage,
            @Nullable Throwable cause,
            @Nullable Map<String, Object> context,
            @Nullable Map<String, String> fieldValidationErrors) {
        
        super(publicMessage, cause);

        checkArgument(statusCode >= 400, "statusCode must be >= 400");
        checkArgument(statusCode < 600, "statusCode must be < 600");

        this.context = context == null ? Map.of() : Map.copyOf(context);
        this.fieldValidationErrors = fieldValidationErrors == null ? Map.of() : Map.copyOf(fieldValidationErrors);
        this.publicMessage = StringUtils.defaultIfBlank(publicMessage, "").strip();
        this.statusCode = statusCode;
    }

    public Map<String, Object> context() {
        return context;
    }

    /** Map[FieldName, ErrorMessage] */
    public Map<String, String> fieldValidationErrors() {
        return fieldValidationErrors;
    } 

    public String publicMessage() {
        return publicMessage;
    }

    public int statusCode() {
        return statusCode;
    }
}
```

1. TODO: Auth
1. TODO: logging
1. TODO: tracing propagation


# Kubernetes Liveness & Readiness probes
```java
    final Javalin svr = ... ;

    svr.get("/", ctx -> {
        ctx.status(200);
        ctx.result("Server up");
    });

    svr.get("/api/v1/", ctx -> {
        ctx.status(200);
        ctx.result("API Server up");
    });

    // -- Startup Probe
    svr.get("/api/v1/admin/started", ctx -> {
        // TODO: ensure app is ready to start here
        // NOTE: app container restarted when this fails, only called during startup
        ctx.status(200);
    });

    // -- Liveness Probe
    svr.get("/api/v1/admin/alive", ctx -> {
        // TODO: check connectivity to external systems here (eg. databases, required services)
        // NOTE: app container restarted when this fails, only called after Startup Probe
        ctx.status(200);
    });

    // -- Readiness Probe
    svr.get("/api/v1/admin/ready", ctx -> {
        // TODO: check connectivity to external systems here (eg. databases, required services)
        // NOTE: server receives no traffic when this fails
        ctx.status(200);
    });

    // Spring Web equivalent might be:
    // - return allGood
    //         ? new ResponseEntity<>("up", HttpStatus.OK)
    //         : new ResponseEntity<>("down", HttpStatus.SERVICE_UNAVAILABLE)
```
1. See the [Pod/Deployment yamls here](../containers/kubernetes/k8s.pod.md)


# WebSocket timeout
```java
cfg.jetty.modifyWebSocketServletFactory(ws -> ws.setIdleTimeout(Duration.ofHours(4))
);
```
