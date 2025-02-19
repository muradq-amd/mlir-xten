#
# This file is licensed under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
# (c) Copyright 2021 Xilinx, Inc. All Rights reserved.
# (c) Copyright 2022 - 2024 Advanced Micro Devices, Inc. All Rights reserved.

# Specifies that all MLIR packages are co-located under the `mlir_xten`
# top level package (the API has been embedded in a relocatable way).
# TODO: Add an upstream cmake param for this vs having a global here.
include(AddMLIRPython)

add_compile_definitions("MLIR_PYTHON_PACKAGE_PREFIX=mlir_xten.")

################################################################################
# Sources
################################################################################
declare_mlir_python_sources(xtenPythonSources)

declare_mlir_dialect_python_bindings(
  ADD_TO_PARENT xtenPythonSources
  ROOT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/mlir_xten"
  TD_FILE dialects/XTenNNOps.td
  SOURCES
    dialects/xten_nn.py
  DIALECT_NAME xten_nn)

declare_mlir_python_extension(xtenPythonSources.Extension
  MODULE_NAME _xten_nnDialects
  ADD_TO_PARENT xtenPythonSources
  SOURCES
  XtenExtension.cpp
  EMBED_CAPI_LINK_LIBS
    XTenCAPI
)

################################################################################
# Common CAPI
################################################################################
add_mlir_python_common_capi_library(xtenPythonCAPI
  INSTALL_COMPONENT xtenPythonModules
  INSTALL_DESTINATION python_packages/xten/mlir_xten/_mlir_libs
  OUTPUT_DIRECTORY "${MLIR_BINARY_DIR}/python_packages/xten/mlir_xten/_mlir_libs"
  RELATIVE_INSTALL_ROOT "../../../.."
  DECLARED_SOURCES
    xtenPythonSources
    # TODO: Remove this in favor of showing fine grained registration once
    # available.
    MLIRPythonExtension.RegisterEverything
    MLIRPythonSources.Core
)

################################################################################
# Instantiation of all Python modules
################################################################################
add_mlir_python_modules(xtenPythonModules
  ROOT_PREFIX "${MLIR_BINARY_DIR}/python_packages/xten/mlir_xten"
  INSTALL_PREFIX "python_packages/xten/mlir_xten"
  DECLARED_SOURCES
    xtenPythonSources
    # TODO: Remove this in favor of showing fine grained registration once
    # available.
    MLIRPythonExtension.RegisterEverything
    MLIRPythonSources
  COMMON_CAPI_LINK_LIBS
    xtenPythonCAPI
  )
