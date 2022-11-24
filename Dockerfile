FROM tensorflow/tensorflow:2.10.0-gpu

RUN rm -rf /usr/local/cuda/lib64/stubs

COPY requirements.txt /

RUN pip install -r requirements.txt \
  --extra-index-url https://download.pytorch.org/whl/cu117

RUN useradd -m huggingface

USER huggingface

WORKDIR /home/huggingface

ENV USE_TORCH=1

RUN mkdir -p /home/huggingface/.cache/huggingface

COPY server.py /usr/local/bin

EXPOSE 5000

CMD ["gunicorn" , "-b", ":5000", "-t", "3600", "server:app"]
