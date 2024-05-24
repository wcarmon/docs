# Overview
1. Steps to setup a new Github repo, with a public, published jar artifact


# Steps
1. Choose a name (eg. "foo-utils-jvm")
1. Choose a License (eg. MIT)
1. Create new repo in GitHub
1. clone (git+ssh)
1. Update License (add your name or organization name)
1. `settings.gradle.kts`
    1. rootProject.name = "foo-utils-jvm"
1. `gradle wrap`
1. Open in IDE
1. copy `.gitignore`
1. copy `.gitattributes`
1. `git add`
1. Make `build.gradle.kts`
    1. set mvnArtifactId
    1. set dependencies
1. Make source tree
    1. `mkdir -p src/{main,test}/{java,resources}/`
    1. `mkdir -p src/{main,test}/java/io/github/`
1. Choose a package
    1. io.github.<your-name>.<subject>
1. `module-info.java` file
    1. `touch src/main/java/module-info.java`
1. Make `readme.md`
1. Write source code
1. IDEA:
    1. Move panels to Right-Top


# Publish
- See [publish doc](../gradle/publishing_artifacts.md)
