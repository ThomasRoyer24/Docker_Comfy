FROM pytorch/pytorch:2.3.0-cuda12.1-cudnn8-runtime

ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1

# Installer les dépendances nécessaires pour ajouter Python 3.10
RUN apt-get update && \
    apt-get install -y git wget software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.10 python3.10-dev python3.10-distutils && \
    apt-get clean

# Mettre à jour les alternatives pour que python pointe vers python3.10
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1 && \
    update-alternatives --set python3 /usr/bin/python3.10

# Installer pip pour Python 3.10
RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python3.10 get-pip.py && \
    rm get-pip.py

ENV ROOT=/stable-diffusion

RUN --mount=type=cache,target=/root/.cache/pip \
  git clone https://github.com/comfyanonymous/ComfyUI.git ${ROOT} && \
  cd ${ROOT} && \
  git checkout master && \
  git reset --hard 276f8fce9f5a80b500947fb5745a4dde9e84622d && \
  python3.10 -m pip install -r requirements.txt


RUN apt update && apt install -y wget


# Download models
WORKDIR ${ROOT}/models
COPY scripts_setup/download_models.sh download_models.sh
RUN chmod +x download_models.sh
#RUN ./download_models.sh


# Install requirement for python code
WORKDIR ${ROOT}
RUN mkdir "python_code"

# Copy model to save time on local computer
COPY scripts_setup/model_deplacement.sh model_deplacement.sh
RUN chmod +x model_depacement.sh

# Script to setup the comfy environment
COPY scripts_setup/start_setup.sh start_setup.sh


# Install requirement for python code 
WORKDIR ${ROOT}/python_code
COPY scripts_setup/requirements.txt requirements.txt 
RUN python3.10 -m pip install -r requirements.txt

# Clone the workflow repository
RUN git clone https://github.com/ThomasRoyer24/Generate_video_comfyui.git

# Download custom nodes
WORKDIR ${ROOT}/custom_nodes
COPY scripts_setup/custom_nodes.txt custom_nodes.txt
RUN while read repo; do git clone "$repo"; done < custom_nodes.txt


WORKDIR ${ROOT}
COPY . /docker/

ENV NVIDIA_VISIBLE_DEVICES=all PYTHONPATH="${PYTHONPATH}:${PWD}" CLI_ARGS=""
EXPOSE 7860
EXPOSE 5000

CMD ["/bin/bash"]


