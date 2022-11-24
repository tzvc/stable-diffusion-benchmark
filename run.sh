
#!/bin/sh

set -eu

CWD=$(basename "$PWD")

docker run --rm --gpu-all \
    -v huggingface:/home/huggingface/.cache/huggingface \
    -v "$PWD"/input:/home/huggingface/input \
    -v "$PWD"/output:/home/huggingface/output \
    -it "$CWD"