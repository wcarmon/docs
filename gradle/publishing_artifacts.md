# Overview
1. How to sign & publish jar artifacts to Maven central using Gradle


# Gotcha
1. Once you release an artifact, it is immutable/forever


# Create public git repo
1. eg. [via github](https://docs.github.com/en/repositories/creating-and-managing-repositories/quickstart-for-repositories)


# Setup Sonatype account (OSSRH)
1. https://issues.sonatype.org/secure/Signup!default.jspa


# Setup maven coordinate (group)
1. [Example jira ticket](https://issues.sonatype.org/browse/OSSRH-97577)
1. Once per `groupId` (reuse the same one for different artifacts)


# Setup Signing via gpg
1. See [publishing_gpg.md](./publishing_gpg.md) doc


# Build, Sign, Publish
```sh
./gradlew clean spotlessApply build sign -x test -q;

# -- Build hashes
for JAR_FILE in ./build/libs/*.jar; do
  md5sum "$JAR_FILE" > "$JAR_FILE.md5"
  sha1sum "$JAR_FILE" > "$JAR_FILE.sha1"
  # sha256sum "$JAR_FILE" > "$JAR_FILE.sha256"
  # sha512sum "$JAR_FILE" > "$JAR_FILE.sha512"
done

# -- Verify
ls -hl ./build/libs/

# -- This creates a staging repository in Nexus
./gradlew publish -q
```


# (Manually) release to public
1. [https://s01.oss.sonatype.org](https://s01.oss.sonatype.org)
    1. Login with OSSRH jira credentials
1. Click **Staging Repositories** on the left
1. (Optional) Evaluate artifact contents of release
1. Click **Close** (Top)
1. On the dialog, Click **Confirm**
    1. If it fails, **Drop** & make corrections
1. Click **Release** (Top)
    1. (Nexus will auto-delete the staging repository after deployment)
1. Takes between 20-minutes and 2-hours to become public


# Automatic release
1. TODO: Nexus Staging Maven plugin


# Verify
1. via maven:
```bash
mvn dependency:get \
-DremoteRepositories=maven.apache.org \
-Dartifact=io.github.wcarmon:property-utils-jvm:1.0.0:jar
```
1. via browser: [https://central.sonatype.com](https://central.sonatype.com)
    1. eg. `https://central.sonatype.com/artifact/io.github.wcarmon/lock-utils-jvm`



# Git tag
```bash
git tag v1.0.1
git push origin --tags
```


# Other resources
1. [Example jira ticket](https://issues.sonatype.org/browse/OSSRH-97577)
1. [Terms/Agreement](https://central.sonatype.org/publish/producer-terms)
1. https://central.sonatype.org/publish/release/
1. https://central.sonatype.org/publish/requirements/#a-complete-example-pom
1. https://central.sonatype.org/publish/requirements/#license-information
1. https://central.sonatype.org/publish/requirements/#supply-javadoc-and-sources
1. https://docs.gradle.org/current/userguide/publishing_maven.html
1. https://www.jetbrains.com/help/space/publish-artifacts-to-maven-central.html
