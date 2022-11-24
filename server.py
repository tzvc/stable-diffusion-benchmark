#!/usr/bin/env python
from flask import Flask, request, send_file
from flask_cors import CORS
import io
import os
import torch
from torch import autocast
from diffusers import StableDiffusionPipeline

app = Flask(__name__)
CORS(app)

assert torch.cuda.is_available()
pipe = StableDiffusionPipeline.from_pretrained(
    "CompVis/stable-diffusion-v1-4",
    use_auth_token=os.environ['HUGGINGFACE_TOKEN']
).to("cuda")


def run_inference(prompt):
    with autocast("cuda"):
        image = pipe(prompt).images[0]
    img_data = io.BytesIO()
    image.save(img_data, "PNG")
    img_data.seek(0)
    return img_data


@app.route('/')
def myapp():
    if "prompt" not in request.args:
        return "Please specify a prompt parameter", 400
    prompt = request.args["prompt"]
    img_data = run_inference(prompt)
    return send_file(img_data, mimetype='image/png')
