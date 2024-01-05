# Overview
1. How to setup [NodeJS](https://nodejs.org/en/), [npm](https://www.npmjs.com/), [npx](https://www.npmjs.com/package/npx)

 
# Install
1. See https://github.com/nodejs/help/wiki/Installation#how-to-install-nodejs-via-binary-archive-on-linux
1. [Download](https://nodejs.org/en/download/)
```bash
ARCHIVE=$HOME/Downloads/node-v18.14.2-linux-x64.tar.xz

mkdir -pv $HOME/opt/nodejs;
mv -nv $ARCHIVE $HOME/opt/nodejs/

tar -xJf ./node-v*-x64.tar.xz
rm -v *-x64.tar.xz
```
1. Add to PATH
    - vi $HOME/.bashrc
    - PATH="$HOME/opt/nodejs/node-v18.14.2-linux-x64/bin:$PATH"
    - source $HOME/.bashrc

## Verify
```bash
which node
which npm
which npx

node -v
npx -v
npm version
```


# Self update
```bash
npm install -g npm@9.6.0
```


# Outdated/Stale packages
```bash
npm outdated
```


# Other resources
1. https://github.com/nodejs/help/wiki/Installation#how-to-install-nodejs-via-binary-archive-on-linux
1. https://nodejs.org/en/download/package-manager/
