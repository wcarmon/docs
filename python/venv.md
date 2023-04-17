# Overview
1. Python virtual environments    
1. Multiple Python interpreter versions
1. As of 2023


# Idioms
1. Let [`pyenv`](https://github.com/pyenv/pyenv) manage multiple python versions
1. Let [`pyenv-virtualenv` plugin](https://github.com/pyenv/pyenv-virtualenv) create [virtual environments](https://docs.python.org/3/tutorial/venv.html)
    1. Internally, it uses [`python -m venv`](https://docs.python.org/3/library/venv.html) when available, falls back to [`virtualenv`](https://virtualenv.pypa.io/en/latest/)
1. Avoid ~~`pipenv`~~


# Linux setup steps
```bash
# any 3.x is fine for bootstrapping
sudo apt-get install python3;

sudo apt-get install -y \
build-essential \
curl \
libbz2-dev \
libffi-dev \
liblzma-dev \
libncurses5-dev \
libncursesw5-dev \
libreadline-dev \
libsqlite3-dev \
libssl-dev \
llvm \
python-openssl \
python3-tk \
tk-dev \
wget \
xz-utils \
zlib1g-dev;
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
PYENV_BINARY=$HOME/.pyenv/bin/pyenv;
export PYENV_ROOT="$HOME/.pyenv"
command -v $PYENV_BINARY >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$($PYENV_BINARY init -)"
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

# -- verify
pyenv virtualenv --version
```

- TODO: pyenv-doctor


# MacOS setup steps
```
brew install python3;
brew install pyenv;
brew install pyenv-virtualenv;

## verify
python3 --version
pyenv --version
```

- TODO: pyenv-doctor


# Windows steps
- TODO: https://www.newline.co/courses/create-a-serverless-slackbot-with-aws-lambda-and-python/installing-python-3-and-pyenv-on-macos-windows-and-linux#pyenv-on-windows
- TODO: https://github.com/pyenv/pyenv#windows


------
# Install desired Python versions
```bash
# -- see latest available
pyenv update;
pyenv install --list | grep 3.12;
pyenv install --list | grep 3.11;

pyenv install 3.11;
#pyenv install 3.10;

# -- verify
pyenv versions;

find $HOME/.pyenv/versions -name python | grep "bin/python"
find $HOME/.pyenv/versions -name pip | grep "bin/pip"
```

# Create virtual environments
```bash
pyenv virtualenv 3.11 wc_3.11

# -- verify
pyenv virtualenvs
```


# Activate/Deactivate virtual environment
```
# Using pure bash
find "$HOME/.pyenv/versions" -type f -name activate | grep envs

PY_ENV_ACTIVATE=$HOME/.pyenv/versions/3.11.3/envs/wc_3.11/bin/activate
source $PY_ENV_ACTIVATE;

# Using pyenv
pyenv activate wc_3.11
pyenv deactivate
```


# Other commands
```bash
pyenv versions
pyenv commands
```


# Uninstall/Delete
- [https://github.com/pyenv/pyenv-virtualenv#delete-existing-virtualenv](https://github.com/pyenv/pyenv-virtualenv#delete-existing-virtualenv)


# Other Resources
1. https://realpython.com/python-virtual-environments-a-primer/
1. https://realpython.com/intro-to-pyenv/
