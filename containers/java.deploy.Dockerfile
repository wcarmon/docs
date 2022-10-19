# syntax=docker/dockerfile:1

# -- Assumptions:
# 1. Build previously run
# 2. Tests previously run
# 3. Static analysis previously run

FROM amazoncorretto:19-alpine-jdk
WORKDIR /home/javaapp

# Custom ca-certificate
COPY ./certs/custom.crt /usr/local/share/ca-certificates/custom.crt
COPY ./certs/custom.crt /usr/lib/ssl/certs/custom.crt

RUN cat /usr/local/share/ca-certificates/custom.crt >> /etc/ssl/certs/ca-certificates.crt && \
    apk update && \
    apk --no-cache add ca-certificates && \
    update-ca-certificates

RUN apk add --no-cache curl jq zip

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
COPY --chown=javaapp:javaapp ./target/fix.jar /home/javaapp/app.jar

USER javaapp:javaapp

CMD ["java", "-jar", "app.jar"]
