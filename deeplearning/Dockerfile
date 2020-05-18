ARG BASE_CONTAINER=jupyter/scipy-notebook
FROM $BASE_CONTAINER


# ---- install NVIDIA libraries -----

# switch to root for installing software via apt-get
USER root

# https://github.com/bethgelab/docker-deeplearning/blob/future/deeplearning/Dockerfile, 2020-03-12
RUN apt-get update && apt-get install -y --no-install-recommends gnupg2 curl ca-certificates && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub | apt-key add - && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
    echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get purge --autoremove -y curl && \
    rm -rf /var/lib/apt/lists/*
ENV CUDA_VERSION 10.0.130
ENV CUDA_PKG_VERSION 10-0=$CUDA_VERSION-1
ENV NCCL_VERSION 2.3.5
ENV CUDNN_VERSION 7.3.1.20
RUN apt-get update && apt-get install -y --no-install-recommends \
        cuda-cudart-$CUDA_PKG_VERSION \
        cuda-compat-10-0=410.48-1 \
        cuda-libraries-$CUDA_PKG_VERSION \
        cuda-nvtx-$CUDA_PKG_VERSION \
        libnccl2=$NCCL_VERSION-2+cuda10.0 \
        cuda-libraries-dev-$CUDA_PKG_VERSION \
        cuda-nvml-dev-$CUDA_PKG_VERSION \
        cuda-minimal-build-$CUDA_PKG_VERSION \
        cuda-command-line-tools-$CUDA_PKG_VERSION \
        libnccl-dev=$NCCL_VERSION-2+cuda10.0 \
        libcudnn7=$CUDNN_VERSION-1+cuda10.0 \
        libcudnn7-dev=$CUDNN_VERSION-1+cuda10.0 && \
    ln -s cuda-10.0 /usr/local/cuda && \
    apt-mark hold libnccl2 libcudnn7 && \
    rm -rf /var/lib/apt/lists/*
ENV PATH /usr/local/cuda/bin:${PATH}
# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=10.0 brand=tesla,driver>=384,driver<385"
ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs


# ----- setup openssh-sever -----

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        openssh-server \
 && rm -rf /var/lib/apt/lists/*

EXPOSE 22
RUN mkdir /var/run/sshd

# allow ssh login using publickey
# sshd requires the home and .ssh directories and the authorized_keys file to be writable only by the owner, but
# the jupyter containers rely on group permissions to allow write access to the home directory. Therefore, the config
# is adapted to use a different authorized_keys file from /home/private. This directory is created by the startup
# hook with the right permissions.
RUN sed -i 's/#PubkeyAuthentication/PubkeyAuthentication/' /etc/ssh/sshd_config \
 && sed -i 's/#AuthorizedKeysFile/AuthorizedKeysFile \/home\/private\/.ssh\/authorized_keys/' /etc/ssh/sshd_config
COPY hook.sh /usr/local/bin/before-notebook.d/

# switch back to default user (jovyan)
USER $NB_USER


# ----- install python packages -----

# Builds of PyTorch 1.5 don't support CUDA 10.0 anymore
RUN pip install torch==1.4.0+cu100 torchvision==0.5.0+cu100 -f https://download.pytorch.org/whl/torch_stable.html

# FIXME speed up conda environment solving and replace above pip packages
#RUN conda install pytorch=1.4.* torchvision=0.5.* -c pytorch \
# && conda clean --all -f -y \
# && fix-permissions $CONDA_DIR \
# && fix-permissions /home/$NB_USER
