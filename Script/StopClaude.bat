@echo off
setlocal

:: The container name you used in StartClaude.bat
set "CONTAINER_NAME=claude-dev1"

echo Stopping Claude container...
docker stop %CONTAINER_NAME%


pause