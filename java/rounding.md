# Overview
1. Java Idioms for rounding doubles


# Idiom
```java
final double unrounded = ... ;
final double rounded = BigDecimal.valueOf(unrounded)
    .setScale(numDecimalPlaces, RoundingMode.HALF_UP)
    .doubleValue();
```
