# Overview
1. Reading and writing Gradle properties


# Custom task to print project properties sorted
```kts
task("printProperties") {
    doLast {
        val sortedProperties = sortedMapOf<String, Any>()
        sortedProperties.putAll(project.properties)

        println("Project properties: (count=${sortedProperties.size})")
        sortedProperties.forEach { (key, value) ->
            println("$key = $value\n")
        }
    }
}
```


# Printing properties
```bash
# -- Print variables/properties available for use in scripts
./gradlew properties -q | sort

# -- Using custom task above
./gradlew printProperties
```


# Other resources
1. https://docs.gradle.org/current/userguide/build_environment.html#sec:gradle_configuration_properties
1. https://docs.gradle.org/current/userguide/writing_build_scripts.html#properties