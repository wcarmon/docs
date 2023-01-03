pluginManagement {
  plugins {
    // for fat-jar/uber-jar
    id("com.github.johnrengelman.shadow") version "6.0.0"

    // For analyzing builds
    id("com.gradle.build-scan") version "3.4.1"

    // For finding old dependencies
    id("com.github.ben-manes.versions") version "0.33.0"

    // if using kotlin
    id("org.jetbrains.kotlin.plugin.allopen") version "1.6.0"
    id("org.jetbrains.kotlin.plugin.spring") version "1.6.0"
    id("io.gitlab.arturbosch.detekt") version "1.16.0"

    // if using spring boot (eg. bootRun task)
    id("org.springframework.boot") version "2.3.4.RELEASE"
  }

  repositories {
    mavenLocal()
    mavenCentral()

    jcenter()
    gradlePluginPortal()
  }
}

dependencyResolutionManagement {
  repositories {
    mavenLocal()
    mavenCentral()

    google()
    gradlePluginPortal()
  }
}

rootProject.name = "some-awesome-project"

include(
  "module-1",
  "module-2",
  "module-3"
  //... add other modules here
)


/*
-- Example of how to reference local gradle project dependency:

include(":my-local-only-project") // must be before the project line
project(":my-local-only-project").projectDir = File("/home/wcarmon/git-repos/my-local-only-project")
*/
