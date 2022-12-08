# Overview
1. How to make a [fat jar/uberjar](TODO)


# `build.gradle.kts` snippet
```kts
import com.github.jengelman.gradle.plugins.shadow.tasks.ShadowJar
...

plugins {
    ...
    id("com.github.johnrengelman.shadow") version "7.1.2" apply true
    ...
}

// or: apply(plugin = "com.github.johnrengelman.shadow")
...

tasks.withType<Jar>() {
    duplicatesStrategy = DuplicatesStrategy.FAIL // safer
    //duplicatesStrategy = DuplicatesStrategy.WARN // less annoying
    
    manifest {
        attributes["Main-Class"] = "com.whatever.FooMain"
    }
}

tasks.withType<ShadowJar>() {
    append("application.properties")
    
    archiveBaseName.set("app")
    archiveClassifier.set("")   // removes "-all" suffix from jar name
    archiveVersion.set("")      // removes version from jar name

    dependencies {
      exclude(dependency(group = "...", module = "..."))
    }
 
    manifest {
        attributes["Main-Class"] = "com.whatever.FooMain"
    }
    
    mergeServiceFiles()
       
    exclude("*.bin")
    exclude("*.css")
    exclude("*.dtd")
    exclude("*.htm")
    exclude("*.html")
    exclude("*.java")
    exclude("*.proto")
    exclude("*.xsd")
    exclude("application-data-viz-server.properties")
    exclude("com/sun/el/*")
    exclude("dependencies.properties")
    exclude("drools.*.properties")
    exclude("ecj.1")
    exclude("functions.properties")
    exclude("Log4j-charsets.properties")
    exclude("log4j2.springboot")
    exclude("META-INF/*.json")
    exclude("META-INF/*.kotlin_module")
    exclude("META-INF/*.properties")
    exclude("META-INF/*.versions")
    exclude("META-INF/*android*")
    exclude("META-INF/*android*/**")
    exclude("META-INF/*DEPENDENCIES*")
    exclude("META-INF/*LICENSE*")
    exclude("META-INF/*license*")
    exclude("META-INF/*native*")
    exclude("META-INF/*NOTICE*")
    exclude("META-INF/*notice*")
    exclude("META-INF/*version*")
    exclude("META-INF/*VERSION*")
    exclude("META-INF/com.android.tools/**")
    exclude("META-INF/MANIFEST.MF")
    exclude("META-INF/maven/**")
    exclude("META-INF/native*/**")
    exclude("META-INF/org/apache/**")
    exclude("META-INF/proguard/**")
    exclude("META-INF/versions/**")
    exclude("module-info.class")
    exclude("mozilla/**")
    exclude("onnxops.json")
    exclude("storage.v1.json")
    exclude("XMLPULL_1_1_3_1_VERSION")
    exclude("XPP3_1.1.4c_MIN_VERSION")

    // -- Spring factories need this
    // exclude("META-INF/spring.*")    
}
```


# Other resources
1. TODO
