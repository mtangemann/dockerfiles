ARG BASE=nvidia/cuda:11.1-cudnn8-devel-ubuntu18.04
FROM $BASE

LABEL maintainer="matthias.tangemann@bethgelab.org"


ARG LOCALE="en_US.UTF-8"
RUN apt-get update \
 && apt-get install -yq --no-install-recommends \
    bzip2 \
    ca-certificates \
    git \
    locales \
    dropbear \
    wget \
 && apt-get clean && rm -rf /var/lib/apt/lists/* \
 && locale-gen $LOCALE


# --- Miniconda ---
# See https://repo.anaconda.com/miniconda/ for version information
ARG CONDA_PATH="/opt/conda"
ARG MINICONDA_VERSION="4.9.2"
ARG MINICONDA_CHECKSUM="122c8c9beb51e124ab32a0fa6426c656"
ARG PYTHON_VERSION="default"

ENV PATH=$CONDA_PATH/bin:$PATH

WORKDIR /tmp
RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda3-py38_${MINICONDA_VERSION}-Linux-x86_64.sh \
 && echo "${MINICONDA_CHECKSUM} *Miniconda3-py38_${MINICONDA_VERSION}-Linux-x86_64.sh" | md5sum -c - \
 && /bin/bash Miniconda3-py38_${MINICONDA_VERSION}-Linux-x86_64.sh -f -b -p $CONDA_PATH \
 && rm Miniconda3-py38_${MINICONDA_VERSION}-Linux-x86_64.sh \
 && if [ ! $PYTHON_VERSION = "default" ]; then conda install --yes python=$PYTHON_VERSION; fi
