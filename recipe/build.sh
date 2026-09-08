#!/bin/bash
set -euo pipefail

# Isolate the build.
mkdir -p build
cd build

# Generate the build files.
echo "Configuring the build..."
cmake .. ${CMAKE_ARGS} \
      -G Ninja \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_DOCS=OFF \
      -DBUILD_MOCK=OFF

# Build.
echo "Building..."
cmake --build . --parallel $CPU_COUNT

# Perform tests.
#  echo "Testing..."
#  ninja test || exit 1
#  path_to/test || exit 1
#  ctest -VV --output-on-failure || exit 1

# Install.
echo "Installing..."
cmake --install .
