# Script to clean unnecessary files for Azure Web App deployment

# Remove Docker-related files as Azure Web App doesn't need them
Remove-Item -Path docker -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path .dockerignore -Force -ErrorAction SilentlyContinue
Remove-Item -Path heroku.yml -Force -ErrorAction SilentlyContinue

# Remove cloud deployment scripts for other platforms
Remove-Item -Path cloud -Recurse -Force -ErrorAction SilentlyContinue

# Keep only necessary GitHub workflows
if (Test-Path .github/workflows/azure-deploy.yml) {
    $backupDir = New-Item -Path ".github/workflows_backup" -ItemType Directory -Force
    Copy-Item -Path .github/workflows/azure-deploy.yml -Destination $backupDir -Force
    Remove-Item -Path .github/workflows -Recurse -Force
    New-Item -Path .github/workflows -ItemType Directory -Force
    Copy-Item -Path "$backupDir/azure-deploy.yml" -Destination .github/workflows/ -Force
    Remove-Item -Path $backupDir -Recurse -Force
} else {
    Write-Host "Azure deployment workflow not found. Skipping workflow cleanup."
}

Write-Host "Cleaned unnecessary files for Azure Web App deployment" 