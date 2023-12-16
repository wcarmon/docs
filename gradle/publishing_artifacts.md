# Overview
1. TODO

# Gotcha
1. Once you upload a release, it is immutable


# Setup Sonatype (OSSRH)
1. https://issues.sonatype.org/secure/Signup!default.jspa


# Setup signing
```bash
```
TODO: gpg --gen-key
TODO: gpg --keyserver keys.openpgp.org --send-keys yourKey
TODO: gpg --list-keys



TODO: ~/.gradle/gradle.properties
```
mavenCentralUsername=xxx
mavenCentralPassword=xxx
signing.keyId=xxx
signing.password=xxx
signing.secretKeyRingFile=/xxx/secring.gpg
```


# Deploy
```sh
./gradlew generatePomFileForPubNamePublication -q

./gradlew publish -q

./gradlew publishPubNamePublicationToMavenLocal -q
```
1. takes between 10-minutes and 2 hours to reflect new artifacts



# Unorganized
1. https://central.sonatype.org/publish/requirements/#supply-javadoc-and-sources
1. https://www.jetbrains.com/help/space/publish-artifacts-to-maven-central.html
1. https://medium.com/geekculture/how-to-publish-artifacts-on-maven-central-24342fd286cd
1. https://central.sonatype.org/publish/producer-terms
1. https://central.sonatype.org/publish/publish-guide/
1. https://dzone.com/articles/how-to-publish-artifacts-to-maven-central
1. PGP signature
    1. gpg --gen-key
    1. https://central.sonatype.org/publish/requirements/gpg/
    1. https://central.sonatype.org/publish/requirements/#sign-files-with-gpgpgp
1. minimize deps
1. choose a license
    1. https://central.sonatype.org/publish/requirements/#license-information
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
1. https://docs.gradle.org/current/userguide/publishing_maven.html


# Other resources
1. https://www.jetbrains.com/help/space/publish-artifacts-to-maven-central.html
