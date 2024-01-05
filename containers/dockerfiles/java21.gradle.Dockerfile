# syntax=docker/dockerfile:1

# Assumptions:
# 1. Tests previously run
# 2. Static analysis previously run

# ---------------------------------------------
# -- Build stage
# ---------------------------------------------
# -- Debug: docker run -it --rm amazoncorretto:21 bash
FROM amazoncorretto:21 AS buildStage

# - Alpine: /usr/local/share/ca-certificates/
# - Debian: /usr/lib/ssl/certs/
# COPY ./foo.crt /usr/local/share/ca-certificates/

# -- Install dependencies
RUN yum upgrade -y && \
    yum install -q -y wget unzip zip shadow-utils.x86_64 && \
    update-ca-trust


# -- Use bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh


#RUN /usr/bin/keytool \
#    -alias foo \
#    -file /usr/local/share/ca-certificates/foo.crt \
#    -importcert \
#    -keystore $HOME/.sdkman/candidates/java/current/lib/security/cacerts \
#    -noprompt \
#    -storepass changeit \
#    -trustcacerts


# -- Add user for building
RUN groupadd -g 1010 appbuilder && \
    useradd \
    -d /home/appbuilder  \
    -g appbuilder \
    -u 1010 \
    appbuilder


# -- Get latest gradle
RUN mkdir /opt/gradle && \
    cd /opt/gradle && \
    wget https://services.gradle.org/distributions/gradle-8.5-bin.zip && \
    unzip ./gradle-*-bin.zip && \
    rm -f ./gradle-*-bin.zip && \
    mv -n ./gradle-8.*/* ./ && \
    ln -s /opt/gradle/bin/gradle /usr/local/bin/ && \
    chown -R appbuilder /opt/gradle


WORKDIR /home/appbuilder

# -- Copy sources
# -- See also: .dockerignore
COPY --chown=appbuilder:appbuilder . .
RUN chown -R appbuilder:appbuilder /home/appbuilder

# TODO: copy gradle.properties to /home/appbuilder/.gradle/gradle.properties

USER appbuilder:appbuilder

RUN gradle \
     clean build jar shadowJar \
     --no-daemon \
     -Dhttp.connectionRequestTimeout=45000 \
     -Dhttp.connectionTimeout=45000  \
     -Dhttp.socketTimeout=45000 \
     -Dorg.gradle.daemon=false \
     -Dorg.gradle.jvmargs=-Xmx1024m \
     -Dorg.gradle.parallel=true \
     -Dorg.gradle.workers.max=2 \
     -q \
     -x check \
     -x spotlessApply \
     -x spotlessCheck \
     -x test

#     -x spotbugs \
#     -x pmdMain \
#     -x pmdTest \
#
#     -Djavax.net.ssl.keyStorePassword=changeit \
#     -Djavax.net.ssl.keyStoreType=KeychainStore \
#     -Dorg.gradle.jvmargs=-Djavax.net.ssl.keyStore="$HOME/.sdkman/candidates/java/current/lib/security/cacerts" \


# ---------------------------------------------
# -- Package stage
# ---------------------------------------------
#
# -- Debug: docker run -it --rm --entrypoint /bin/bash ghcr.io/graalvm/native-image-community:21
# -- Debug: (cannot debug the muslib version, lacks a shell), and is somewhate buggy
#
# -- See https://github.com/graalvm/container/pkgs/container/native-image-community
# -- See https://github.com/graalvm/container/pkgs/container/native-image
#FROM ghcr.io/graalvm/native-image-community:21-muslib AS nativeBuild
FROM ghcr.io/graalvm/native-image-community:21 AS nativeBuild
USER root

WORKDIR /app

# -- Copy uber jar from previous stage
#COPY --from=buildStage /home/appbuilder/build/libs/app.jar /app/app.jar
COPY --from=buildStage /home/appbuilder/main/build/libs/app.jar /app/app.jar

# -- Print help:
#   docker run -it --rm ghcr.io/graalvm/native-image-community:21 --help

# -- Compile jar to native binary
RUN /usr/bin/native-image \
    --color=never \
    --enable-http \
    --enable-https \
    --enable-preview \
    --parallelism=4 \
    --static \
    -O2 \
    -jar /app/app.jar \
    -o /app/app.bin

# -- Tuning
# -Ob \    <-- fast builds
# -O1 \    <-- basic optimizations
# -O2 \    <-- advanced optimizations
# -O3 \    <-- best performance


# ---------------------------------------------
# -- Execute stage
# ---------------------------------------------
# -- GOTCHA: Must match distro on nativeBuild stage
#FROM alpine:3
FROM debian:12-slim

USER root

WORKDIR /app

# TODO: align with listening port
EXPOSE 3000

COPY --from=nativeBuild /app/app.bin /app/app.bin

# -- TODO: copy required ca certs here

# -- Alpine:
#RUN addgroup -g 1001 javaapp && \
#    adduser \
#    -D \
#    -G javaapp \
#    -h /app  \
#    -u 1001 \
#    javaapp


# -- Debian
RUN addgroup -gid 1001 javaapp && \
    adduser \
    --disabled-password \
    --home /app \
    --ingroup javaapp \
    --no-create-home \
    --comment '' \
    --uid 1001 \
    javaapp


RUN chown -R javaapp:javaapp /app
USER javaapp:javaapp

CMD ["/app/app.bin"]
