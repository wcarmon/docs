# Overview
1. TODO



# OpenAI

1. [API Keys](https://platform.openai.com/settings/organization/api-keys)
1. [API Billing](https://platform.openai.com/settings/organization/billing/overview)
1. [API Usage limits](https://platform.openai.com/settings/organization/limits)
1. [API Usage stats](https://platform.openai.com/settings/organization/usage)


--------
# [Codex](https://developers.openai.com/codex/quickstart)

1. Codex is included in ChatGPT Plus
1. Codex has a CLI, and IDE plugin, a GitHub Action
1. Use API Key to extend usage limits
    1. auth_mode = "ChatGPT" has a limit based on your ChatGPT plan
        `codex --config preferred_auth_method="chatgpt"`
    1. auth_mode = "apiKey" has limits based on your billing
        `codex --config preferred_auth_method="apikey"`
    1. `codex login status`
    
    
## Codex: Setup

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

