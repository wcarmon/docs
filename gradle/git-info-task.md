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


# build.gradle (legacy)
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


# Docker
1. add `git` binary:
    1. `yum install -y -q git ...`
    1. `apt-get install -y git ...`
1. Ensure `.dockerignore` **lacks** `.git/`
1. `COPY --chown=appbuilder:appbuilder .git /home/appbuilder/.git`
1. `RUN git config --global --add safe.directory /home/appbuilder`


# Java record example
```java
/**
 * See build.gradle.kts, task called "writeGitHashToFile"
 */
@Builder
public record GitInfo(
    @Nullable Instant buildTS,
    @Nullable Instant gitCommitTS,
    String gitCommitHash,
    String gitlabCommitHash) {
    
    public static final String CLASSPATH_FOR_GIT_INFO_PROPERTIES = "/git-info.properties";
    private static final DateTimeFormatter TS_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss Z");
    
    public GitInfo {
        gitCommitHash = StringUtils.defaultIfBlank(gitCommitHash, "");
        gitlabCommitHash = StringUtils.defaultIfBlank(gitlabCommitHash, "");
    }
    
    public static GitInfo empty() {
        return GitInfo.builder().build();
    }
    
    @SneakyThrows
    public static GitInfo readFromClasspath(String classpath) {
        
        final Properties properties = new Properties();
        try (final InputStream inputStream = 
                GitInfo.class.getResourceAsStream(classpath)) {
                
            properties.load(inputStream);
        }
        
        final String clean0 = StringUtils.defaultIfBlank(properties.getProperty("build.ts"), "")
                .replaceAll("'", "")
                .replaceAll("\"", "")
                .strip();
        final OffsetDateTime buildTS = OffsetDateTime.parse(clean0, TS_FORMATTER);
        
        // -- git log -1 --format='%ci'
        // -- eg. '2024-09-13 12:35:54 -0400'
        final String clean1 = StringUtils.defaultIfBlank(properties.getProperty("git.commit.ts"), "")
                .replaceAll("'", "")
                .replaceAll("\"", "")
                .strip();
        final OffsetDateTime buildTS = OffsetDateTime.parse(clean1, TS_FORMATTER);
        
        return GitInfo.builder()
                .buildTS(buildTS.toInstant())
                .gitCommitHash(StringUtils.defaultIfBlank(properties.getProperty("git.commit.hash"), "").trim())
                .gitCommitTS(gitCommitTS.toInstant())
                .gitlabCommitHash(StringUtils.defaultIfBlank(properties.getProperty("gitlab.commit.hash"), "").trim())                
                .build();
    }
}
```
