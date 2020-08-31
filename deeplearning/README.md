# deeplearning

Extension of jupyter/base-notebook with CUDA and PyTorch.

This image is based on *Ubuntu 18.04* and currently provides the following
software:

| Package        | Version        |
| :------------- | :------------- |
| conda          | 4.8.3          |
| CUDA           | 11.0.3         |
| cuDNN          | 8.0.2.39       |
| Python         | 3.8.5          |
| PyTorch        | 1.6.0          |
| torchvision    | 0.7.0          |


## Changelog

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
