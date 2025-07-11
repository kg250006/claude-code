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

:: === CHECK IF CONTAINER EXISTS ===
docker container inspect %CONTAINER_NAME% >nul 2>&1
if %ERRORLEVEL%==0 (
    :: Check if it's running
    docker inspect -f "{{.State.Running}}" %CONTAINER_NAME% 2>nul | findstr /C:"true" >nul
    if %ERRORLEVEL%==0 (
        echo [INFO] Container is already running. Attaching via docker exec...
        docker exec -u 0 -it %CONTAINER_NAME% bash
    ) else (
        echo [INFO] Container exists but is not running. Starting container...
        docker start %CONTAINER_NAME%
        echo [INFO] Attaching to restarted container...
        docker exec -u 0 -it %CONTAINER_NAME% bash
    )
) else (
    echo [INFO] Container does not exist. Starting new container...
    docker run ^
        --name %CONTAINER_NAME% ^
        --mount type=bind,src="%WORKSPACE_PATH%",dst="%CONTAINER_MOUNT%" ^
        -u 0 ^
        -w %CONTAINER_MOUNT% ^
        -it claude-code ^
        /bin/bash
)

pause
