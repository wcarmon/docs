# Overview

1. OpenAI, codex, etc


# OpenAI Links

1. [API Billing](https://platform.openai.com/settings/organization/billing/overview)
1. [API Usage stats](https://platform.openai.com/settings/organization/usage)
1. [API Usage limits](https://platform.openai.com/settings/organization/limits)
1. [API Keys](https://platform.openai.com/settings/organization/api-keys)


--------
# [Codex](https://developers.openai.com/codex/quickstart)

1. Codex is included in [ChatGPT Plus](https://openai.com/index/chatgpt-plus/)
1. Codex has a CLI, and IDE plugin, a GitHub Action

## Auth modes

- Current mode:
```sh
codex login status
```

### Use API Key Auth
```sh
codex logout
codex --config preferred_auth_method="apikey"
```
1. limits based on your billing


### Use ChatGPT Auth

```sh
codex logout
codex --config preferred_auth_method="chatgpt"

# Login with creds and OTP
```
1. limits based on your ChatGPT plan



--------
## Codex: One time Setup

1. Install/Update: `pnpm install -g @openai/codex`
1. `$HOME/.zshrc`
    1. Add `export OPENAI_API_KEY="sk-proj-..."`
    1. Add "$(codex completion zsh)"

### Verify

1. `codex --version`
1. `codex login status`
1. inside codex: `/status`


## Codex: Docs

1. [Codex CLI homepage](https://developers.openai.com/codex/cli)
    1. [Codex CLI features](https://developers.openai.com/codex/cli/features#running-in-interactive-mode)
1. [Codex Usage limits](https://chatgpt.com/codex/settings/usage)

