# Overview
1. Example of "idiomatic" POJO
1. See also, [JSON POJO example](./pojo.example-2.md)
1. See also, [Lombok POJO examples](./pojos.lombok.java8-11.md)

# Example
```java
/**
 * TODO: add a brief description of purpose...
 * TODO: if this maps to a DB table, list that here...
 */
public final class Employee {

  private final boolean active;

  /**
   * [16, 100]
   */
  private final int age;

  /**
   * [a-zA-Z-]{2,64}
   */
  private final String name;

  private final LocalDate startDate;

  private Employee(Builder builder) {

    // Example of default value
    active = Optional.ofNullable(builder.active).orElse(true);
    age = builder.age;
    name = builder.name;
    startDate = builder.startDate;

    // -- Validations
    Preconditions.checkArgument(age <= 100, "age is too high: " + age);
    Preconditions.checkArgument(age >= 16, "age is too low: " + age);

    requireNonNull(startDate, "startDate is required and missing.");
    //TODO: other validations go here
  }

  public static Builder newBuilder() {
    return new Builder();
  }

  public static Builder newBuilder(Employee copy) {
    Builder builder = new Builder();
    builder.active = copy.active;
    builder.age = copy.age;
    builder.name = copy.name;
    builder.startDate = copy.startDate;
    return builder;
  }

  //NOTE: generated getters, hashcode, equals, toString appear here

  public static final class Builder {
    private Boolean active;
    private int age;
    private String name;
    private LocalDate startDate;

    private Builder() {
    }

    public Builder active(boolean active) {
      this.active = active;
      return this;
    }

    public Builder age(int age) {
      this.age = age;
      return this;
    }

    public Employee build() {
      return new Employee(this);
    }

    public Builder name(String name) {
      this.name = name;
      return this;
    }

    public Builder startDate(LocalDate startDate) {
      this.startDate = startDate;
      return this;
    }
  }
}
```
