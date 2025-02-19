<!--- (c) Copyright 2021 Xilinx, Inc. All Rights reserved.--->
<!--- (c) Copyright 2022 - 2024 Advanced Micro Devices, Inc. All Rights reserved.--->

# Extensions to Torch-MLIR

![](https://mlir.llvm.org//mlir-logo.png)

This repository contains Xilinx extensions to the torch-mlir ATen dialect to enable expressing the input and output of partial results. Using these extensions, a prototype streaming dataflow exploration tool scans the design space for compute/memory/computation balanced partitioning of CNNs on the AIE array of Xilinx' Versal devices.

[Full Documentation](https://xilinx.github.io/mlir-xten/)

## How to Build

This section explains how to build mlir-xten python package.

### Clone and setup mlir-xten repo
git clone https://github.com/Xilinx/mlir-xten.git
cd mlir-xten
git submodule update --init --recursive

### Create a virtual Env
conda create --name mlirdev python=3.10
conda activate mlirdev

### Install requirements
// Reuse the requirements from mlir. mlir-xten is an extension to mlir and should work under the same environment.
pip install --upgrade pip
pip install -r ./llvm-project/mlir/python/requirements.txt

### Install conda packages
conda install conda-forge::ninja 
conda install conda-forge::sccache

### Setup Env variables
setenv PATH /group/xrlabs/tools/x86_64_RHEL7_clang12/bin:${PATH}
setenv PATH /tools/batonroot/rodin/devkits/lnx64/gcc-10.2.0/bin:${PATH}
setenv LD_LIBRARY_PATH /group/xrlabs/tools/x86_64_RHEL7_clang12/lib:${LD_LIBRARY_PATH}
setenv LD_LIBRARY_PATH /tools/batonroot/rodin/devkits/lnx64/gcc-10.2.0/lib64:${LD_LIBRARY_PATH}

### Build LLVM and MLIR
cmake -GNinja \
    -Bbuild \
    llvm-project/llvm \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER=clang-12 \
    -DCMAKE_CXX_COMPILER=clang++-12 \
    -DLLVM_ENABLE_PROJECTS="llvm;mlir" \
    -DLLVM_TARGETS_TO_BUILD=host \
    -DCMAKE_INSTALL_PREFIX=../install \
    -DLLVM_BUILD_EXAMPLES=ON \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DLLVM_BUILD_TOOLS=ON \
    -DLLVM_BUILD_UTILS=ON \
    -DLLVM_BUILD_RUNTIMES=ON \
    -DCMAKE_C_COMPILER_LAUNCHER=sccache \
    -DCMAKE_CXX_COMPILER_LAUNCHER=sccache \
    -DMLIR_ENABLE_BINDINGS_PYTHON=ON  | & tee cmake.log

cmake --build build
cmake --build build --target install


-----
<p align="center">Copyright&copy; 2019-2021 Xilinx</p>
