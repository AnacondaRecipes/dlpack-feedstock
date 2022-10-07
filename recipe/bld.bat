:: cmd
echo "Building %PKG_NAME%."


:: Isolate the build.
mkdir Build-%PKG_NAME%
cd Build-%PKG_NAME%
if errorlevel 1 exit /b 1


:: Generate the build files.
echo "Generating the build files..."
cmake .. %CMAKE_ARGS% ^
      -G"Ninja" ^
      -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
      -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -DCMAKE_BUILD_TYPE=Release ^
      ^
      -DBUILD_DOCS=OFF


:: Build.
echo "Building..."
ninja -j%CPU_COUNT%
if errorlevel 1 exit /b 1


:: Perform tests.
::  echo "Testing..."
::  ninja test
::  path_to\test
::  ctest -VV --output-on-failure
::  if errorlevel 1 exit /b 1


:: Install.
echo "Installing..."
ninja install
if errorlevel 1 exit /b 1

:: The following is a bit of a hack. A PR should be created to add mock to the installation target in the upstream CMakeLists.txt file.
mkdir  %PREFIX%\bin
cp ..\bin\mock.exe %PREFIX%\bin\
if errorlevel 1 exit /b 1


:: Error free exit.
echo "Error free exit!"
exit 0
