ARG BASE_CONTAINER=jupyter/base-notebook
FROM $BASE_CONTAINER

LABEL maintainer="matthias.tangemann@bethgelab.org"


# ---- install NVIDIA libraries -----

# based on
# https://github.com/bethgelab/docker-deeplearning/blob/future/deeplearning/Dockerfile, 2020-03-12

# switch to root for installing software via apt-get
USER root

# setup NVIDIA's CUDA repositories
RUN apt-get update \
 && apt-get install -y --no-install-recommends gnupg2 curl ca-certificates \
 && curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub | apt-key add - \
 && echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list \
 && echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list \
 && apt-get purge --autoremove -y curl \
 && rm -rf /var/lib/apt/lists/*

# REVIEW can the following ENV statements be replaced? e.g. using build args?

# define versions of general cuda libraries
# https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/
ENV CUDA_MAJOR   11
ENV CUDA_MINOR   0
ENV CUDA_PATCH   3
ENV CUDA_VERSION $CUDA_MAJOR.$CUDA_MINOR.$CUDA_PATCH
ENV CUDA_POSTFIX $CUDA_MAJOR-$CUDA_MINOR

ENV CUDA_PKG_VERSION     $CUDA_VERSION-1
ENV CUDA_COMPAT_VERSION  450.51.06-1
ENV CUDA_CUDART_VERSION  11.0.221-1
ENV CUDA_NVTX_VERSION    11.0.167-1
ENV CUDA_NVML_VERSION    11.0.167-1

# define versions of cuda machine learning libraries
# https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64
ENV CUDNN_MAJOR   8
ENV CUDNN_VERSION $CUDNN_MAJOR.0.2.39-1+cuda$CUDA_MAJOR.$CUDA_MINOR
ENV NCCL_VERSION  2.7.8-1+cuda$CUDA_MAJOR.$CUDA_MINOR

# IDEA The NVIDIA repository provides a CUDA meta-package named "cuda". This could potentially simplify the install process.
RUN apt-get update && apt-get install -y --no-install-recommends \
        cuda-command-line-tools-$CUDA_POSTFIX=$CUDA_PKG_VERSION \
        cuda-compat-$CUDA_POSTFIX=$CUDA_COMPAT_VERSION \
        cuda-cudart-$CUDA_POSTFIX=$CUDA_CUDART_VERSION \
        cuda-libraries-$CUDA_POSTFIX=$CUDA_PKG_VERSION \
        cuda-libraries-dev-$CUDA_POSTFIX=$CUDA_PKG_VERSION \
        cuda-minimal-build-$CUDA_POSTFIX=$CUDA_PKG_VERSION \
        cuda-nvml-dev-$CUDA_POSTFIX=$CUDA_NVML_VERSION \
        cuda-nvtx-$CUDA_POSTFIX=$CUDA_NVTX_VERSION \
        libcudnn$CUDNN_MAJOR=$CUDNN_VERSION \
        libcudnn$CUDNN_MAJOR-dev=$CUDNN_VERSION \
        libnccl2=$NCCL_VERSION \
        libnccl-dev=$NCCL_VERSION \
 && ln -s cuda-$CUDA_MAJOR.$CUDA_MINOR /usr/local/cuda \
 && apt-mark hold libnccl2 libcudnn$CUDNN_MAJOR \
 && rm -rf /var/lib/apt/lists/*

ENV PATH /usr/local/cuda/bin:${PATH}
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=11.0 brand=tesla,driver>=450,driver<451"
ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs

# switch back to default user (jovyan)
USER $NB_USER


# ----- install python packages -----

RUN conda install -y -c pytorch pytorch=1.6.0 torchvision=0.7.0
