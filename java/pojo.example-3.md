# Overview
1. Example of "idiomatic", Lombok, Java 8-11 POJO
1. See also, [core Java POJO examples](./pojos.core.java8-11.md)
1. See also, [Jackson ready lombok POJO example](./pojo.example-4.md)

# Example
```java
@Builder(
  builderClassName = "Builder",
  builderMethodName = "newBuilder",
  toBuilder = true)
@Value
public class Foo {

  boolean active;

  /**
   * [16, 100]
   */
  int age;

  /**
   * [a-zA-Z-]{2,64}
   */
  String name;

  LocalDate startDate;

  public Foo(
    boolean active,
    int age,
    String name,
    LocalDate startDate) {

    this.active = active;
    this.age = age;
    this.name = name;
    this.startDate = startDate;

    // -- Validations
    checkArgument(age <= 100, "age is too high: " + age);
    checkArgument(age >= 16, "age is too low: " + age);

    checkArgument(isNotBlank(name), "name is required");

    requireNonNull(startDate, "startDate is required and missing.");

    //TODO: other validations go here
  }
}
```

