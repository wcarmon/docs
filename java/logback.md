# Overview

1. How to setup [logback](https://logback.qos.ch/) for [slf4j](https://www.slf4j.org/)
1. See alternaive: [log4j2 doc](log4j2.md) doc

# Concept

1. API: [slf4j](https://www.slf4j.org/apidocs/org/slf4j/Logger.html)
1. Implementation: [logback](https://logback.qos.ch/)
    1. [`Appender`](https://logback.qos.ch/apidocs/ch/qos/logback/core/AppenderBase.html)

# Example [`logback.xml`](https://logback.qos.ch/manual/configuration.html) config

1. [Official docs](https://logback.qos.ch/manual/configuration.html)
1. Store app log config at `src/main/resources/logback.xml`
    1. Store Test log configuration at `src/test/resources/logback-test.xml`

```xml

<configuration>

    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>%d{HH:mm:ss.SSS} [%thread] [%-5level] %logger{24} - %msg%n</pattern>
        </encoder>
    </appender>

    <logger name="com.mystuff" level="DEBUG"/>

    <logger name="ch.qos.logback" level="WARN"/>
    <logger name="io.netty" level="INFO"/>
    <logger name="io.netty.buffer" level="WARN"/>
    <logger name="io.netty.channel" level="WARN"/>

    <root level="debug">
        <appender-ref ref="STDOUT"/>
    </root>

</configuration>
```

- For layouts: see [pattern](https://logback.qos.ch/manual/layouts.html#ClassicPatternLayout), ...
- JSON layout requires extra (abandonware) dependencies (like [`ch.qos.logback.contrib:logback-json-classic`](https://mvnrepository.com/artifact/ch.qos.logback.contrib/logback-json-classic/0.1.5), [`ch.qos.logback.contrib:logback-jackson`](https://mvnrepository.com/artifact/ch.qos.logback.contrib/logback-jackson/0.1.5), ...)
    - last updated in 2016 (abandonware)

# `build.gradle.kts` snippet

```kts
dependencies {
    // -- For the API
    implementation("org.slf4j:slf4j-api:2.0.16") // or latest
    
    // -- For the implementation
    implementation("ch.qos.logback:logback-classic:1.5.16")  // or latest
    implementation("ch.qos.logback:logback-core:1.5.16")     // or latest
    implementation("ch.qos.logback:logback-access:1.5.16")   // or latest

    // -- To forward other log statements (logging bridge)
    // -- See https://logging.apache.org/log4j/2.x/faq.html#missing_core
    // -- See https://www.slf4j.org/legacy.html
    implementation("org.apache.logging.log4j:log4j-to-slf4j:2.19.0") // log4j2 api to slf4j api
    implementation("org.slf4j:jcl-over-slf4j:2.0.5")                 // apache commons logging to slf4j
    implementation("org.slf4j:jul-to-slf4j:2.0.5")                   // java.util.logging to slf4j
    implementation("org.slf4j:log4j-over-slf4j:2.0.5")               // legacy log4j to slf4j

    ...
}

configurations.all {

    // -- Exclude conflicting/redundant jars
    exclude(group = "commons-logging", module = "commons-logging")              // legacy
    exclude(group = "jboss-logging", module = "org.jboss.logging")              // legacy
    exclude(group = "log4j", module = "log4j")                                  // legacy
    exclude(group = "org.apache.logging.log4j", module = "log4j-core")          // log4j2 impl
    exclude(group = "org.apache.logging.log4j", module = "log4j-jcl")           // apache commons logging to log4j2 impl 
    exclude(group = "org.apache.logging.log4j", module = "log4j-jul")           // java.util.logging to log4j2 impl
    exclude(group = "org.apache.logging.log4j", module = "log4j-slf4j-impl")    // slf4j to log4j2 impl
    exclude(group = "org.slf4j", module = "slf4j-jcl")                          // slf4j to apache commons logging
    exclude(group = "org.slf4j", module = "slf4j-jdk14")                        // slf4j to java.util.logging
    exclude(group = "org.slf4j", module = "slf4j-log4j12")                      // slf4j to old 1.x log4j api
    exclude(group = "org.slf4j", module = "slf4j-nop")                          // slf4j to nowhere
    exclude(group = "org.slf4j", module = "slf4j-reload4j")                     // slf4j to reload4j's impl of legacy log4j
    exclude(group = "org.slf4j", module = "slf4j-simple")                       // slf4j to stderr
    exclude(group = "org.springframework.boot", module = "spring-boot-starter-log4j2")

    ...
}
```

# Example usage

```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
...

/**
 * <brief description of purpose>
 */
public final class SomeClass {

    private static final Logger LOG = LoggerFactory.getLogger(SomeClass.class);
    ...
}
```

- [Lombok's `@Slf4j`](https://projectlombok.org/features/log) annotation does the same
    - tradeoff: less code, slower builds

## With [spring boot](https://spring.io/projects/spring-boot)

- See 1. See https://docs.spring.io/spring-boot/docs/3.0.0/reference/html/features.html#features.logging
- See https://mvnrepository.com/artifact/org.springframework.boot/spring-boot-starter-logging

# Other Resources

1. https://docs.spring.io/spring-boot/docs/3.0.0/reference/html/features.html#features.logging
1. https://www.slf4j.org/images/concrete-bindings.png
