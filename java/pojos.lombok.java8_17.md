# Overview

1. For Core Java (no lombok), [See the core Java doc](./pojos.core.java8_17.md)
1. Contains simplifications when using [Lombok](https://projectlombok.org/)
1. Building an idiomatic POJO in Java 8-17 is **non-trivial** (before [Records](https://docs.oracle.com/en/java/javase/14/language/records.html))
    1. Even with Lombok, it's non-trivial

# Table of Contents

- [What is Lombok?](#what-is-lombok)
- [Big picture](#big-picture)
- [Examples](#examples)
- [Lombok POJO Checklist](#lombok-pojo-checklist)
    * [Class annotations](#class-annotations)
    * [Properties](#properties)
    * [Builder](#builder)
    * [Constructor](#constructor)
    * [Setting Defaults](#setting-defaults)
    * [Extras for supporting Jackson](#extras-for-supporting-jackson)
        + [Class annotations](#class-annotations-1)
        + [Constructor annotations](#constructor-annotations)
        + [Property annotations](#property-annotations)
    * [Derived & Cached fields](#derived---cached-fields)
- [Gotchas](#gotchas)

--------

# What is [Lombok](https://projectlombok.org/)?

1. A tool to reduce java boilerplate
1. An [annotation processor](https://docs.oracle.com/javase/8/docs/api/javax/annotation/processing/Processor.html) (runs before every [`javac`](https://docs.oracle.com/en/java/javase/11/tools/javac.html))
1. Intellij has [native support](https://projectlombok.org/setup/intellij) for Lombok since ver. [2020.3](https://www.jetbrains.com/idea/whatsnew/2020-3/)
    1. No plugin required

# Big picture

1. [See Core Java](./pojos.core.java8-17.md#big-picture)

# Examples

1. [Basic Lombok POJO](./pojo.example_3.md)
1. [Jackson compatible Lombok POJO](./pojo.example_4.md)

# Lombok POJO Checklist

1. Select a good name for the POJO
1. Add a **brief** class comment, short description of purpose

## Class annotations

3. Add [`@Value`](https://projectlombok.org/features/Value) annotation to class.
    1. Automatically generates [`hashcode()`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Object.html#hashCode()) & [`equals(...)`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Object.html#equals(java.lang.Object)) methods
    1. Automatically generates [`toString()`](https://docs.oracle.com/javase/8/docs/api/java/lang/Object.html#toString--) method
    1. Automatically marks all fields [`private final`](https://docs.oracle.com/javase/tutorial/essential/concurrency/imstrat.html)
    1. Automatically generates Getters
    1. Automatically marks the class `final`

## Properties

4. Define the properties
    1. Aggressively avoid [String](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html) properties.  [Why?](./strings.avoid.md)
    1. Use the [correct collection](./collections.selecting.md)
1. Use modern Java types for properties
    1. Modern core types are immutable
        1. eg. [java.time](https://docs.oracle.com/javase/8/docs/api/java/time/package-summary.html)
        1. TODO: add more examples
1. Prefer [primitive](https://docs.oracle.com/javase/tutorial/java/nutsandbolts/datatypes.html) properties (when sensible)
1. Rely on [jvm defaults](https://docs.oracle.com/javase/tutorial/java/nutsandbolts/datatypes.html) for properties (when sensible)
1. [Auto-sort your properties](https://www.jetbrains.com/help/idea/rearrange-code.html#create-matching-rules)
    1. Provides consistent behavior for all lombok annotations
1. Add javadoc for **all** String properties: [Why?](./strings.avoid.md)

## Builder

10. Use [Intellij](https://www.jetbrains.com/help/idea/generating-code.html#generate-constructors) or [delombok](https://projectlombok.org/features/delombok) to generate an all-args constructor
    1. **Verify**: constructor is `private`
    1. **Verify**: constructor has all the arguments (in predictable order)
        1. This should be easy since intellij will complain if you omit a property
1. Add [`@lombok.Builder(builderClassName = "Builder", builderMethodName = "newBuilder", toBuilder = true)`](https://projectlombok.org/features/Builder) to the constructor.
    1. These two re-names align with other standard builders
    1. TODO: they have a bug [("cannot find symbol")](https://github.com/projectlombok/lombok/wiki/LOMBOK-CONCEPT:-Resolution) when you set `builderMethodName`
    1. If you add `@Builder` to the constructor, any class level generics may not work

## Constructor

12. Do defensive copy on collections
    1. [`ImmutableList.copyOf(...)`](https://guava.dev/releases/31.0-jre/api/docs/com/google/common/collect/ImmutableList.html#copyOf(java.lang.Iterable))
    1. [`ImmutableSet.copyOf(...)`](https://guava.dev/releases/31.0.1-jre/api/docs/com/google/common/collect/ImmutableSet.html#copyOf(java.util.Collection))
    1. [`ImmutableMap.copyOf(...)`](https://guava.dev/releases/31.0-jre/api/docs/com/google/common/collect/ImmutableMap.html#copyOf(java.util.Map))
1. Add field [validation (Preconditions)](./preconditions.md) to the constructor (after assignments)
    1. eg. non-null checks, string patterns, number ranges, date ranges, ...

## Setting Defaults

14. Set default values in constructor, after assignments
    1. Use non-primitive type in constructor argument to replace `null` with a default value
1. For Strings, use [`org.apache.commons.lang3.StringUtils.defaultIfBlank(...)`](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/StringUtils.html)
1. For Strings, prefer `""` over null String
1. For non-string objects, use [`Optional.ofNullable(...).orElseGet(...)`](https://docs.oracle.com/javase/8/docs/api/java/util/Optional.html)
    1. **Legacy code**: For non-string objects, use [`ObjectUtils.defaultIfNull(...)`](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/ObjectUtils.html)
1. Default collections to empty (`List.of()`, `Set.of()`, `Map.of()`) instead of `null`
    1. **Legacy code**: Default collections to empty ([`Collections.emptyList()`](https://docs.oracle.com/javase/8/docs/api/java/util/Collections.html#emptyList--), [`Collections.emptySet()`](https://docs.oracle.com/javase/8/docs/api/java/util/Collections.html#emptySet--), [`Collections.emptyMap()`](https://docs.oracle.com/javase/8/docs/api/java/util/Collections.html#emptyMap--)) instead of `null`

## Extras for supporting Jackson

### Class annotations

19. Add [`@JsonIgnoreProperties({"\u0024schema", "\u0024id"})`](https://www.javadoc.io/doc/com.fasterxml.jackson.core/jackson-annotations/latest/com/fasterxml/jackson/annotation/JsonIgnoreProperties.html)
    1. Allows `$id` and `$schema` properties in json for deserializing
    1. [Learn more here](https://json-schema.org/)
1. Add [`@JsonPropertyOrder(alphabetic = true)`](https://www.javadoc.io/doc/com.fasterxml.jackson.core/jackson-annotations/2.13.0/com/fasterxml/jackson/annotation/JsonPropertyOrder.html)
    1. Provides predictable order for serialized json (simplifies testing, caching, etc)

### Constructor annotations

21. Add [`@Jacksonized`](https://projectlombok.org/features/experimental/Jacksonized) to `private` constructor

### Property annotations

22. `@JsonProperty`
    1. Use [`@JsonProperty`](https://javadoc.io/doc/com.fasterxml.jackson.core/jackson-annotations/latest/com/fasterxml/jackson/annotation/JsonProperty.html) only when the json property name is non-standard
    1. Use [`@JsonProperty`](https://javadoc.io/doc/com.fasterxml.jackson.core/jackson-annotations/latest/com/fasterxml/jackson/annotation/JsonProperty.html) sparingly since annotations must be applied to the builder properties

## Derived & Cached fields

23. Add derived property to the class, but **NOT** as a constructor argument
    1. `@Builder` will ignore them (which is good)
    1. `@Value` will create a getter (which is good)
1. Assign the derived/cached value in the constructor
1. Mark derived fields `transient`
1. Use [`@java.beans.Transient`](https://docs.oracle.com/javase/8/docs/api/java/beans/Transient.html) on getters, so Jackson will ignore

# Gotchas

1. Lombok [hacks the compiler](https://projectlombok.org/contributing/lombok-execution-path)
    1. Sometimes the simplest solution is to use lombok, then [delombok](https://projectlombok.org/features/delombok)
1. Lombok's builder assumes an all-args constructor instead of a `builder` instance
1. **WARNING** Avoid [`lombok.@NonNull`](https://projectlombok.org/features/NonNull) on properties & builder (since builder should allow nullable)
1. **WARNING** Avoid [org.jetbrains.annotations.Nullable](https://www.jetbrains.com/help/idea/nullable-and-notnull-annotations.html) annotation since it's incompatible with [Jackson](https://github.com/FasterXML/jackson)
1. **WARNING** Avoid `@Data` since it promotes mutability
1. **WARNING** Avoid `lombok.@Builder.Default`: Incompatible with Jackson, Constructor validation, fights with core java

## Delombok Builder

1. After [delomboking](https://projectlombok.org/features/delombok) a [`@Builder`](https://projectlombok.org/features/Builder)...
1. Make the `Builder` class `final`: `public static final class Builder {`
1. Make the `Builder` class `private`
1. replace `toBuilder()` with `public static Builder newBuilder(Foo copy)`
