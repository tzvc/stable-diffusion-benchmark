
#!/bin/sh

set -eu

CWD=$(basename "$PWD")

docker run --rm --gpus=all \
    -v huggingface:/home/huggingface/.cache/huggingface \
    -v "$PWD"/input:/home/huggingface/input \
    -v "$PWD"/output:/home/huggingface/output \
    -e HUGGINGFACE_TOKEN=$HUGGINGFACE_TOKEN \
    -it $1