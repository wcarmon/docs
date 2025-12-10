# Overview
1. TODO


# Setup config
 
```
mkdir -p ~/.config/opencode

cat > ~/.config/opencode/opencode.json << 'EOF'
{
  "$schema": "https://opencode.ai/config.json",
  "permission": {
    "edit": "allow",              // can edit files by default
    "external_directory": "ask",  // touching files outside CWD tree
    "bash": "ask",                // ask before running shell commands
    "webfetch": "ask",            // ask before going to the internet
    "doom_loop": "ask"            // ask if it wants to loop a lot
  }
}
EOF
```

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
TODO: /models
```


# Other resources
1. TODO
