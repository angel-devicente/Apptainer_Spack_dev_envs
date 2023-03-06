#!/bin/bash

export LANG=en_GB.utf8
export SPACK_ROOT=/spack/spack-0.17.3
export SPACK_USER_CONFIG_PATH=/spack/.spack
export SPACK_USER_CACHE_PATH=/spack/.spack-cache
export SPACK_PYTHON=/usr/bin/python3

cp *.yaml /spack/

cd /spack

wget -nd https://github.com/spack/spack/releases/download/v0.17.3/spack-0.17.3.tar.gz
tar -zxf spack-0.17.3.tar.gz

. $SPACK_ROOT/share/spack/setup-env.sh

# gcc's
spack install -j 40 gcc@10.3.0 gcc@9.4.0 

spack load gcc@10.3.0
spack compiler find
spack unload -a

spack load gcc@9.4.0
spack compiler find
spack unload -a

# environments
spack env create gcc_10_3_0 /spack/gcc_10_3_0.yaml
spack env create gcc_9_4_0 /spack/gcc_9_4_0.yaml

# installation

spacktivate gcc_10_3_0
spack concretize -f
spack install -j 40
despacktivate

spacktivate gcc_9_4_0
spack concretize -f
spack install -j 40
despacktivate


spack clean --all
