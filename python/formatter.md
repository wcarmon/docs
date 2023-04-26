# Overview
1. How to setup auto-formatter


# Black
```bash
find "$HOME/.pyenv/versions" -type f -name activate | grep envs
pyenv activate <my-virtual-env>

pip install black;
pip install black[d];


# Run (NOTE: Pycharm plugin can also do this part)
killall blackd;
blackd &

# -- verify
ps aux | grep blackd
sudo netstat -pant | grep -i 45484
```


# Pycharm
1. See [plugin](https://plugins.jetbrains.com/plugin/14321-blackconnect)


# Other resources
https://plugins.jetbrains.com/plugin/14321-blackconnect
