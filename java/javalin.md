# Overview

1. How to standup [Javalin](https://javalin.io/) server quickly
1. NOTE: Javalin will auto-prefer virtual threads for JDK 21+

# build.gradle.kts

```kts
dependencies {

    ...
    implementation("io.javalin:javalin")  // 5.3.x is (currently) the latest
    ...
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

    var server = Javalin.create();

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
    var port = 8080; // or from args, config file, etc

    var server = injector.getInstance(Javalin.class);
    server.start(port);
}
```

# Interceptors

1. TODO: Auth
1. TODO: logging
1. TODO: global error handler
1. TODO: tracing propagation

# Other resources

1. TODO
