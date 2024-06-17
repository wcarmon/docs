# Overview


# Perf

## Linux install
```bash
sudo apt install -y linux-tools-common linux-tools-generic
sudo apt install -y linux-tools-`uname -r`
#sudo apt install -y linux-perf
```

## Access the right binary
```bash
alias perf=$(find /usr/lib/linux-tools/*/perf | head -1)

#export PERF=/usr/lib/linux-tools/5.15.0-112-generic/perf
```


# Samply
```bash
cargo install --locked samply
```


## Usage
```bash
samply record ./my-application my-arguments
```


# Other Resources
1. https://nnethercote.github.io/perf-book/profiling.html
1. https://nnethercote.github.io/perf-book/introduction.html
