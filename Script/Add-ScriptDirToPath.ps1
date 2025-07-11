# Get the directory of the running script
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Get current user's PATH environment variable
$currentPath = [Environment]::GetEnvironmentVariable("PATH", "User")

# Check if it's already in PATH
if ($currentPath -split ";" | Where-Object { $_ -eq $scriptDir }) {
    Write-Host "[INFO] Script directory already in PATH:" -ForegroundColor Yellow
    Write-Host "       $scriptDir"
} else {
    # Append it
    $newPath = "$currentPath;$scriptDir"
    [Environment]::SetEnvironmentVariable("PATH", $newPath, "User")
    Write-Host "[SUCCESS] Script directory added to PATH:" -ForegroundColor Green
    Write-Host "          $scriptDir"
}

# Update current session's PATH
$env:PATH += ";$scriptDir"
