# Overview
1. How to setup [log4j2](https://logging.apache.org/log4j/2.x/)
1. See alternaive: [logback doc](logback.md) doc


# Concept
1. API: [log4j2](https://logging.apache.org/log4j/2.x/log4j-api/apidocs/org/apache/logging/log4j/Logger.html)
1. Implementation: [log4j2](https://logging.apache.org/log4j/2.x/log4j-core/apidocs/org/apache/logging/log4j/core/Appender.html)  


# Example [`log4j2.xml`](https://logging.apache.org/log4j/2.x/manual/configuration.html) config
1. [Official docs](https://logging.apache.org/log4j/2.x/manual/configuration.html)
1. Store app log config at `src/main/resources/log4j2.xml`
    1. Store Test log configuration at `src/test/resources/log4j2-test.xml`
```xml
<?xml version="1.0" encoding="UTF-8"?>

<Configuration status="WARN">

    <Appenders>
        <Console name="console" target="SYSTEM_OUT">
            <PatternLayout pattern="%d{HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n"/>
            
            <!-- Some alternatives: -->            
            <!--  <PatternLayout pattern="%d{yyyy-MM-dd'T'HH:mm:ss.SSS} %5p ${hostName} --- [%15.15t] %-40.40c{1.} : %m%n%ex"/> -->
            <!--  <PatternLayout pattern="[%-5level] %d{yyyy-MM-dd'T'HH:mm:ss.SSS} [%t] %c{1} - %msg%n"/> -->
            <!--
                  <JsonLayout
                      compact="false"
                      complete="false"
                      includeStacktrace="true"
                      locationInfo="false"
                      properties="true"/>
            -->
        </Console>         

        <RollingFile name="rollingFile"
                     fileName="app.log"
                     filePattern="logs/app.%d{yyyy-MM-dd}-%i.log.gz">
            <PatternLayout pattern="%d{HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n"/>

            <Policies>
                <OnStartupTriggeringPolicy/>
                <TimeBasedTriggeringPolicy
                        interval="1"/>
                <SizeBasedTriggeringPolicy size="200 MB"/>
            </Policies>

            <DefaultRolloverStrategy max="5"/>
        </RollingFile>

        <Async name="asyncAppender">
            <AppenderRef ref="console"/>
            <AppenderRef ref="rollingFile"/>
        </Async>
    </Appenders>

    <Loggers>
        <Logger name="com.mystuff" level="debug" additivity="false">
            <AppenderRef ref="asyncAppender"/>
        </Logger>

        <Logger name="org.apache.http" level="info" additivity="false">
          <AppenderRef ref="asyncAppender"/>
        </Logger>

        <logger name="io.netty" level="info" additivity="false">
            <AppenderRef ref="asyncAppender"/>
        </logger>

        <logger name="io.micrometer" level="debug" additivity="false">
            <AppenderRef ref="asyncAppender"/>
        </logger>

        <Logger name="org.springframework" level="info" additivity="false">
            <AppenderRef ref="asyncAppender"/>
        </Logger>

        <Logger name="org.springframework.beans" level="info" additivity="false">
            <AppenderRef ref="asyncAppender"/>
        </Logger>

        <Logger name="org.springframework.boot" level="info" additivity="false">
            <AppenderRef ref="asyncAppender"/>
        </Logger>

        <Logger name="org.springframework.boot.autoconfigure" level="warn" additivity="false">
            <AppenderRef ref="asyncAppender"/>
        </Logger>

        <Logger name="org.springframework.core" level="info" additivity="false">
            <AppenderRef ref="asyncAppender"/>
        </Logger>

        <Logger name="org.springframework.context" level="info" additivity="false">
            <AppenderRef ref="asyncAppender"/>
        </Logger>

        <Logger name="org.springframework.jdbc" level="info" additivity="false">
            <AppenderRef ref="asyncAppender"/>
        </Logger>

        <Logger name="org.springframework.test" level="info" additivity="false">
            <AppenderRef ref="asyncAppender"/>
        </Logger>

        <Root level="debug">
            <AppenderRef ref="asyncAppender"/>
        </Root>
    </Loggers>

</Configuration>
```


# `build.gradle.kts` snippet
```kts
dependencies {
    ...
    
    // -- For the API
    implementation("org.apache.logging.log4j:log4j-api:2.19.0") // or latest
    
    // -- For the implementation
    implementation("org.apache.logging.log4j:log4j-core:2.19.0") // or latest
    
    // -- For forwarding other log statements (logging bridge)
    // -- See https://www.slf4j.org/legacy.html
    implementation("org.slf4j:jcl-over-slf4j:2.0.5")    // apache commons logging -> slf4j
    implementation("org.slf4j:jul-to-slf4j:2.0.5")      // java.util.Logging -> slf4j
    implementation("org.slf4j:slf4j-reload4j:2.0.5")    // legacy apache log -> slf4j
    
    ...
}

configurations.all {
    exclude(group = "commons-logging", module = "commons-logging")
    exclude(group = "jboss-logging", module = "org.jboss.logging")
    exclude(group = "log4j", module = "log4j")
    exclude(group = "org.apache.logging.log4j", module = "log4j-to-slf4j")
    exclude(group = "org.springframework.boot", module = "spring-boot-starter-logging")
    ...
}
```


## With spring boot
1. See https://docs.spring.io/spring-boot/docs/3.0.0/reference/html/features.html#features.logging
1. See https://mvnrepository.com/artifact/org.springframework.boot/spring-boot-starter-log4j2


# Example usage
```java
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
...

/**
 * <brief description of purpose>
 */
public final SomeClass {
    private static final Logger LOG = LogManager.getLogger(SomeClass.class);
    
    ...
}
```


# Other resources
1. https://logging.apache.org/log4j/2.x/
1. https://www.callicoder.com/spring-boot-log4j-2-example/
1. https://docs.spring.io/spring-boot/docs/3.0.0/reference/html/features.html#features.logging
