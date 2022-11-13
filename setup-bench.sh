git clone https://github.com/CompVis/stable-diffusion.git

cd stable-diffusion
conda env create -f environment.yaml
conda activate ldm

# Log in to huggingface to access sd model
huggingface-cli login

cd ..

# Install bench server deps
pip install Flask
pip install gunicorn

# Launch the server
gunicorn -b :5000 --timeout=20 server:app