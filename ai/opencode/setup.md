# Overview
1. TODO


# Setup config
 
```
mkdir -p ~/.config/opencode 
```
- Copy from ./opencode.json into $HOME/.config/opencode/opencode.json


# Setup pnpm

```sh
curl -fsSL https://get.pnpm.io/install.sh | zsh -

# -- Update ~/.zshrc
# export PATH="$HOME/.local/share/pnpm:$PATH"
```

# Setup OpenCode

```sh
pnpm install -g opencode-ai

# -- Verify
opencode --help
opencode --version
```


# Connect to llama.cpp

- Copy [`opencode.json`](./opencode.json) to `$HOME/.config/opencode/opencode.json`


```sh
# Use /models
```


# Other resources
1. TODO
