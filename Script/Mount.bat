@echo off
setlocal

:: === CONFIGURATION ===
set "CONTAINER_NAME=claude-dev1"
set "WORKSPACE_PATH=C:\PROJECTS\claude-workspace"
set "CONTAINER_MOUNT=/workspace"

:: === EXECUTION ===
docker run ^
  --name %CONTAINER_NAME% ^
  --mount type=bind,src="%WORKSPACE_PATH%",dst="%CONTAINER_MOUNT%" ^
  -u 0 ^
  -it claude-code ^
  /bin/bash

pause
