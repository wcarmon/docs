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

# -- verify
llama-server --version
```


# Models

- https://huggingface.co/Qwen
    - https://huggingface.co/Qwen/Qwen2.5-Coder-1.5B-Instruct
    - https://huggingface.co/Qwen/Qwen2.5-Coder-14B-Instruct
    - https://huggingface.co/Qwen/Qwen2.5-Coder-14B-Instruct-AWQ
    - https://huggingface.co/Qwen/Qwen2.5-Coder-14B-Instruct-GGUF
    - https://huggingface.co/Qwen/Qwen2.5-Coder-14B-Instruct-GPTQ-Int8
    - https://huggingface.co/Qwen/Qwen2.5-Coder-32B-Instruct
    - https://huggingface.co/Qwen/Qwen2.5-Coder-32B-Instruct-GGUF
    - https://huggingface.co/Qwen/Qwen3-Coder-30B-A3B-Instruct-FP8
    - https://huggingface.co/Qwen/Qwen2.5-Coder-32B-Instruct-GGUF
    - https://huggingface.co/Qwen/Qwen2.5-Coder-7B-Instruct-GGUF
    - https://huggingface.co/Qwen/Qwen2.5-Coder-7B-Instruct-GGUF
    - https://huggingface.co/Qwen/Qwen3-Coder-30B-A3B-Instruct
    - https://huggingface.co/Qwen/Qwen3-Coder-30B-A3B-Instruct
    - https://huggingface.co/Qwen/Qwen3-Coder-30B-A3B-Instruct
    - https://huggingface.co/Qwen/Qwen3-Coder-480B-A35B-Instruct
    - https://huggingface.co/Qwen/Qwen3-Coder-480B-A35B-Instruct-FP8
- https://huggingface.co/deepseek-ai
    - https://huggingface.co/deepseek-ai/deepseek-coder-1.3b-instruct
    - https://huggingface.co/deepseek-ai/deepseek-coder-33b-base
    - https://huggingface.co/deepseek-ai/deepseek-coder-33b-instruct
    - https://huggingface.co/deepseek-ai/deepseek-coder-6.7b-base
    - https://huggingface.co/deepseek-ai/deepseek-coder-7b-base-v1.5
    - https://huggingface.co/deepseek-ai/deepseek-coder-7b-instruct-v1.5
    - https://huggingface.co/deepseek-ai/DeepSeek-Coder-V2-Base
    - https://huggingface.co/deepseek-ai/DeepSeek-Coder-V2-Instruct
    - https://huggingface.co/deepseek-ai/DeepSeek-Coder-V2-Instruct-0724
    - https://huggingface.co/deepseek-ai/DeepSeek-Coder-V2-Lite-Base
    - https://huggingface.co/deepseek-ai/DeepSeek-Coder-V2-Lite-Instruct


```sh
mkdir $HOME/llm-models
```


# Other resources
1. TODO
