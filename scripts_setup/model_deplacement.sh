#!/bin/bash

# Dossier source
SOURCE_DIR="../data"

# Copier chaque fichier dans son dossier cible
cp "$SOURCE_DIR/Counterfeit-V3.0_fp16.safetensors" "models/checkpoints/"
cp "$SOURCE_DIR/clip-vit-large-patch14.safetensors" "models/clip_vision/"
cp "$SOURCE_DIR/control_v11p_sd15_inpaint.safetensors" "models/controlnet/"
cp "$SOURCE_DIR/coadapter-style-sd15v1.pth" "models/style_models/"
cp "$SOURCE_DIR/4x_NMKD-Superscale-SP_178000_G.pth" "models/upscale_models/"