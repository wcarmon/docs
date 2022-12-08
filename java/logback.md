# Overview
1. How to setup [logback](https://logback.qos.ch/) for [slf4j](TODO)
1. See alternaive: [log4j2 doc](log4j2.md) doc


# Concept
1. API: [slf4j](https://www.slf4j.org/apidocs/org/slf4j/Logger.html)
1. Implementation: [logback](https://logback.qos.ch/) 
    1. [`Appender`](https://logback.qos.ch/apidocs/ch/qos/logback/core/AppenderBase.html) 


# Example [`logback.xml`](https://logback.qos.ch/manual/configuration.html) config
1. Store app log config at `src/main/resources/logback.xml`
    1. Store Test log configuration at `src/test/resources/logback-test.xml`
```xml
<configuration>

    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
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


# `build.gradle.kts` snippet
```kts
dependencies {
    // -- For the API
    
    // -- For the implementation

    // -- To forward other log statements (logging bridge)
    // -- See https://logging.apache.org/log4j/2.x/faq.html#missing_core
    // -- See https://www.slf4j.org/legacy.html


    ...
}

configurations.all {

    // -- Exclude conflicting/redundant jars

exclude group: "org.slf4j", module: "slf4j-log4j12"
exclude group: "log4j", module: "log4j"

}
```


## With [spring boot](https://spring.io/projects/spring-boot)


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

- [Lombok's `@TODO`](https://projectlombok.org/features/log) annotation does the same
    - tradeoff: less code, slower builds 


# Other resources
1. https://docs.spring.io/spring-boot/docs/3.0.0/reference/html/features.html#features.logging
1. https://www.slf4j.org/images/concrete-bindings.png
