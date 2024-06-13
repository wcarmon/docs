# syntax=docker/dockerfile:1

# Assumptions:
# 1. Tests previously run
# 2. Static analysis previously run

# NOTES:
# 1. Uses sdkman to install jdk & gradle
# 2. Builds jar build stage via gradle (installed via sdkman)
# 3. Executes jar in deploy stage using jdk (installed via sdkman)



# ---------------------------------------------
# -- Build stage
# ---------------------------------------------
FROM debian:bookworm AS buildStage
WORKDIR /home/appbuilder

# -- TODO: copy extra ca certs here
# - Alpine: /usr/local/share/ca-certificates/
# - Debian: /usr/lib/ssl/certs/
# COPY ./foo.crt /usr/local/share/ca-certificates/

# -- Install dependencies
RUN apt-get update -qq && \
    apt-get install -q -y git curl unzip zip && \
    update-ca-certificates


# -- Use bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh


# -- Add user for building
RUN groupadd -g 1010 appbuilder && \
    useradd \
    --gid appbuilder \
    --home-dir /home/appbuilder  \
    --uid 1010 \
    appbuilder

# -- Prep or sdkman, Java, Gradle install

ENV JAVA_HOME=/home/appbuilder/.sdkman/candidates/java/current
ENV GRADLE_HOME=/home/appbuilder/.sdkman/candidates/gradle/current

RUN chown -R appbuilder:appbuilder /home/appbuilder

USER appbuilder:appbuilder

# -- Install sdkman, java, gradle

# NOTE: use `sdk list java` to see available versions
# GOTCHA: this step is slow because of the java & gradle installs
RUN curl --silent "https://get.sdkman.io" | bash && \
    chmod a+x "$HOME/.sdkman/bin/sdkman-init.sh" && \
    source "$HOME/.sdkman/bin/sdkman-init.sh" && \
    sdk install java 21.0.3-amzn && \
    sdk use java 21.0.3-amzn

RUN source "$HOME/.sdkman/bin/sdkman-init.sh" && \
    sdk install gradle 8.6 && \
    sdk use gradle 8.6


# -- Add cert to keytool (java sdk)
RUN $HOME/.sdkman/candidates/java/current/bin/keytool \
    -alias foo \
    -file /usr/local/share/ca-certificates/foo.crt \
    -importcert \
    -keystore $HOME/.sdkman/candidates/java/current/lib/security/cacerts \
    -noprompt \
    -storepass changeit \
    -trustcacerts


# -- Copy sources
# -- See also: .dockerignore
COPY --chown=appbuilder:appbuilder . .
RUN chown -R appbuilder:appbuilder /home/appbuilder


# -- Build via Gradle
RUN $HOME/.sdkman/candidates/gradle/current/bin/gradle \
    clean build jar shadowJar \
    --no-daemon \
    -Dhttp.connectionRequestTimeout=45000 \
    -Dhttp.connectionTimeout=45000  \
    -Dhttp.socketTimeout=45000 \
    -Djavax.net.ssl.keyStorePassword=changeit \
    -Djavax.net.ssl.keyStoreType=KeychainStore \
    -Dorg.gradle.daemon=false \
    -Dorg.gradle.jvmargs=-Djavax.net.ssl.keyStore="$HOME/.sdkman/candidates/java/current/lib/security/cacerts" \
    -Dorg.gradle.jvmargs=-Xmx1024m \
    -Dorg.gradle.parallel=true \
    -Dorg.gradle.workers.max=2 \
    -q \
    -x check \
    -x pmd \
    -x spotbugs \
    -x spotlessApply \
    -x spotlessCheck \
    -x test

# ---------------------------------------------
# -- Deploy stage
# ---------------------------------------------
FROM alpine:3
USER root

WORKDIR /app
EXPOSE 3000

RUN wget -O /etc/apk/keys/amazoncorretto.rsa.pub  https://apk.corretto.aws/amazoncorretto.rsa.pub && \
    echo "https://apk.corretto.aws/" >> /etc/apk/repositories && \
    apk update && \
    apk add amazon-corretto-21

RUN update-ca-certificates && \
    apk --no-cache add ca-certificates

COPY --from=buildStage /home/appbuilder/build/libs/*.jar /app/app.jar

RUN groupadd -g 1001 javaapp && \
    useradd \
    --gid javaapp \
    --home-dir /home/javaapp  \
    --uid 1001 \
    javaapp

RUN chown -R javaapp:javaapp /app

USER javaapp:javaapp

#
# In K8s, use environment vars like this:
# JDK_JAVA_OPTIONS=--enable-preview --add-opens=java.base/java.nio=ALL-UNNAMED
# or
# JAVA_TOOL_OPTIONS=--enable-preview --add-opens=java.base/java.nio=ALL-UNNAMED
#
CMD ["$HOME/.sdkman/candidates/java/current/bin/java", "-jar", "app.jar"]
