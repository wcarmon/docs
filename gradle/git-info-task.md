# Overview
1. Example gradle tasks for writing git-info to src/main/resources



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
