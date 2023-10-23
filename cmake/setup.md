# Overview
1. How to install & setup [CMake](https://cmake.org/)



1. [Download cmake sources](https://cmake.org/download/)
    1. eg. `cmake-3.27.6.tar.gz`
```bash
sudo apt purge --autoremove cmake;
# sudo apt remove --purge cmake

sudo apt install -y build-essential libssl-dev;

cd ~/Downloads;
mkdir cmake-tmp;
mv -v cmake-3.*.tar.gz ./cmake-tmp/

cd ./cmake-tmp/
tar xzf cmake-3.*.tar.gz;
rm -v cmake-3.*.tar.gz;
cd cmake-3.*;

./bootstrap
make -j$(nproc)
sudo make install

sudo ln -sv /usr/local/bin/cmake /usr/bin/cmake

# -- Verify
/usr/local/bin/cmake -version
cmake --version
```


# Other resources
1. TODO
