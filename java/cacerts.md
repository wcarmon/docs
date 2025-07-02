# Overview

1. How to add a [ca-certificate](https://en.wikipedia.org/wiki/Certificate_authority) for a JVM SDK installation


- TODO: loop

# Adding CA certificate

1. Define some vars (assuming [sdkman](https://sdkman.io/))

```bash
# Linux
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
CERT_PATH="$HOME/my_cert.der"
find $HOME \
-type f \
-name keytool \
-exec {}
    -import \
    -alias custom-Root-CA-keystore \
    -cacerts \
    -file $CERT_PATH \
    -trustcacerts \;
```

## ZScaler

```bash
CERT_PATH="$HOME/.certs/zscaler_root_ca.pem"

find $HOME \
-type f \
-name keytool \
-exec {} \
    -import \
    -alias zscaler-root-1 \
    -cacerts \
    -file $CERT_PATH \
    -trustcacerts \;

#find $HOME \
#-type f \
#-name keytool \
#-exec {} \
#  -importcert \
#  -alias zscaler-root-2 \  
#  -storepass changeit \
#  -file $CERT_PATH
```


# Other Resources

1. TODO
