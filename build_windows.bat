@echo off
rem ====================================================================
rem  LegaiaRecomp - Windows Native PC Build Script
rem  Legend of Legaia (SCUS-94254) Static Recompilation
rem ====================================================================
setlocal enabledelayedexpansion

echo ====================================================================
echo  LegaiaRecomp: Building Legend of Legaia for Windows x64
echo ====================================================================
echo.

where cmake >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [ERROR] CMake is not found on your PATH.
    echo Please install CMake from https://cmake.org/download/ and add it to PATH.
    pause
    exit /b 1
)

echo [1/2] Configuring CMake for 64-bit Windows...
cmake -S . -B build-windows -G "Visual Studio 17 2022" -A x64
if %ERRORLEVEL% neq 0 (
    echo.
    echo [INFO] Visual Studio 2022 generator not found. Trying Ninja / default toolchain...
    cmake -S . -B build-windows -DCMAKE_BUILD_TYPE=Release
    if %ERRORLEVEL% neq 0 (
        echo [ERROR] CMake configuration failed.
        pause
        exit /b 1
    )
)

echo.
echo [2/2] Compiling psx-runtime (Release)...
cmake --build build-windows --config Release --target psx-runtime
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Compilation failed.
    pause
    exit /b 1
)

echo.
echo ====================================================================
echo  BUILD SUCCESSFUL!
echo.
echo  The executable has been built under:
echo    build-windows\Release\Legaia_Recompiled.exe
echo    (or build-windows\Legaia_Recompiled.exe)
echo.
echo  To play:
echo    1. Ensure your Legend of Legaia (USA).cue and .bin are accessible.
echo    2. Run Legaia_Recompiled.exe
echo    3. Both Indonesian localization and Vahn Blazing Slash mod
echo       are bundled and enabled by default in mods\bundled\
echo ====================================================================
pause
