# Overview
- TODO


# Making pip work in venv
```sh
ZSCALER_CERT_PATH=/path/to/ZscalerRootCertificate-2048-SHA256.crt;

# Activate venv
source /path/to/venv/bin/activate;

pip3 install --trusted-host pypi.org --trusted-host files.pythonhosted.org certifi;
cat $ZSCALER_CERT_PATH >> $(python3 -m certifi);

export CERT_PATH=$(python3 -m certifi);
export SSL_CER_FILE=${CERT_PATH};
export REQUESTS_CA_BUNDLE=${CERT_PATH};
```


# Making pip work in PyCharm
1. Set Path variables
    - `CERT_PATH=`
    - `REQUESTS_CA_BUNDLE=`
    - `SSL_CERT_FILE=`


# Other Resources
- TODO
