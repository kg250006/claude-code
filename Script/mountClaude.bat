@echo off
setlocal enabledelayedexpansion

:: === AUTO-DETECT WORKSPACE ===
set "WORKSPACE_PATH=%CD%"
for %%F in ("%CD%") do set "FOLDER_NAME=%%~nxF"
set "CONTAINER_NAME=claude-%FOLDER_NAME%"
set "CONTAINER_MOUNT=/workspace"

:: === LOG INFO ===
echo [INFO] Workspace path: %WORKSPACE_PATH%
echo [INFO] Container name: %CONTAINER_NAME%
echo.

:: === EXECUTION ===
docker run ^
  --name %CONTAINER_NAME% ^
  --mount type=bind,src="%WORKSPACE_PATH%",dst="%CONTAINER_MOUNT%" ^
  -u 0 ^
  -w %CONTAINER_MOUNT% ^
  -it claude-code ^
  /bin/bash

pause
