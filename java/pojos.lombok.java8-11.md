# Overview
1. [See the core Java doc first](./pojos.core.java8-11.md)
1. This doc contains simplifications when using [Lombok](https://projectlombok.org/)


# What is [Lombok](https://projectlombok.org/)?
1. A tool to reduce java boilerplate
1. An annotation processor (runs before every build)
1. Intellij has [native support](https://projectlombok.org/setup/intellij) for Lombok since ver. [2020.3](https://www.jetbrains.com/idea/whatsnew/2020-3/)
    1. No plugin required


# Big picture
1. [See Core Java](./pojos.core.java8-11.md)


# Examples
1. [Basic POJO](./pojo.example-3.md)
1. [JSON compatible POJO](./pojo.example-4.md)


# Lombok POJO Checklist
1. Select a good name for the POJO
1. Add a **brief** class comment, short description of purpose

## Class annotations
3. Add [`@Builder(builderClassName = "Builder", builderMethodName = "newBuilder", toBuilder = true)`](https://projectlombok.org/features/Builder)
1. Add [`@Value`](https://projectlombok.org/features/Value) annotation to class
    1. Automatically generates `hashcode()` & `equals(...)` methods
    1. Automatically generates `toString()` method
    1. Automatically marks all fields `private final`
    1. Automatically generates Getters

## Properties
6. Define the properties
    1. Aggressively avoid [String](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html) properties.  [Why?](./strings.avoid.md)
    1. Use the [right collection](./collection.selecting.md)
1. Use modern Java types for properties
    1. Modern core types are immutable
        1. eg. [java.time](https://docs.oracle.com/javase/8/docs/api/java/time/package-summary.html)
        1. TODO: add more examples
1. Prefer [primitive](https://docs.oracle.com/javase/tutorial/java/nutsandbolts/datatypes.html) properties (when sensible)
1. Rely on [jvm defaults](https://docs.oracle.com/javase/tutorial/java/nutsandbolts/datatypes.html) for properties (when sensible)
1. [Auto-sort your properties](https://www.jetbrains.com/help/idea/rearrange-code.html#create-matching-rules)
    1. This provides consistent behavior for all lombok annotations

## Builder
11. Use [Intellij](https://www.jetbrains.com/help/idea/generating-code.html#generate-constructors) or [delombok](https://projectlombok.org/features/delombok) action to generate an all-args constructor
    1. **Verify**: constructor is `private`
    1. **Verify**: constructor has all the arguments (in predictable order)

## Constructor
TODO: more here


## Setting Defaults
TODO: more here


## Extras for supporting Jackson
TODO: more here


## Cached fields
TODO: more here


## Derived fields
TODO: more here


# Gotchas
1. Lombok's builder assumes an all-args constructor instead of a `builder` instance
1. **WARNING** Avoid [`lombok.@NonNull`](https://projectlombok.org/features/NonNull) on properties & builder (since builder should allow nullable)
1. **WARNING** Avoid [org.jetbrains.annotations.Nullable](https://www.jetbrains.com/help/idea/nullable-and-notnull-annotations.html) annotation since it's incompatible with [Jackson](https://github.com/FasterXML/jackson)
1. **WARNING** Avoid `@Data` since it promotes mutability
1. **WARNING** Avoid `lombok.@Builder.Default`: Incompatible with Jackson, Constructor validation, fights with core java




--------------------------
## Builder
### (**Not** recommended) if using lombok for builder
1. Add [`@Jacksonized`](https://projectlombok.org/features/experimental/Jacksonized)



1. Add [`@AllArgsConstructor(access = AccessLevel.PRIVATE)`](https://projectlombok.org/features/constructor)
    1. Unfortunately `@Value` exposes the all args constructor
    1. The annotation above fixes that by marking it private
    1. AllArgsConstructor is an anti-pattern because it relies on property definition order (which is brittle)
