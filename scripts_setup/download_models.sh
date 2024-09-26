#!/bin/bash

# Télécharger plusieurs fichiers

# Checkpoint
#wget -O checkpoints/darksun_v41.safetensors "https://civitai.com/api/download/models/130121?type=Model&format=SafeTensor&size=full&fp=fp32"
wget -O checkpoints/Counterfeit-V3.0_fp16.safetensors https://huggingface.co/gsdf/Counterfeit-V3.0/resolve/main/Counterfeit-V3.0_fp16.safetensors
# Clip vision
wget -O clip_vision/clip-vit-large-patch14.safetensors https://huggingface.co/openai/clip-vit-large-patch14/resolve/main/model.safetensors

# ControlNet
wget -O controlnet/control_v11p_sd15_inpaint.safetensors https://huggingface.co/lllyasviel/control_v11p_sd15_inpaint/resolve/main/diffusion_pytorch_model.safetensors

# Style_models     
wget -O style_models/coadapter-style-sd15v1.pth https://huggingface.co/TencentARC/T2I-Adapter/resolve/main/models/coadapter-style-sd15v1.pth

#upscale_models
wget -O upscale_models/4x_NMKD-Superscale-SP_178000_G.pth https://huggingface.co/gemasai/4x_NMKD-Superscale-SP_178000_G/resolve/main/4x_NMKD-Superscale-SP_178000_G.pth 

#wget -O upscale_models/4x_NMKD_Superscale.safetensors https://civitai.com/api/download/models/141491

# Gérer les erreurs
if [ $? -ne 0 ]; then
  echo "Erreur lors du téléchargement"
  exit 1
fi