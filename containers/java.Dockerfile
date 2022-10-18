# syntax=docker/dockerfile:1

# Assumptions:
# 1. Tests previously run
# 2. Static analysis previously run

# ---------------------------------------------
# -- Build stage
# ---------------------------------------------
FROM debian:bullseye AS builder
WORKDIR /home/appbuilder

# -- TODO: copy extra ca certs here
# - Alpine: /usr/local/share/ca-certificates/
# - Debian: /usr/lib/ssl/certs/
# COPY ./foo.crt /usr/local/share/ca-certificates/

# -- Install dependencies
RUN apt-get update -qq && \
    apt-get install -q -y curl unzip zip && \
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


# -- Copy sources
# -- See also: .dockerignore
COPY --chown=appbuilder:appbuilder . .
RUN chown -R appbuilder:appbuilder /home/appbuilder


USER appbuilder:appbuilder


# -- Install sdkman, java, gradle
ENV JAVA_HOME=/home/appbuilder/.sdkman/candidates/java/current
ENV GRADLE_HOME=/home/appbuilder/.sdkman/candidates/gradle/current

RUN curl --silent "https://get.sdkman.io" | bash && \
    chmod a+x "$HOME/.sdkman/bin/sdkman-init.sh" && \
    source "$HOME/.sdkman/bin/sdkman-init.sh" && \
    sdk install java 19-amzn && \
    sdk use java 19-amzn && \
    sdk install gradle 7.5.1 && \
    sdk use gradle 7.5.1


# -- Add cert to keytool (java sdk)
RUN $HOME/.sdkman/candidates/java/current/bin/keytool \
    -alias foo \
    -file /usr/local/share/ca-certificates/foo.crt \
    -importcert \
    -keystore cacerts \
    -noprompt \
    -storepass changeit \
    -trustcacerts


# -- Build via Gradle
RUN $HOME/.sdkman/candidates/gradle/current/bin/gradle \
    --version \
    -q \
    -Dhttp.socketTimeout=30000 \
    -Dhttp.connectionTimeout=30000  \
    -Dhttp.connectionRequestTimeout=30000

RUN $HOME/.sdkman/candidates/gradle/current/bin/gradle \
    clean build jar \
    --no-daemon \
    -Dhttp.connectionRequestTimeout=45000 \
    -Dhttp.connectionTimeout=45000  \
    -Dhttp.socketTimeout=45000 \
    -Dorg.gradle.daemon=false \
    -Dorg.gradle.parallel=true \
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

RUN update-ca-certificates && \
    apk --no-cache add ca-certificates

COPY --from=builder /home/appbuilder/build/libs/*.jar /app/app.jar

RUN groupadd -g 1001 javaapp && \
    useradd \
    --gid javaapp \
    --home-dir /home/javaapp  \
    --uid 1001 \
    javaapp

RUN chown -R javaapp:javaapp /app

USER javaapp:javaapp
CMD ["$HOME/.sdkman/candidates/java/current/bin/java", "-jar", "app.jar"]
