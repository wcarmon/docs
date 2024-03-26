# Overview
1. Notes about java.util.Properties


# Spaces in property key
1. Use double back slash to escape a space in a key
1. No need to escape spaces in the value (since it is after the `=`)
1. Try it yourself:
```java
final var p = new Properties();
p.load(new StringReader("""
        a\\ b\\ c = foo bar
        """));

assertEquals("foo bar", p.getProperty("a b c"));
```


# Other Resources
1. https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Properties.html
