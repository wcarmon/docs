# Overview
1. TODO


# Install

```bash
pnpm -g install @lmstudio/sdk

# -- Verify
ls -l $HOME/.lmstudio/bin/lms

ln -s $HOME/.lmstudio/bin/lms $HOME/bin/

# -- Verify
lms -v
lms
```

# Setup models

```bash
lms daemon up

# -- Relatively Small coding models
lms get deepseek/deepseek-r1-0528-qwen3-8b
lms get deepseek/deepseek-r1-distill-llama-8b
lms get deepseek/deepseek-r1-distill-qwen-7b
lms get google/gemma-3-1b
lms get google/gemma-3-4b
lms get google/gemma-4-e2b
lms get google/gemma-4-e4b
lms get mistralai/ministral-3-3b
lms get mistralai/ministral-3-3b-reasoning
lms get mistralai/ministral-3-8b
lms get mistralai/ministral-3-8b-reasoning
lms get qwen/qwen2.5-coder-14b
lms get qwen/qwen3-4b
lms get qwen/qwen3-4b-2507
lms get qwen/qwen3-4b-thinking-2507
lms get qwen/qwen3-8b
lms get qwen/qwen3-coder-next
lms get qwen/qwen3.5-2b
lms get qwen/qwen3.5-4b
lms get qwen/qwen3.5-9b


lms ls
lms load mistralai/ministral-3-3b
lms ps

lms chat
```

# Update opencode.json
- Avoids this issue: `Prediction error: Cannot truncate prompt with n_keep (11749) >= n_ctx (4096)`


```bash
vi $HOME/.config/opencode/opencode.json
```

- Add to bottom of `opencode.json`:
```json
{
  ...

  "tools": {
    "*": false
  }
}
```
- full schema: https://opencode.ai/config.json
- See also: https://github.com/anomalyco/opencode/issues/11144


# Chat
- command line

```
lms chat
```

# Server
- hosts models for other tools

```sh
lms server start
```


# Other resources
1. TODO
