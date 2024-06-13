# syntax=docker/dockerfile:1

# -- Assumptions:
# 1. Build previously run, produced *.jar
# 2. Tests previously run
# 3. Static analysis previously run

FROM amazoncorretto:21-alpine-jdk
WORKDIR /home/javaapp

# Custom ca-certificate
COPY ./certs/custom.crt /usr/local/share/ca-certificates/custom.crt
COPY ./certs/custom.crt /usr/lib/ssl/certs/custom.crt

RUN cat /usr/local/share/ca-certificates/custom.crt >> /etc/ssl/certs/ca-certificates.crt && \
    apk update && \
    apk --no-cache add ca-certificates && \
    update-ca-certificates

RUN apk add --no-cache curl jq zip

# -- Add cert to keytool (java sdk)
RUN /usr/bin/keytool \
    -alias custom \
    -cacerts \
    -file /usr/local/share/ca-certificates/custom.crt \
    -importcert \
    -noprompt \
    -storepass changeit \
    -trustcacerts

# -- Make non-root user
RUN addgroup -g 1001 javaapp && \
    adduser \
    -D \
    -G javaapp \
    -h /javaapp \
    -H \
    -u 1001 \
    javaapp


# -- Copy jar
#TODO: change fix to whatever should run
COPY --chown=javaapp:javaapp ./target/fix.jar /home/javaapp/app.jar

RUN chown -R javaapp:javaapp /home/javaapp

USER javaapp:javaapp

#
# In K8s, use environment vars like this:
# JDK_JAVA_OPTIONS=--enable-preview --add-opens=java.base/java.nio=ALL-UNNAMED
# or
# JAVA_TOOL_OPTIONS=--enable-preview --add-opens=java.base/java.nio=ALL-UNNAMED
#
CMD ["/usr/bin/java", "-jar", "app.jar"]
