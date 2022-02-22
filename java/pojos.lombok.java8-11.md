# Overview
1. [See the core doc first](./pojos.core.java8-11.md)
1. This just contains simplifications when using [Lombok](https://projectlombok.org/)


# Lombok based


replace @Data with @Value


# Gotchas
1. **WARNING** Avoid [org.jetbrains.annotations.Nullable](https://www.jetbrains.com/help/idea/nullable-and-notnull-annotations.html) annotation since it's incompatible with [Jackson](https://github.com/FasterXML/jackson)
1. **WARNING** Avoid [`lombok.@NonNull`](https://projectlombok.org/features/NonNull) on properties & builder (since builder should allow nullable)
