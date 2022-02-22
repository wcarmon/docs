# Overview
1. [See the core doc first](./pojos.core.java8-11.md)
1. This just contains simplifications when using [Lombok](https://projectlombok.org/)


# Lombok based


replace @Data with @Value


# Gotchas
1. **WARNING** Avoid [org.jetbrains.annotations.Nullable](https://www.jetbrains.com/help/idea/nullable-and-notnull-annotations.html) annotation since it's incompatible with [Jackson](https://github.com/FasterXML/jackson)
1. **WARNING** Avoid [`lombok.@NonNull`](https://projectlombok.org/features/NonNull) on properties & builder (since builder should allow nullable)
1. **WARNING** Avoid `@AllArgsConstructor`, pass builder instance instead



## Builder
### (**Not** recommended) if using lombok for builder
1. `@Builder(toBuilder = true, builderClassName = "Builder")`
1. Add [`@Jacksonized`](https://projectlombok.org/features/experimental/Jacksonized)



1. **WARNING** Avoid `lombok.@Builder.Default`: Incompatible with Jackson, Constructor validation, fights with core java