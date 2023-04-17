# Overview
- Setup for python package manager for ZScaler
- You can manually download a few *.whl files in some other web client and install locally


# Making pip work in venv
```sh
ZSCALER_CERT_PATH=/path/to/ZscalerRootCertificate-2048-SHA256.crt;

# Activate venv
source /path/to/venv/bin/activate;

pip config set global.cert $ZSCALER_CERT_PATH; 

# If this fails, manually download the *.whl file from https://pypi.org/project/certifi/
# then pip install ./local/path/to/certifi.whl

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
