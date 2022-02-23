# Overview
1. Example of "idiomatic", Lombok, Jackson, Java 8-11 POJO
1. See also, [detailed explanation](./pojos.lombok.java8-11.md)
1. See also, [core Java POJO examples](./pojos.core.java8-11.md)

# Example
```java
/**
 * TODO: add a BRIEF description of purpose
 * TODO: if this POJO aligns with a DB table, mention that here
 */
@Jacksonized
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

  @JsonProperty("firstDayOnTheJob")
  LocalDate startDate;

  @lombok.Builder(
    builderClassName = "Builder",
    builderMethodName = "newBuilder",
    toBuilder = true)
  public Employee(
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
