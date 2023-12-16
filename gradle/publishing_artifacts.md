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


TODO: gpg --keyserver keys.openpgp.org --send-keys yourKey


TODO: ~/.gradle/gradle.properties
```
mavenCentralUsername=xxx
mavenCentralPassword=xxx

# -- Get key: gpg -K
signing.keyId=zzz
signing.password=zzz
# signing.secretKeyRingFile=/home/wcarmon/.gnupg/trustdb.gpg
signing.secretKeyRingFile=/home/wcarmon/.gnupg/pubring.kbx
```


# Deploy
```sh
./gradlew generatePomFileForPubNamePublication -q

./gradlew publish -q

./gradlew publishPubNamePublicationToMavenLocal -q
```
1. takes between 10-minutes and 2 hours to reflect new artifacts



# Unorganized
1. https://central.sonatype.org/publish/release/#releasing-deployment-from-ossrh-to-the-central-repository-introduction
1. https://central.sonatype.org/publish/requirements/#supply-javadoc-and-sources
1. https://www.jetbrains.com/help/space/publish-artifacts-to-maven-central.html
1. https://medium.com/geekculture/how-to-publish-artifacts-on-maven-central-24342fd286cd
1. https://central.sonatype.org/publish/producer-terms
1. https://central.sonatype.org/publish/publish-guide/
1. https://dzone.com/articles/how-to-publish-artifacts-to-maven-central
1. PGP signature
    1. https://central.sonatype.org/publish/requirements/gpg/
    1. https://central.sonatype.org/publish/requirements/#sign-files-with-gpgpgp
1. minimize deps
1. choose a license
    1.
    1. What did I use for my golang otzap?
    1. https://choosealicense.com/
1. Sonatype: Open Source Software Repository Hosting (OSSRH)
1. Bill of materials approach
1. javadoc artifact - https://central.sonatype.org/publish/requirements/#supply-javadoc-and-sources
1. source artifact - https://central.sonatype.org/publish/requirements/#supply-javadoc-and-sources
1. checksums - https://central.sonatype.org/publish/requirements/#provide-files-checksums
1. metadata - https://central.sonatype.org/publish/requirements/#sufficient-metadata
    1. https://central.sonatype.org/publish/requirements/#project-name-description-and-url
    1. https://central.sonatype.org/publish/requirements/#developer-information
    1. https://central.sonatype.org/publish/requirements/#scm-information
1. credentials - https://central.sonatype.org/publish/publish-gradle/#credentials
1. Automate ...
    1. https://central.sonatype.org/publish/publish-gradle
    1. version bump
    1. building binary, source & javadoc artifacts
    1. signing
    1. deployment
        1. https://s01.oss.sonatype.org
        1. gradle uploadArchives


# Done
1. ~~select maven coordinates~~
1. ~~github repo~~


# Other resources
1. Example jira ticket: https://issues.sonatype.org/browse/OSSRH-97577
1. https://central.sonatype.org/publish/requirements/#license-information
1. https://central.sonatype.org/publish/requirements/#supply-javadoc-and-sources
1. https://docs.gradle.org/current/userguide/publishing_maven.html
1. https://www.jetbrains.com/help/space/publish-artifacts-to-maven-central.html
