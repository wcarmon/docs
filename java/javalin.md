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

    @Override
    public void handle(Exception ex, Context ctx) {
        requireNonNull(ex, "ex is required and null.");
        requireNonNull(ctx, "ctx is required and null.");

        log.warn("Request failed", ex);
        ctx.contentType("text/plain");

        if (ex instanceof WebException wex) {
            ctx.status(wex.statusCode());
            ctx.result(wex.publicMessage());
            return;
        }

        ctx.status(500);
        ctx.result("Error");
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
        // NOTE: app restarted when this fails, only called during startup
        ctx.status(200);
    });

    // -- Liveness Probe
    svr.get("/api/v1/admin/alive", ctx -> {
        // TODO: check connectivity to external systems here (eg. databases, required services)
        // NOTE: app restarted when this fails, only called after Startup Probe
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
