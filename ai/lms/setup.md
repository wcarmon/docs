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

lms get qwen/qwen3-coder-next
lms get qwen/qwen2.5-coder-14b
lms get google/gemma-4-e2b
lms get google/gemma-3-4b
lms get google/gemma-3-1b
lms get qwen/qwen3.5-9b
lms get qwen/qwen3.5-2b
lms get qwen/qwen3.5-4b
lms get mistralai/ministral-3-3b
lms get mistralai/ministral-3-3b-reasoning
lms get mistralai/ministral-3-8b
lms get mistralai/ministral-3-8b-reasoning


lms ls
lms load qwen/qwen2.5-coder-14b
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


# Other resources
1. TODO
