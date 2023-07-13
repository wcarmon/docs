# Overview
1. How to debug gradle components (like plugins) using breakpoints

# Debugging gradle
1. Run gradle via terminal
```sh
PORT=5005;
TASK=clean;

./gradlew $TASK \
-Dorg.gradle.daemon.debug=false \
-Dorg.gradle.debug.port=$PORT \
-Dorg.gradle.debug.server=true \
-Dorg.gradle.debug.suspend=true \
-Dorg.gradle.debug=true \
--no-daemon;
```
1. Gradle will pause
1. Add breakpoint in your gradle component (eg. a plugin source file)
1. TODO: intellij remote debug configuration on port 5005


# Print properties
```bash
gradle properties
```
1. Also prints `project.ext` variables
