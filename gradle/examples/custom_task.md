# Overview
1. Example of custom gradle task
1. Example of printing system properties


# Custom task
```kts
// Run: ./gradlew properties -q

// Run: ./gradlew printStuff -q
tasks.register("printStuff") {
    println(System.getProperty("java.home"))
}

...
```
