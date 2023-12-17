# Overview
1. How to sign & publish artifacts to Maven central

# Gotcha
1. Once you upload a release, it is immutable


# Setup Sonatype (OSSRH)
1. https://issues.sonatype.org/secure/Signup!default.jspa


# Setup signing
```sh
gpg --gen-key;

# Verify
gpg --list-keys;
gpg --list-secret-keys --keyid-format LONG;
```


# Backup gpg key
```sh
export BACKUP_FILE=~/private.gpg.backup;
gpg -o $BACKUP_FILE \
--export-options backup \
--export-secret-keys java@wcarmon.com
```

# Restore gpg key
```sh
gpg --import-options restore --import $BACKUP_FILE
```


# Update ~/.gradle/gradle.properties
1. See [`./examples/gradle.properties`](./examples/gradle.properties)


# Distribute your Public key
```sh
# -- about 40 chars, uppercase hexidecimal string
# -- gpg -K;
KEY_ID=...

gpg --keyserver keys.openpgp.org --send-keys $KEY_ID;
gpg --keyserver keyserver.ubuntu.com --send-keys $KEY_ID;
gpg --keyserver pgp.mit.edu --send-keys $KEY_ID;
```



-- == -- == -- == -- == -- == -- == -- == -- == -- == -- == -- == -- ==
TODO:
```
mavenCentralUsername=...
mavenCentralPassword=...
```


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
1. TODO ...


# Unorganized
1. https://central.sonatype.org/publish/publish-guide/
1. https://dzone.com/articles/how-to-publish-artifacts-to-maven-central
1. Automate ...
    1. version bump
-- == -- == -- == -- == -- == -- == -- == -- == -- == -- == -- == -- ==



# Other resources
1. [Example jira ticket](https://issues.sonatype.org/browse/OSSRH-97577)
1. https://central.sonatype.org/publish/release/
1. https://central.sonatype.org/publish/requirements/#a-complete-example-pom
1. https://central.sonatype.org/publish/requirements/#license-information
1. https://central.sonatype.org/publish/requirements/#supply-javadoc-and-sources
1. https://docs.gradle.org/current/userguide/publishing_maven.html
1. https://www.jetbrains.com/help/space/publish-artifacts-to-maven-central.html
1. [Terms/Agreement](https://central.sonatype.org/publish/producer-terms)


## Signing
1. https://central.sonatype.org/publish/requirements/gpg/
1. https://docs.gradle.org/current/userguide/signing_plugin.html
