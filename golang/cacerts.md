# Overview

# CA certificate paths

## Linux
- See [`x509`](https://cs.opensource.google/go/go/+/refs/tags/go1.18.3:src/crypto/x509/root_linux.go;l=8) package

## Mac
- See [`x509`](https://cs.opensource.google/go/go/+/refs/tags/go1.18.3:src/crypto/x509/root_bsd.go;l=10) package


# Adding CA certificate
## Linux
- TODO

## Mac
```bash
# PEM format, starts with a tag like: -----BEGIN CERTIFICATE-----
NEW_CA_CERT="/path/to/my.crt"

#CA_CERT_PATH=/etc/ssl/cert.pem

# See https://wiki.openssl.org/index.php/DER
DER_FILE=...

sudo security add-trusted-cert \
-d \
-r trustRoot \
-k /Library/Keychains/System.keychain \
$DER_FILE;

sudo cat $NEW_CA_CERT >> /usr/local/etc/openssl/cert.pem
sudo cat $NEW_CA_CERT >> /etc/ssl/cert.pem
```


# Other resources
1. TODO