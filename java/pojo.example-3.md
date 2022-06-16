# Overview
1. Example of "idiomatic", Lombok, Java 8-17 POJO
1. See also, [detailed explanation](./pojos.lombok.java8-17.md)
1. See also, [Jackson ready lombok POJO example](./pojo.example-4.md)
1. See also, [core Java POJO examples](./pojos.core.java8-17.md)

# POJO Example
```java
/**
 * TODO: add a BRIEF description of purpose
 * TODO: if this POJO aligns with a DB table, mention that here
 */
@Value
public class Employee {

  boolean active;

  /**
   * [16, 100]
   */
  int age;

  /**
   * [a-zA-Z-]{2,64}
   * eg. "Wil"
   */
  String name;

  LocalDate startDate;

  @lombok.Builder(
    builderClassName = "Builder",
    //builderMethodName = "newBuilder", // <-- they have a bug here
    toBuilder = true)
  private Employee(
    Boolean active,  // <-- non-primitive allows you to default the value
    int age,
    String name,
    LocalDate startDate) {

    this.active = Optional.ofNullable(active).orElse(true);
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

# Usage Example
```java
    Employee wil = Employee.newBuilder()
      .age(35)
      .name("Wil C")
      .startDate(LocalDate.of(2020, 01, 31))
      .build();

    // NOTE: wil.active is defaulted to true
```

