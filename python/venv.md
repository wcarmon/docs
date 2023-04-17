# Overview
1. Python virtual environments    
1. Multiple Python interpreter versions
1. As of 2023


# Idioms
1. Let [`pyenv`](https://github.com/pyenv/pyenv) manage multiple python versions
1. Let [`pyenv-virtualenv` plugin](https://github.com/pyenv/pyenv-virtualenv) create [virtual environments](TODO)
1. Avoid ~~`pipenv`~~


# Linux setup steps
```bash
# any 3.x is fine for bootstrapping
sudo apt-get install python3;
```

## Install [pyenv](https://github.com/pyenv/pyenv)
1. Run [python based installer](https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer) (curls from git repo)
```bash
curl https://pyenv.run | bash
```
1. Update login shell script
```bash
vi ~/.profile
```
1. Add this:
```sh
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
```
1. Restart
1. Verify
```bash
pyenv --version;
```

## Install [pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv)
1. Install via git clone
```bash
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

# restart shell
exec "$SHELL"
```
1. Verify
```bash
pyenv virtualenv --version
```


# MacOS setup steps
```
brew install python3;
brew install pyenv;
brew install pyenv-virtualenv;

## verify
python3 --version
pyenv --version
```


# Windows steps
- TODO: https://www.newline.co/courses/create-a-serverless-slackbot-with-aws-lambda-and-python/installing-python-3-and-pyenv-on-macos-windows-and-linux#pyenv-on-windows
- TODO: https://github.com/pyenv/pyenv#windows


------
# Install desired Python versions
```bash
# -- see latest available
pyenv install --list | grep 3.12;
pyenv install --list | grep 3.11;

pyenv install 3.11;
#pyenv install 3.10;
```

# Create virtual environments


# Other Resources
1. TODO

- TODO: deactivate venv
