# Overview
1. How to build idiomatic POJOs on Java 8 thru 11
1. For [Lombok](https://projectlombok.org/) based POJOs, see [./pojos.lombok.java8-11.md](./pojos.lombok.java8-11.md)
    1. Lombok based pojos are simpler, but add a small penalty to the build process
1. See also [JVM Immutability](jvm-immutability.md)
1. Building idiomatic POJOs in java 8-11 is non-trivial (before [Records](https://docs.oracle.com/en/java/javase/14/language/records.html))


# Before you start...
1. For Intellij, Install either [InnerBuilder plugin](https://plugins.jetbrains.com/plugin/7354-innerbuilder) or [InnerBuilder continued plugin](https://plugins.jetbrains.com/plugin/15818-innerbuilder-continued)
1. Both are equally sufficient although [`InnerBuilder continued`](https://plugins.jetbrains.com/plugin/15818-innerbuilder-continued) has more features.
1. Restart after [installing one plugin](https://www.jetbrains.com/help/idea/managing-plugins.html)


# Big picture
1. We want Immutability.  [Why?](../general/immutability.md)
    1. Immutable after construction
1. We don't want to rely on argument positions (brittle/fragile coding anti-pattern)
1. We want compatibility with [Jackson](https://github.com/FasterXML/jackson) (JSON serialization & deserialization)
1. We want our POJOs to be compatible with java Collections ([Map](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Map.html), [Set](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Set.html), [List](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/List.html), ...)
1. We want our POJOs to print helpful info when logged


# Example-1
```java
//TODO: ...
```

# Example-2 (JSON compatible)
```java
//TODO: ...
```


# POJO Checklist
1. Select a good name for the POJO
1. Mark the class `final`
    1. Composition over Inheritance: [why?](https://en.wikipedia.org/wiki/Composition_over_inheritance), [why?](https://stackoverflow.com/questions/49002/prefer-composition-over-inheritance), [why?](https://medium.com/geekculture/composition-over-inheritance-7faed1628595)
1. Define properties
    1. Aggressively avoid [String](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html) properties.  [Why?](./strings.avoid.md)
    1. Use the [right collection](./collection.selecting.md)
1. Properties: Mark **all** properties [`private final`](https://docs.oracle.com/javase/tutorial/essential/concurrency/imstrat.html)
1. Properties: [No Setters](https://docs.oracle.com/javase/tutorial/essential/concurrency/imstrat.html)
1. Properties: Generate Getters
    1. [Let Intellij do it](https://www.jetbrains.com/help/idea/generating-code.html#generate-getters-setters)
    1. If your property names are inconvenient for callers, add an extra getter
1. Properties: Use modern Java types for properties
    1. Modern core types are immutable
    1. Examples: [java.time](https://docs.oracle.com/javase/8/docs/api/java/time/package-summary.html)
    1. TODO: add more examples
1. Properties: Prefer [primitive](https://docs.oracle.com/javase/tutorial/java/nutsandbolts/datatypes.html) properties (when sensible)
1. Properties: Rely on [jvm defaults](https://docs.oracle.com/javase/tutorial/java/nutsandbolts/datatypes.html) for properties (when sensible)
1. Builder: Use [Builder pattern](https://refactoring.guru/design-patterns/builder) (POJOs)
    1. Generate with [InnerBuilder](https://plugins.jetbrains.com/plugin/7354-innerbuilder) plugin or [InnerBuilder continued plugin](https://plugins.jetbrains.com/plugin/15818-innerbuilder-continued) plugin
        1. (select the first 3 options) `Generate builder method for final fields`, `Generate static newBuilder() method`, `Generate builder copy constructor`
        1. (select the last option) `Use field names in setters`
    1. Verify: constructor is `private`
    1. Verify: it generated a builder class, eg. `public static final class Builder{...}`
    1. Verify: it generated the "copy constructor", eg. `public static Builder newBuilder(Foo copy) { ... }`
    1. Prefer nullable (Object) property types **on the builder** (so you can default them)
    1. PLUGIN BUG: In "copy" builder method, use direct field accessors instead of getters
1. Constructor: Ensure `builder` instance passed into constructor (no all-args-constructor)
1. Constructor: Do defensive copy on collections
1. Constructor: Add field validation to the constructor (after assignments)
1. Bean: Generate `hashcode()` & `equals(...)`
    1. So POJO is usable in Collections
    1. [Why?](https://www.baeldung.com/java-equals-hashcode-contracts)
    1. [Why?](https://www.geeksforgeeks.org/equals-hashcode-methods-java/)
    1. [Why?](https://howtodoinjava.com/java/basics/java-hashcode-equals-methods/)
    1. [How? via Intellij](https://www.jetbrains.com/help/idea/generate-equals-and-hashcode-wizard.html)
    1. [How? via core Java 8](https://docs.oracle.com/javase/8/docs/api/java/util/Objects.html#hashCode-java.lang.Object-)
    1. [How? via apache commons](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/builder/EqualsBuilder.html) (only for legacy code)
1. Bean: Generate [`toString()`](https://docs.oracle.com/javase/8/docs/api/java/lang/Object.html#toString--)
    1. So POJO prints helpful info in strings, eg. logging


## Setting Default property values
1. Set defaults in constructor, after assignments
1. For Strings, use [`org.apache.commons.lang3.StringUtils.defaultIfBlank(...)`](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/StringUtils.html)
1. For Strings, prefer `""` over null String
1. For non-string objects, use [`Optional.ofNullable(...).orElseGet(...)`](https://docs.oracle.com/javase/8/docs/api/java/util/Optional.html)
    1. **Legacy code**: For non-string objects, use [`ObjectUtils.defaultIfNull(...)`](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/ObjectUtils.html)
1. Default collections to empty (`List.of()`, `Set.of()`, `Map.of()`) instead of `null`
    1. **Legacy code**: Default collections to empty (`Collections.emptyList()`, `Collections.emptySet()`, `Collections.emptyMap()`) instead of `null`


## Extras for supporting Jackson
### Class annotations
1. `@JsonIgnoreProperties({"\u0024schema", "\u0024id"})`
   1. This allows `$id` and `$schema` properties in json for deserializing
1. `@JsonPropertyOrder(alphabetic = true)`
   1. Provides predictable order for serialized json
1. `@JsonDeserialize(builder = Foo.Builder.class)` (replace `Foo`)
   1. Allows Jackson Deserializer to find your Builder class
1. On the **Builder** class, add annotation `@JsonPOJOBuilder(withPrefix = "")`

### Property annotations
1. Copy any Jackson annotations from properties (for serialization) to builder properties (for deserialization)
1. Use [`@JsonProperty`](https://javadoc.io/doc/com.fasterxml.jackson.core/jackson-annotations/latest/com/fasterxml/jackson/annotation/JsonProperty.html) only when the json property name is non-standard
1. Use [`@JsonProperty`](https://javadoc.io/doc/com.fasterxml.jackson.core/jackson-annotations/latest/com/fasterxml/jackson/annotation/JsonProperty.html) sparingly since annotations must be applied to the builder properties


## Cached fields
TODO


## Derived fields
1. Ensure derived fields are NOT in Builder
1. Mark derived fields `transient`
1. Use getter-like methods
1. Use `@java.beans.Transient` on getters, so Jackson will ignore


# Gotchas
1. **WARNING** Avoid [org.jetbrains.annotations.Nullable](https://www.jetbrains.com/help/idea/nullable-and-notnull-annotations.html) annotation since it's incompatible with [Jackson](https://github.com/FasterXML/jackson)
