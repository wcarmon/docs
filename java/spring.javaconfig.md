# Overview
- Why JavaConfig and not XML for configuration


# Why JavaConfig? (not xml)
- Java compiler enforces typesafey for JavaConfig (XML is not typesafe)
- XML is more verbose than Java
- JavaConfig allows init logic (XML does not)
- JavaConfig allows [preconditions](./preconditions.md) (XML does not)
- JavaConfig is refactor friendly
- (unlike XML) JavaConfig files are already on the classpath
- (unlike XML) JavaConfig files don't need to be parsed at startup
- Spring recommends JavaConfig
    - Modern versions of documentation use that
    - [Spring Initializr](https://start.spring.io/) generates JavaConfig


# More info
- [Official docs](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#beans-java)
