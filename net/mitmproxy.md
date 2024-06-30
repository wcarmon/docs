# Overview
1. TODO


# Install
```bash
sudo apt-get install -y mitmproxy
```

# Run Proxy
```bash
mitmproxy --mode regular --showhost
# mitmproxy --mode transparent
# mitmproxy --mode upstream:http://localhost:8080/ --showhost
```


# CA Cert
```bash
sudo cp -nv $HOME/.mitmproxy/*.pem /usr/local/share/ca-certificates/
sudo update-ca-certificates
```
1. http://mitm.it


# Setup Proxy in Network config
```bash
gnome-control-center network &
```
1. Manual
1. Network Proxy >
    - http:     localhost 8080
    - https:    localhost 8080


# Restart Chrome


# Cleanup
```bash
sudo rm -v /usr/local/share/ca-certificates/mitmproxy-*.pem

gnome-control-center network &
```
1. Disable Proxy


# Other resources
1. TODO
