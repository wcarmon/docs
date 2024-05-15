# Overview
1. Example gradle tasks for writing git-info to src/main/resources


# build.gradle.kts
```kts
import java.io.ByteArrayOutputStream
import java.io.OutputStream
import java.time.format.DateTimeFormatter
import java.time.Instant
import java.time.ZoneOffset

...

// Writes git info into src/main/resources, so server can expose
task("writeGitHashToFile") {

    // -- Get git commit hash
    val stdout: OutputStream = ByteArrayOutputStream()
    exec {
        commandLine("git", "rev-parse", "HEAD")
        standardOutput = stdout
    }

    val gitHash: String = stdout.toString().trim()
    stdout.close()

    // -- Get git commit timestamp
    stdout = ByteArrayOutputStream()
    exec {
        commandLine("git", "log", "-1", "--format='%ci'")
        standardOutput = stdout
    }

    val gitTS: String = stdout.toString().trim()
    stdout.close()

    val formatter: DateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss Z")
    val buildTS: String = formatter.format(Instant.now().atOffset(ZoneOffset.UTC))

    val gitHashFromGitlab: String = (System.getenv("CI_COMMIT_SHA") ?: "").trim()

    // -- Write file
    val gitInfoFile: File = File(
        project.projectDir,
        "src/main/resources/git-info.properties")

    gitInfoFile.createNewFile()
    gitInfoFile.writeText("") // truncate

    gitInfoFile.appendText("build.ts=${buildTS}\n")
    gitInfoFile.appendText("git.commit.hash=${gitHash}\n")
    gitInfoFile.appendText("git.commit.ts=${gitTS}\n")
    gitInfoFile.appendText("gitlab.commit.hash=${gitHashFromGitlab}\n")
}

// -- Run whenever compiling java
tasks.named<JavaCompile>("compileJava") {
    dependsOn("writeGitHashToFile")
}
```


# build.gradle
```gradle
// Writes git info into src/main/resources, so server can expose
task writeGitHashToFile() {

    // -- Get git commit hash
    OutputStream stdout = new ByteArrayOutputStream()
    exec {
        commandLine "git", "rev-parse", "HEAD"
        standardOutput = stdout
    }

    final String gitHash = stdout.toString().trim()
    stdout.close()

    // -- Get git commit timestamp
    stdout = new ByteArrayOutputStream()
    exec {
        commandLine "git", "log", "-1", "--format="%ci""
        standardOutput = stdout
    }

    final String gitTS = stdout.toString().trim()
    stdout.close()

    final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss Z")
    final String buildTS = formatter.format(Instant.now().atOffset(ZoneOffset.UTC))

    // -- Write file
    final File gitInfoFile = new File(
        project.projectDir,
        "src/main/resources/git-info.properties")

    gitInfoFile.createNewFile()
    gitInfoFile.write("") // truncate

    gitInfoFile.append("git.commit.hash=${gitHash}\n")
    gitInfoFile.append("git.commit.ts=${gitTS}\n")
    gitInfoFile.append("build.ts=${buildTS}\n")
}

// -- Run whenever compiling java
compileJava.dependsOn("writeGitHashToFile")
```
