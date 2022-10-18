# syntax=docker/dockerfile:1

# ---------------------------------------------
# -- Build stage
# ---------------------------------------------
FROM debian:bullseye AS builder
WORKDIR /home/builder

# -- TODO: copy extra ca certs here
# COPY ./foo.crt /usr/local/share/ca-certificates/

RUN apt-get update -qq && \
    apt-get install -q -y curl zip unzip && \
    update-ca-certificates

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN groupadd -g 1010 builder && \
    useradd --gid builder --uid 1010 --home-dir /home/builder builder


# -- Copy sources
COPY --chown=builder:builder . .
RUN chown -R builder:builder /home/builder

USER builder:builder

# -- Install sdkman, java & gradle
ENV JAVA_HOME=/home/builder/.sdkman/candidates/java/current
ENV GRADLE_HOME=/home/builder/.sdkman/candidates/gradle/current

RUN curl --silent https://get.sdkman.io | bash && \
    chmod a+x "$HOME/.sdkman/bin/sdkman-init.sh" && \
    source "$HOME/.sdkman/bin/sdkman-init.sh" && \
    sdk install java 19-amzn && \
    sdk use java 19-amzn && \
    sdk install gradle 7.5.1 && \
    sdk use gradle 7.5.1


# -- Add cert to keytool
RUN keytool \
    -alias foo \
    -file /usr/local/share/ca-certificates/foo.crt \
    -importcert \
    -keystore $JAVA_HOME/lib/security/cacerts \
    -noprompt \
    -storepass changeit \
    -trustcacerts


# -- Build
RUN ./gradlew \
    --version  \
    -q \
    -Dhttp.socketTimeout=60000 \
    -Dhttp.connectionTimeout=60000  \
    -Dhttp.connectionRequestTimeout=60000

RUN ./gradlew clean build jar \
    --no-daemon \
    -Dhttp.connectionRequestTimeout=60000 \
    -Dhttp.connectionTimeout=60000  \
    -Dhttp.socketTimeout=60000 \
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

WORKDIR /app
EXPOSE 3000

RUN update-ca-certificates && \
    apk --no-cache add ca-certificates

# TODO: copy jar

RUN addgroup -g 1001 javaapp && \
    adduser \
    -D \
    -G javaapp \
    -h /app \
    -H \
    -u 1001 \
    javaapp

RUN chmod 0755 /app/app.bin && \
    chown -R javaapp:javaapp /app

USER javaapp:javaapp

CMD ["/path/to/java", "-jar", ""]
