# Overview

# Adding CA certificate
1. Define some vars (assuming [sdkman](https://sdkman.io/))
```bash
# Linux or Mac
JAVA_HOME="$HOME/.sdkman/candidates/java/17.0.1-open"

CA_CERTS_FILE="$JAVA_HOME/lib/security/cacerts"
KEYTOOL="$JAVA_HOME/bin/keytool"

# PEM format, starts with a tag like: -----BEGIN CERTIFICATE-----
NEW_CA_CERT="/path/to/my.crt"
```
1. Convert [*.crt]() to [.der](https://wiki.openssl.org/index.php/DER)
```bash
DER_FILE=./foo.der;
openssl x509 \
-in $CA_CERTS_FILE \
-outform der \
-out $DER_FILE;
```
1. Import [*.der](https://wiki.openssl.org/index.php/DER) formatted certificate to JVM
```bash
$KEYTOOL -import \
-trustcacerts \
-file ~/my-cert.der \
-alias custom-Root-CA-keystore \
-cacerts;
```


# Other resources
1. TODO