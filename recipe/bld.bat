:: Isolate the build.
mkdir build
cd build
if errorlevel 1 exit /b 1

:: Generate the build files.
echo "Configuring the build..."
cmake .. %CMAKE_ARGS% ^
      -G "Ninja" ^
      -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
      -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DBUILD_DOCS=OFF ^
      -DBUILD_MOCK=OFF

:: Build.
echo "Building..."
cmake --build . --parallel %CPU_COUNT%
if errorlevel 1 exit /b 1

:: Perform tests.
::  echo "Testing..."
::  ninja test
::  path_to\test
::  ctest -VV --output-on-failure
::  if errorlevel 1 exit /b 1

:: Install.
echo "Installing..."
cmake --install .
if errorlevel 1 exit /b 1
