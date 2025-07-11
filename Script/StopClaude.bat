@echo off
setlocal

:: The container name you used in StartClaude.bat
::set "CONTAINER_NAME=claude-dev1"

:: === AUTO-DETECT WORKSPACE ===
set "WORKSPACE_PATH=%CD%"
for %%F in ("%CD%") do set "FOLDER_NAME=%%~nxF"
set "CONTAINER_NAME=claude-%FOLDER_NAME%"
set "CONTAINER_MOUNT=/workspace"

:: === LOG INFO ===
echo [INFO] Workspace path: %WORKSPACE_PATH%
echo [INFO] Container name: %CONTAINER_NAME%
echo.


echo Stopping Claude container...
docker stop %CONTAINER_NAME%


pause