# Overview

1. How to build idiomatic POJOs on Java 8 thru 17
1. Building an idiomatic POJO in Java 8-17 is **non-trivial** (before [Records](https://docs.oracle.com/en/java/javase/14/language/records.html))
1. Lombok based pojos are simpler, but add a small penalty to the build process
    1. For [Lombok](https://projectlombok.org/) based POJOs, see [./pojos.lombok.java8_17.md](./pojos.lombok.java8_17.md)
1. See also [JVM Immutability](jvm_immutability.md)

# Table of Contents

- [Before you start...](#before-you-start)
- [Big picture](#big-picture)
- [Examples](#examples)
- [POJO Checklist](#pojo-checklist)
    * [Properties](#properties)
    * [Builder](#builder)
    * [Constructor](#constructor)
    * [Bean](#bean)
    * [Setting Defaults](#setting-defaults)
    * [Extras for supporting Jackson](#extras-for-supporting-jackson)
        + [Class annotations](#class-annotations)
        + [Property annotations](#property-annotations)
    * [Derived & Cached fields](#derived---cached-fields)
- [Gotchas](#gotchas)

--------

# Before you start...

1. For Intellij, Install either [InnerBuilder](https://plugins.jetbrains.com/plugin/7354-innerbuilder) plugin or [InnerBuilder continued](https://plugins.jetbrains.com/plugin/15818-innerbuilder-continued) plugin.
1. Both are equally sufficient although [InnerBuilder continued](https://plugins.jetbrains.com/plugin/15818-innerbuilder-continued) has more features.
1. Restart after [installing one plugin](https://www.jetbrains.com/help/idea/managing-plugins.html).

# Big picture

1. We want to group & encapsulate related fields into 1 class (aka, POJO).
1. We want Immutability.  [Why?](../common/immutability.md).
1. We want compatibility with Java Collections API ([Map](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Map.html), [Set](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Set.html), [List](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/List.html), ...).
1. We want compatibility with [Jackson](https://github.com/FasterXML/jackson) (JSON serialization & deserialization).
1. We want our POJOs to pretty-print when logged.
1. We don't want to rely on argument positions (brittle/fragile coding anti-pattern).

# Examples

1. [Basic POJO](./pojo.example_1.md)
1. [Jackson compatible POJO](./pojo.example_2.md)

# POJO Checklist

1. Select a good name for the POJO
1. Add a **brief** class comment, short description of purpose
1. Mark the class `final`
    1. Composition over Inheritance: [why?](https://en.wikipedia.org/wiki/Composition_over_inheritance), [why?](https://stackoverflow.com/questions/49002/prefer-composition-over-inheritance), [why?](https://medium.com/geekculture/composition-over-inheritance-7faed1628595)

## Properties

4. Define the properties
    1. Aggressively avoid [String](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html) properties.  [Why?](./strings.avoid.md)
    1. Use the [correct collection](./collections.selecting.md)
1. Mark **all** properties [`private final`](https://docs.oracle.com/javase/tutorial/essential/concurrency/imstrat.html)
1. [No Setters](https://docs.oracle.com/javase/tutorial/essential/concurrency/imstrat.html)
1. Generate Getters
    1. [Let Intellij do it](https://www.jetbrains.com/help/idea/generating-code.html#generate-getters-setters)
    1. If a property name is inconvenient for callers, add an extra getter
1. Use modern Java types for properties
    1. Modern core types are immutable
        1. eg. [java.time](https://docs.oracle.com/javase/8/docs/api/java/time/package-summary.html)
        1. TODO: add more examples
1. Prefer [primitive](https://docs.oracle.com/javase/tutorial/java/nutsandbolts/datatypes.html) properties (when sensible)
1. Rely on [jvm defaults](https://docs.oracle.com/javase/tutorial/java/nutsandbolts/datatypes.html) for properties (when sensible)
1. Add javadoc for **all** String properties: [Why?](./strings.avoid.md)

## Builder

12. Use [Builder pattern](https://refactoring.guru/design-patterns/builder) (POJOs)
    1. Generate with [InnerBuilder](https://plugins.jetbrains.com/plugin/7354-innerbuilder) plugin or [InnerBuilder continued plugin](https://plugins.jetbrains.com/plugin/15818-innerbuilder-continued) plugin
        1. (select the first 3 options)
            1. `Generate builder method for final fields`,
            1. `Generate static newBuilder() method`,
            1. `Generate builder copy constructor`
        1. (select the last option) `Use field names in setters`
    1. **Verify**: constructor is `private`. eg. `private Builder() {}`
    1. **Verify**: it generated a builder class, eg. `public static final class Builder{...}`
    1. **Verify**: it generated the "copy constructor", eg. `public static Builder newBuilder(Foo copy) { ... }`
    1. Prefer nullable (Object) property types **on the builder** (so you can default them)
    1. **PLUGIN BUG**: In "copy" builder method, use direct field accessors instead of getters

## Constructor

13. Ensure `builder` instance passed into constructor (no all-args-constructor)
1. Do defensive copy on collections
    1. [`ImmutableList.copyOf(...)`](https://guava.dev/releases/31.0-jre/api/docs/com/google/common/collect/ImmutableList.html#copyOf(java.lang.Iterable))
    1. [`ImmutableSet.copyOf(...)`](https://guava.dev/releases/31.0.1-jre/api/docs/com/google/common/collect/ImmutableSet.html#copyOf(java.util.Collection))
    1. [`ImmutableMap.copyOf(...)`](https://guava.dev/releases/31.0-jre/api/docs/com/google/common/collect/ImmutableMap.html#copyOf(java.util.Map))
1. Add field [validation (Preconditions)](./preconditions.md) to the constructor (after assignments)
    1. eg. non-null checks, string patterns, number ranges, date ranges, ...

## Bean

16. Generate [`hashcode()`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Object.html#hashCode()) & [`equals(...)`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Object.html#equals(java.lang.Object))
    1. So POJO is usable in Collections
    1. [Why?](https://www.baeldung.com/java-equals-hashcode-contracts), [Why?](https://www.geeksforgeeks.org/equals-hashcode-methods-java/), [Why?](https://howtodoinjava.com/java/basics/java-hashcode-equals-methods/)
    1. How? [via Intellij](https://www.jetbrains.com/help/idea/generate-equals-and-hashcode-wizard.html), [via core Java 8](https://docs.oracle.com/javase/8/docs/api/java/util/Objects.html#hashCode-java.lang.Object-), [via apache commons](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/builder/EqualsBuilder.html) (only for legacy code)
1. Generate [`toString()`](https://docs.oracle.com/javase/8/docs/api/java/lang/Object.html#toString--)
    1. Why? So POJO prints helpful info in strings, eg. for logging
    1. [Let Intellij do it](https://www.jetbrains.com/help/idea/generating-code.html#generate-tostring)

## Setting Defaults

18. Set default values in constructor, after assignments
1. For Strings, use [`org.apache.commons.lang3.StringUtils.defaultIfBlank(...)`](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/StringUtils.html)
1. For Strings, prefer `""` over null String
1. For non-string objects, use [`Optional.ofNullable(...).orElseGet(...)`](https://docs.oracle.com/javase/8/docs/api/java/util/Optional.html)
    1. **Legacy code**: For non-string objects, use [`ObjectUtils.defaultIfNull(...)`](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/ObjectUtils.html)
1. Default collections to empty (`List.of()`, `Set.of()`, `Map.of()`) instead of `null`
    1. **Legacy code**: Default collections to empty ([`Collections.emptyList()`](https://docs.oracle.com/javase/8/docs/api/java/util/Collections.html#emptyList--), [`Collections.emptySet()`](https://docs.oracle.com/javase/8/docs/api/java/util/Collections.html#emptySet--), [`Collections.emptyMap()`](https://docs.oracle.com/javase/8/docs/api/java/util/Collections.html#emptyMap--)) instead of `null`

## Extras for supporting Jackson

### Class annotations

23. [`@JsonIgnoreProperties({"\u0024schema", "\u0024id"})`](https://www.javadoc.io/doc/com.fasterxml.jackson.core/jackson-annotations/latest/com/fasterxml/jackson/annotation/JsonIgnoreProperties.html)
    1. Allows `$id` and `$schema` properties in json for deserializing
    1. [Learn more here](https://json-schema.org/)
1. [`@JsonPropertyOrder(alphabetic = true)`](https://www.javadoc.io/doc/com.fasterxml.jackson.core/jackson-annotations/2.13.0/com/fasterxml/jackson/annotation/JsonPropertyOrder.html)
    1. Provides predictable order for serialized json (simplifies testing, caching, etc)
1. [`@JsonDeserialize(builder = Foo.Builder.class)`](https://www.javadoc.io/doc/com.fasterxml.jackson.core/jackson-databind/latest/com/fasterxml/jackson/databind/JsonDeserializer.html) (*replace `Foo` with your POJO name*)
    1. Allows Jackson Deserializer to find your Builder class
1. On the **Builder** class, add annotation [`@JsonPOJOBuilder(withPrefix = "")`](https://javadoc.io/doc/com.fasterxml.jackson.core/jackson-databind/latest/com/fasterxml/jackson/databind/annotation/JsonPOJOBuilder.Value.html)

### Property annotations

27. Copy any Jackson annotations from POJO properties (for serialization) to Builder properties (for deserialization)
1. `@JsonProperty`
    1. Use [`@JsonProperty`](https://javadoc.io/doc/com.fasterxml.jackson.core/jackson-annotations/latest/com/fasterxml/jackson/annotation/JsonProperty.html) only when the json property name is non-standard
    1. Use [`@JsonProperty`](https://javadoc.io/doc/com.fasterxml.jackson.core/jackson-annotations/latest/com/fasterxml/jackson/annotation/JsonProperty.html) sparingly since annotations must be applied to the builder properties

## Derived & Cached fields

29. Add derived/cached property to the class
1. Assign the derived/cached value in the constructor
1. Ensure derived fields are **NOT** in the Builder
1. Mark derived fields `transient`
1. Expose the field via a getter method
1. Use [`@java.beans.Transient`](https://docs.oracle.com/javase/8/docs/api/java/beans/Transient.html) on getters, so Jackson will ignore

# Gotchas

1. **WARNING** Avoid [org.jetbrains.annotations.Nullable](https://www.jetbrains.com/help/idea/nullable-and-notnull-annotations.html) annotation since it's incompatible with [Jackson](https://github.com/FasterXML/jackson)
