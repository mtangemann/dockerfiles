# deeplearning

Image providing CUDA, Python and packages typically used in deep learning projects.

This image can be used to get started quickly. When customizations become necessary, consider deriving an image from [deeplearning-base](../deeplearning-base/README.md).


## Changelog

### v3 (2021-04-07)
The image is now derived from `deeplearning-base`, which is now used as the base image for deep learning projects. This image extends the base image with typical packages and can be used to get started quickly.


### v2 (2020-08-31)
This version brings some major changes compared to the previous version:

- Changed base container to `jupyter/base-notebook`: The scipy container which
  has been used before brings many unneeded python packages slowing down conda.
  The intention of this docker image is to provide a minimal setup of
  essential deep learning packages used in my projects, so deriving from
  Jupyter's base container is much more adequate.

- Removed the ssh server: My workflow has changed, I don't need to access the
  container via the network anymore.

Moreover, the entire software stack was updated. This image now contains the
following software:

- CUDA 11.0
- cuDNN 8.0
- Python 3.8.5
- PyTorch 1.6.0
- torchvision 0.7.0


### v1 (2020-05-18)
First version. CUDA=10.0, cuDNN=7.3, torch=1.4
