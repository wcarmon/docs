pluginManagement {
  plugins {
    id("com.github.ben-manes.versions") version "0.33.0"
    id("com.github.johnrengelman.shadow") version "6.0.0"
    id("com.gradle.build-scan") version "3.4.1"
    id("io.gitlab.arturbosch.detekt") version "1.16.0"

    // if using kotlin
    id("org.jetbrains.kotlin.plugin.allopen") version "1.6.0"
    id("org.jetbrains.kotlin.plugin.spring") version "1.6.0"
    id("org.springframework.boot") version "2.3.4.RELEASE" // bootRun
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
