# Overview
- Patterns for web testing via [selenium](https://selenium-python.readthedocs.io)


# Setup
```bash
pyenv activate <my-virtual-env>

pip install selenium;

# -- verify
TODO
```

- TODO: drivers: https://selenium-python.readthedocs.io/installation.html#drivers
- TODO: https://selenium-python.readthedocs.io/getting-started.html

## Download driver (binaries)
- [Download Chrome driver](https://sites.google.com/chromium.org/driver/?pli=1)
- [Download Firefox driver](https://github.com/mozilla/geckodriver/releases)
```
mkdir -p $HOME/.selenium/drivers

# TODO: unzip
# TODO: move all files to $HOME/.selenium/drivers

rm -fv $HOME/bin/chromedriver
rm -fv $HOME/bin/geckodriver

ln -s $HOME/.selenium/drivers/chromedriver $HOME/bin;
ln -s $HOME/.selenium/drivers/geckodriver $HOME/bin;

# -- verify
ls -ahl $HOME/.selenium/drivers;
chromedriver --version;
geckodriver --version;
```


# Idioms
1. TODO ...


# Other Resources
1. TODO
