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

- [Qwen](https://huggingface.co/Qwen)    
    1. `https://huggingface.co/Qwen/Qwen2.5-Coder-14B-Instruct-GGUF`          (default to this)
    2. `https://huggingface.co/Qwen/Qwen2.5-Coder-7B-Instruct-GGUF`           (only if 14b too slow)
    3. `https://huggingface.co/Qwen/Qwen2.5-Coder-32B-Instruct-GGUF`          (might be too slow)
- [deepseek-ai](https://huggingface.co/deepseek-ai)
    1. `https://huggingface.co/deepseek-ai/DeepSeek-Coder-V2-Lite-Instruct`
    2. `https://huggingface.co/deepseek-ai/deepseek-coder-33b-instruct`       (might be too slow)
    3. `https://huggingface.co/deepseek-ai/deepseek-coder-7b-instruct-v1.5`   (only if others too slow)


```sh
mkdir $HOME/llm-models
```


# Other resources
1. TODO
