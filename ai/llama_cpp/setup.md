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


```sh
llama-server -hf Qwen/Qwen2.5-Coder-7B-Instruct-GGUF -m qwen2.5-coder-7b-instruct-q4_k_m.gguf --port 8081

mkdir -pv $HOME/llm-models/qwen
mkdir -pv $HOME/llm-models/deepseek
mkdir -pv $HOME/llm-models/starcoder

# -- Qwen
cd $HOME/llm-models/qwen
wget -O qwen2.5-coder-7b-instruct-q4_k_m.gguf \
  "https://huggingface.co/Qwen/Qwen2.5-Coder-7B-Instruct-GGUF/resolve/main/qwen2.5-coder-7b-instruct-q4_k_m.gguf?download=1"

wget -O qwen2.5-coder-14b-instruct-q4_k_m.gguf \
  "https://huggingface.co/Triangle104/Qwen2.5-Coder-14B-Instruct-Q4_K_M-GGUF/resolve/main/Qwen2.5-Coder-14B-Instruct-Q4_K_M.gguf?download=1"

wget -O qwen2.5-coder-32b-instruct-q4_k_m.gguf \
  "https://huggingface.co/bartowski/Qwen2.5-Coder-32B-Instruct-GGUF/resolve/main/Qwen2.5-Coder-32B-Instruct-Q4_K_M.gguf?download=1"


# -- DeepSeek
cd $HOME/llm-models/deepseek

wget -O deepseek-coder-v2-lite-instruct-q4_k_m.gguf \
  "https://huggingface.co/bartowski/DeepSeek-Coder-V2-Lite-Instruct-GGUF/resolve/main/DeepSeek-Coder-V2-Lite-Instruct-Q4_K_M.gguf?download=1"

TODO: `https://huggingface.co/deepseek-ai/deepseek-coder-33b-instruct`
TODO: `https://huggingface.co/deepseek-ai/deepseek-coder-7b-instruct-v1.5`


# -- StarCoder2
cd $HOME/llm-models/starcoder


TODO: just the one

```

# Run/Serve Multiple models (different ports)

```sh
llama-server \
  -m ~/models/qwen/qwen2.5-coder-7b-instruct-q4_k_m.gguf \
  --port 7071 \
  --host 127.0.0.1

llama-server \
  -m ~/models/qwen/qwen2.5-coder-14b-instruct-q4_k_m.gguf \
  --port 7072 \
  --host 127.0.0.1

llama-server \
  -m ~/models/deepseek/deepseek-coder-v2-lite-instruct-q4_k_m.gguf \
  --port 7073 \
  --host 127.0.0.1

# TODO: what others?

# TODO: verify in browser /v1/chat
```



# Other resources
1. TODO
