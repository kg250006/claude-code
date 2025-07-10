@echo off
setlocal

:: The container name you used in StartClaude.bat
set "CONTAINER_NAME=claude-dev1"

docker exec -u 0 -it %CONTAINER_NAME% bash


pause