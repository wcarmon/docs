# Overview

1. How to add a [ca-certificate](TODO) for a JVM SDK installation


- TODO: loop

# Adding CA certificate

1. Define some vars (assuming [sdkman](https://sdkman.io/))

```bash
# Linux or MacOS
JAVA_HOME="$HOME/.sdkman/candidates/java/17.0.1-open"

#CA_CERTS_FILE="$JAVA_HOME/lib/security/cacerts"
KEYTOOL="$JAVA_HOME/bin/keytool"

DER_FILE=./foo.der;

# PEM format, starts with a tag like: -----BEGIN CERTIFICATE-----
NEW_CA_CERT="/path/to/my.crt"
```

2. Convert [*.crt]() to [.der](https://wiki.openssl.org/index.php/DER)

```bash
openssl x509 \
-in $NEW_CA_CERT \
-outform der \
-out $DER_FILE;
```

3. Import [*.der](https://wiki.openssl.org/index.php/DER) formatted certificate to JVM

```bash
$KEYTOOL -import \
-trustcacerts \
-file $DER_FILE \
-alias custom-Root-CA-keystore \
-cacerts;

# You may need to enter a keystore password here
```

## Multiple JDKs

```bash
MY_CERT=$HOME/my_cert.der
find $HOME \
-type f \
-name keytool \
-exec {}
    -import \
    -alias custom-Root-CA-keystore \
    -cacerts \
    -file $MY_CERT \
    -trustcacerts \;
```

# Other Resources

1. TODO
