echo ON

%PYTHON% %RECIPE_DIR%\\filter.py --src=%PREFIX%\\Library --dst=filtered.pkl
if errorlevel 1 exit 1

cmake -G "NMake Makefiles" ^
      -D CMAKE_INSTALL_PREFIX=%PREFIX% ^
      -D USE_PYTHON_INCLUDE_DIR=ON ^
      -D PYBIND11_TEST=OFF ^
      ..
if errorlevel 1 exit 1

nmake
if errorlevel 1 exit 1

nmake install
if errorlevel 1 exit 1

set PYBIND11_USE_CMAKE=1
cd ..
%PYTHON% setup.py install --single-version-externally-managed --record record.txt
if errorlevel 1 exit 1

%PYTHON% %RECIPE_DIR%\\move.py --src=%PREFIX%\\Library\\include --dst=%SRC_DIR%\\Library\\include --filtered=filtered.pkl
%PYTHON% %RECIPE_DIR%\\move.py --src=%PREFIX%\\Library\\lib --dst=%SRC_DIR%\\Library\\lib --filtered=filtered.pkl
%PYTHON% %RECIPE_DIR%\\move.py --src=%PREFIX%\\Library\\bin --dst=%SRC_DIR%\\Library\\bin --filtered=filtered.pkl

echo OFF