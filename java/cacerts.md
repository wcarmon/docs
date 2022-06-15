# Overview

# Adding CA certificate
1. define vars
```bash
JAVA_HOME=$HOME/.sdkman/candidates/java/17.0.1-open

CA_CERTS_FILE=$JAVA_HOME/lib/security/cacerts;
KEYTOOL=$JAVA_HOME/bin/keytool;

NEW_CA_CERT=/path/to/my.crt
# Has tag like -----BEGIN CERTIFICATE-----
```
1. Convert to .der
```bash
DER_FILE=./foo.der;
openssl x509 \
-in $CA_CERTS_FILE \
-outform der \
-out $DER_FILE;
```
1. Import cert to JVM
```bash
$KEYTOOL -import \
-trustcacerts \
-file ~/my-cert.der \
-alias custom-Root-CA-keystore \
-cacerts;
```


# Other resources
1. TODO