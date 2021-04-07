# deeplearning-base

This image provides everything required for typical deep learning projects
except Python packages, since those usually depend on the project. In essence,
this extends [`nvidia/cuda`](https://hub.docker.com/r/nvidia/cuda) with
commonly used tools (such as git or wget) and Python provided by
[Miniconda](https://docs.conda.io/en/latest/miniconda.html).


## Build
The [Makefile](Makefile) provides targets for building common versions of this
image, e.g.

```sh
make latest
```


## Changelog

### v1 (2020-04-07)
Initial version.
Based on Ubuntu 18.04, provides CUDA 11.1 and Python 3.8.
