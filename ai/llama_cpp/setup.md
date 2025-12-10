# Overview
1. TODO


# Setup

```sh
sudo apt update
sudo apt install -y build-essential cmake

mkdir -p $HOME/git-repos/external
cd $HOME/git-repos/external

git clone https://github.com/ggml-org/llama.cpp.git
cd llama.cpp

cmake -B build
cmake --build build -j"$(nproc)"

cp -v ./build/bin/llama-server $HOME/bin/ 
cp -v ./build/bin/llama-cli $HOME/bin/ 


# -- verify
llama-server --version
```


# Models

## Best non-GPU coding options in 2025 Q4 

- [Qwen](https://huggingface.co/Qwen)    
    1. `https://huggingface.co/Qwen/Qwen2.5-Coder-14B-Instruct-GGUF`          (default to this)
    2. `https://huggingface.co/Qwen/Qwen2.5-Coder-7B-Instruct-GGUF`           (only if 14b too slow)
    3. `https://huggingface.co/Qwen/Qwen2.5-Coder-32B-Instruct-GGUF`          (might be too slow)
- [deepseek-ai](https://huggingface.co/deepseek-ai)
    1. `https://huggingface.co/deepseek-ai/DeepSeek-Coder-V2-Lite-Instruct`
    2. `https://huggingface.co/deepseek-ai/deepseek-coder-33b-instruct`       (might be too slow)
    3. `https://huggingface.co/deepseek-ai/deepseek-coder-7b-instruct-v1.5`   (only if others too slow)
- [StarCoder2]
    1. `https://huggingface.co/bigcode/starcoder2-15b`                        (old school, no nonsense)


## Auto Download, Serve/Run on different ports

```sh
export HF_HOME="$HOME/.cache/huggingface"
export HF_HUB_ENABLE_HF_TRANSFER=1


# -- ==============
# -- Qwen
# -- ==============

# -- https://huggingface.co/Qwen/Qwen2.5-Coder-7B-Instruct-GGUF
llama-server \
  -hf Qwen/Qwen2.5-Coder-7B-Instruct-GGUF \
  -m qwen2.5-coder-7b-instruct-q4_k_m.gguf \
  --port 7701 \
  --host 127.0.0.1


# -- https://huggingface.co/Qwen/Qwen2.5-Coder-14B-Instruct-GGUF
llama-server \
  -hf Qwen/Qwen2.5-Coder-14B-Instruct-GGUF \
  -m qwen2.5-coder-14b-instruct-q4_k_m.gguf \
  --port 7702 \
  --host 127.0.0.1


# -- https://huggingface.co/Qwen/Qwen2.5-Coder-32B-Instruct-GGUF
# TODO: waiting for download to complete
llama-server \
  -hf Qwen/Qwen2.5-Coder-32B-Instruct-GGUF \
  -m qwen2.5-coder-32b-instruct-q4_k_m.gguf \
  --port 7703 \
  --host 127.0.0.1


# -- ==============
# -- DeepSeek
# -- ==============

# -- https://huggingface.co/bartowski/DeepSeek-Coder-V2-Lite-Instruct-GGUF
llama-server \
  -hf bartowski/DeepSeek-Coder-V2-Lite-Instruct-GGUF \
  -m DeepSeek-Coder-V2-Lite-Instruct-Q4_K_M.gguf \
  --port 7801 \
  --host 127.0.0.1


# -- ==============
# -- StarCoder
# -- ==============

# -- https://huggingface.co/bartowski/starcoder2-15b-instruct-v0.1-GGUF
# TODO: waiting for download to complete
llama-server \
  -hf bartowski/starcoder2-15b-instruct-v0.1-GGUF \
  -m starcoder2-15b-instruct-v0.1-Q6_K.gguf \
  --port 7901 \
  --host 127.0.0.1
```


## Verify 

```sh

# TODO: verify in browser /v1/chat
```



# Other resources
1. TODO
